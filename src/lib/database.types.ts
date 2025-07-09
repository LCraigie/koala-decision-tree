export interface Prospect {
  id: string
  name: string
  title: string
  company: string
  industry: string
  company_size: string
  pain_points: string[]
  priorities: string[]
  created_at: string
  updated_at: string
}

export interface ContentItem {
  id: string
  title: string
  type: 'blog' | 'doc' | 'video'
  description: string
  url: string
  tags: string[]
  relevance_score: number
  created_at: string
}

export interface CallSession {
  id: string
  prospect_id: string
  call_notes: string
  live_transcript: string
  detected_problems: string[]
  personalized_script: {
    opening: string
    discovery: string[]
    demo: string
    objections: Record<string, string>
    close: string
  }
  completed_sections: string[]
  is_active: boolean
  created_at: string
  updated_at: string
}

export interface Database {
  public: {
    Tables: {
      prospects: {
        Row: Prospect
        Insert: Omit<Prospect, 'id' | 'created_at' | 'updated_at'>
        Update: Partial<Omit<Prospect, 'id' | 'created_at' | 'updated_at'>>
      }
      content_items: {
        Row: ContentItem
        Insert: Omit<ContentItem, 'id' | 'created_at'>
        Update: Partial<Omit<ContentItem, 'id' | 'created_at'>>
      }
      call_sessions: {
        Row: CallSession
        Insert: Omit<CallSession, 'id' | 'created_at' | 'updated_at'>
        Update: Partial<Omit<CallSession, 'id' | 'created_at' | 'updated_at'>>
      }
    }
  }
} 