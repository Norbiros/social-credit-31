import { Alpine as AlpineType } from 'alpinejs';
import { SupabaseClient } from '@supabase/supabase-js';

declare global {
  var Alpine: AlpineType;
  var supabase: SupabaseClient;
}
