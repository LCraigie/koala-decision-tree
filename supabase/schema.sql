-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create prospects table
CREATE TABLE prospects (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT NOT NULL,
    company TEXT NOT NULL,
    industry TEXT NOT NULL,
    company_size TEXT NOT NULL,
    pain_points TEXT[] DEFAULT '{}',
    priorities TEXT[] DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create content_items table
CREATE TABLE content_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('blog', 'doc', 'video')),
    description TEXT NOT NULL,
    url TEXT NOT NULL,
    tags TEXT[] DEFAULT '{}',
    relevance_score INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create call_sessions table
CREATE TABLE call_sessions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    prospect_id UUID REFERENCES prospects(id) ON DELETE CASCADE,
    call_notes TEXT DEFAULT '',
    live_transcript TEXT DEFAULT '',
    detected_problems TEXT[] DEFAULT '{}',
    personalized_script JSONB DEFAULT '{}',
    completed_sections TEXT[] DEFAULT '{}',
    is_active BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_prospects_company ON prospects(company);
CREATE INDEX idx_prospects_industry ON prospects(industry);
CREATE INDEX idx_content_items_type ON content_items(type);
CREATE INDEX idx_content_items_relevance ON content_items(relevance_score DESC);
CREATE INDEX idx_call_sessions_prospect ON call_sessions(prospect_id);
CREATE INDEX idx_call_sessions_active ON call_sessions(is_active);
CREATE INDEX idx_call_sessions_created ON call_sessions(created_at DESC);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_prospects_updated_at BEFORE UPDATE ON prospects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_call_sessions_updated_at BEFORE UPDATE ON call_sessions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security (RLS)
ALTER TABLE prospects ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE call_sessions ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access (you can modify these based on your auth requirements)
CREATE POLICY "Allow public read access to prospects" ON prospects
    FOR SELECT USING (true);

CREATE POLICY "Allow public read access to content_items" ON content_items
    FOR SELECT USING (true);

CREATE POLICY "Allow public read access to call_sessions" ON call_sessions
    FOR SELECT USING (true);

-- Create policies for authenticated users (modify these based on your auth setup)
CREATE POLICY "Allow authenticated users to insert prospects" ON prospects
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update prospects" ON prospects
    FOR UPDATE USING (true);

CREATE POLICY "Allow authenticated users to delete prospects" ON prospects
    FOR DELETE USING (true);

CREATE POLICY "Allow authenticated users to insert call_sessions" ON call_sessions
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update call_sessions" ON call_sessions
    FOR UPDATE USING (true);

CREATE POLICY "Allow authenticated users to delete call_sessions" ON call_sessions
    FOR DELETE USING (true);

-- Insert sample content items
INSERT INTO content_items (title, type, description, url, tags, relevance_score) VALUES
('How to Identify High-Intent Prospects with AI', 'blog', 'Learn how AI-powered intent signals can help you prioritize leads that are ready to buy.', '#', ARRAY['intent-data', 'ai', 'lead-scoring', 'sales-intelligence'], 0),
('Getting Started with Koala - Setup Guide', 'doc', 'Complete setup guide for implementing Koala in your sales process.', '#', ARRAY['setup', 'onboarding', 'implementation'], 0),
('Koala Demo: Lead Scoring in Action', 'video', '5-minute demo showing how Koala scores and prioritizes your leads automatically.', '#', ARRAY['demo', 'lead-scoring', 'product-tour'], 0),
('ROI Calculator: Measuring Sales Intelligence Impact', 'blog', 'Calculate the ROI of implementing sales intelligence tools in your organization.', '#', ARRAY['roi', 'metrics', 'business-case'], 0),
('Integration Guide: CRM + Koala', 'doc', 'Step-by-step guide for integrating Koala with Salesforce, HubSpot, and other CRMs.', '#', ARRAY['integration', 'crm', 'salesforce', 'hubspot'], 0),
('Case Study: 300% Increase in Qualified Leads', 'video', 'See how TechCorp increased their qualified leads by 300% using Koala''s intent data.', '#', ARRAY['case-study', 'results', 'success-story'], 0); 