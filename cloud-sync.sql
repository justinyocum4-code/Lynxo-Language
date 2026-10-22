create table if not exists public.lynxo_language_progress (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.lynxo_language_progress enable row level security;

drop policy if exists "language progress select own" on public.lynxo_language_progress;
create policy "language progress select own"
  on public.lynxo_language_progress for select
  using (auth.uid() = user_id);

drop policy if exists "language progress insert own" on public.lynxo_language_progress;
create policy "language progress insert own"
  on public.lynxo_language_progress for insert
  with check (auth.uid() = user_id);

drop policy if exists "language progress update own" on public.lynxo_language_progress;
create policy "language progress update own"
  on public.lynxo_language_progress for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "language progress delete own" on public.lynxo_language_progress;
create policy "language progress delete own"
  on public.lynxo_language_progress for delete
  using (auth.uid() = user_id);
