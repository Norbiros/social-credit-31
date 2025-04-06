import './index.css';

import Alpine from 'alpinejs';
import PineconeRouter from 'pinecone-router';
// @ts-ignore
import AutoAnimate from '@marcreichel/alpine-auto-animate';

import { createClient, type SupabaseClient } from '@supabase/supabase-js';

const supabase: SupabaseClient = createClient(
  import.meta.env.PUBLIC_SUPABASE_URL,
  import.meta.env.PUBLIC_SUPABASE_ANON_KEY,
);
window.supabase = supabase;

window.Alpine = Alpine;

Alpine.plugin(PineconeRouter);
Alpine.plugin(AutoAnimate);

Alpine.start();
