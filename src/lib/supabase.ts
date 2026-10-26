import { createClient } from '@supabase/supabase-js';

const url = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const key = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;

export const configured = Boolean(
  url && key && !url.includes('YOUR_PROJECT') && !key.includes('YOUR_SUPABASE'),
);

// App.tsx displays the setup screen whenever configuration is missing.
// A typed placeholder client prevents strict TypeScript nullability errors;
// it is not used for requests while configured is false.
export const supabase = createClient(
  url || 'https://placeholder.supabase.co',
  key || 'placeholder-publishable-key',
);
