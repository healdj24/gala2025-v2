-- Create the guests table for Gala 2025 RSVP system
-- Run this in Supabase SQL Editor: https://supabase.com/dashboard/project/YOUR_PROJECT/sql

-- Create the guests table
CREATE TABLE IF NOT EXISTS public.guests (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    guest_count INTEGER DEFAULT 1,
    paid BOOLEAN DEFAULT false,
    verified BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.guests ENABLE ROW LEVEL SECURITY;

-- Create a policy that allows all operations for now (you can restrict this later)
-- This allows anyone to read, insert, update, and delete guests
CREATE POLICY "Allow all operations on guests" ON public.guests
    FOR ALL
    USING (true)
    WITH CHECK (true);

-- Create an index on created_at for faster sorting
CREATE INDEX IF NOT EXISTS idx_guests_created_at ON public.guests(created_at);

-- Create an index on paid for faster filtering
CREATE INDEX IF NOT EXISTS idx_guests_paid ON public.guests(paid);

-- Grant permissions to authenticated and anon users
GRANT ALL ON public.guests TO anon;
GRANT ALL ON public.guests TO authenticated;



