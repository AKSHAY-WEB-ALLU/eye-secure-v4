-- EYE SECURE V4 shared-records schema.
-- All authenticated users can SELECT/INSERT/UPDATE/DELETE shared business records.
-- This intentionally means any registered user can edit/delete any shared record.
create extension if not exists pgcrypto;

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text default '',
  email text default '',
  address text default '',
  created_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);
create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text default '',
  unit_price numeric(12,2) not null default 0 check (unit_price >= 0),
  created_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);
create table if not exists public.documents (
  id uuid primary key default gen_random_uuid(),
  doc_type text not null check (doc_type in ('quotation','bill')),
  doc_number text not null,
  doc_date date not null default current_date,
  customer_name text not null,
  customer_phone text default '',
  customer_address text default '',
  items jsonb not null default '[]'::jsonb,
  installation numeric(12,2) not null default 0,
  discount numeric(12,2) not null default 0,
  discount_type text not null default 'fixed' check (discount_type in ('fixed','percent')),
  gst_percent numeric(5,2) not null default 0,
  subtotal numeric(12,2) not null default 0,
  grand_total numeric(12,2) not null default 0,
  notes text default '',
  created_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);
alter table public.customers enable row level security;
alter table public.products enable row level security;
alter table public.documents enable row level security;

drop policy if exists "Authenticated users can view all customers" on public.customers;
create policy "Authenticated users can view all customers" on public.customers for select to authenticated using (true);
drop policy if exists "Authenticated users can add customers" on public.customers;
create policy "Authenticated users can add customers" on public.customers for insert to authenticated with check (true);
drop policy if exists "Authenticated users can edit customers" on public.customers;
create policy "Authenticated users can edit customers" on public.customers for update to authenticated using (true) with check (true);
drop policy if exists "Authenticated users can delete customers" on public.customers;
create policy "Authenticated users can delete customers" on public.customers for delete to authenticated using (true);

drop policy if exists "Authenticated users can view all products" on public.products;
create policy "Authenticated users can view all products" on public.products for select to authenticated using (true);
drop policy if exists "Authenticated users can add products" on public.products;
create policy "Authenticated users can add products" on public.products for insert to authenticated with check (true);
drop policy if exists "Authenticated users can edit products" on public.products;
create policy "Authenticated users can edit products" on public.products for update to authenticated using (true) with check (true);
drop policy if exists "Authenticated users can delete products" on public.products;
create policy "Authenticated users can delete products" on public.products for delete to authenticated using (true);

drop policy if exists "Authenticated users can view all documents" on public.documents;
create policy "Authenticated users can view all documents" on public.documents for select to authenticated using (true);
drop policy if exists "Authenticated users can add documents" on public.documents;
create policy "Authenticated users can add documents" on public.documents for insert to authenticated with check (true);
drop policy if exists "Authenticated users can edit documents" on public.documents;
create policy "Authenticated users can edit documents" on public.documents for update to authenticated using (true) with check (true);
drop policy if exists "Authenticated users can delete documents" on public.documents;
create policy "Authenticated users can delete documents" on public.documents for delete to authenticated using (true);

grant select, insert, update, delete on public.customers, public.products, public.documents to authenticated;
