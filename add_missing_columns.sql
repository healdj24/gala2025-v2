-- Add missing columns to existing guests table
-- Run this in Supabase SQL Editor if the table exists but is missing columns

-- Add paid column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'guests' 
        AND column_name = 'paid'
    ) THEN
        ALTER TABLE public.guests ADD COLUMN paid BOOLEAN DEFAULT false;
    END IF;
END $$;

-- Add verified column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'guests' 
        AND column_name = 'verified'
    ) THEN
        ALTER TABLE public.guests ADD COLUMN verified BOOLEAN DEFAULT false;
    END IF;
END $$;

-- Add guest_count column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'guests' 
        AND column_name = 'guest_count'
    ) THEN
        ALTER TABLE public.guests ADD COLUMN guest_count INTEGER DEFAULT 1;
    END IF;
END $$;

-- Add email column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'guests' 
        AND column_name = 'email'
    ) THEN
        ALTER TABLE public.guests ADD COLUMN email TEXT;
    END IF;
END $$;

-- Create indexes if they don't exist
CREATE INDEX IF NOT EXISTS idx_guests_created_at ON public.guests(created_at);
CREATE INDEX IF NOT EXISTS idx_guests_paid ON public.guests(paid);

-- Grant permissions
GRANT ALL ON public.guests TO anon;
GRANT ALL ON public.guests TO authenticated;



