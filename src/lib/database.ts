import { supabase } from './supabase'
import type { Prospect, ContentItem, CallSession } from './database.types'

// Prospect operations
export const createProspect = async (prospect: Omit<Prospect, 'id' | 'created_at' | 'updated_at'>) => {
  const { data, error } = await supabase
    .from('prospects')
    .insert(prospect)
    .select()
    .single()

  if (error) throw error
  return data
}

export const getProspects = async () => {
  const { data, error } = await supabase
    .from('prospects')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) throw error
  return data
}

export const updateProspect = async (id: string, updates: Partial<Prospect>) => {
  const { data, error } = await supabase
    .from('prospects')
    .update(updates)
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data
}

export const deleteProspect = async (id: string) => {
  const { error } = await supabase
    .from('prospects')
    .delete()
    .eq('id', id)

  if (error) throw error
}

// Content operations
export const getContentItems = async () => {
  const { data, error } = await supabase
    .from('content_items')
    .select('*')
    .order('relevance_score', { ascending: false })

  if (error) throw error
  return data
}

export const updateContentRelevance = async (id: string, relevanceScore: number) => {
  const { data, error } = await supabase
    .from('content_items')
    .update({ relevance_score: relevanceScore })
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data
}

// Call session operations
export const createCallSession = async (session: Omit<CallSession, 'id' | 'created_at' | 'updated_at'>) => {
  const { data, error } = await supabase
    .from('call_sessions')
    .insert(session)
    .select()
    .single()

  if (error) throw error
  return data
}

export const updateCallSession = async (id: string, updates: Partial<CallSession>) => {
  const { data, error } = await supabase
    .from('call_sessions')
    .update(updates)
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data
}

export const getCallSessions = async (prospectId?: string) => {
  let query = supabase
    .from('call_sessions')
    .select('*')
    .order('created_at', { ascending: false })

  if (prospectId) {
    query = query.eq('prospect_id', prospectId)
  }

  const { data, error } = await query

  if (error) throw error
  return data
}

// Real-time subscriptions
export const subscribeToCallSession = (sessionId: string, callback: (payload: any) => void) => {
  return supabase
    .channel(`call_session_${sessionId}`)
    .on('postgres_changes', {
      event: 'UPDATE',
      schema: 'public',
      table: 'call_sessions',
      filter: `id=eq.${sessionId}`
    }, callback)
    .subscribe()
} 