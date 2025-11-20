-- Create reactions table for emoji reactions on guest names
CREATE TABLE IF NOT EXISTS reactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  guest_id UUID NOT NULL REFERENCES guests(id) ON DELETE CASCADE,
  emoji TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_reactions_guest_id ON reactions(guest_id);
CREATE INDEX IF NOT EXISTS idx_reactions_guest_emoji ON reactions(guest_id, emoji);

-- Enable Row Level Security (RLS)
ALTER TABLE reactions ENABLE ROW LEVEL SECURITY;

-- Allow anyone to read reactions
CREATE POLICY "Anyone can read reactions" ON reactions
  FOR SELECT USING (true);

-- Allow anyone to insert reactions
CREATE POLICY "Anyone can insert reactions" ON reactions
  FOR INSERT WITH CHECK (true);

