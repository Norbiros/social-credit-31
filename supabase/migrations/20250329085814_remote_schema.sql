alter table "public"."records" enable row level security;

create policy "Enable insert for authenticated users only"
on "public"."records"
as restrictive
for insert
to authenticated
with check (true);



