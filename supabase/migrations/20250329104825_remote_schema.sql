alter table "public"."records" enable row level security;

alter table "public"."subscribable_total_points" enable row level security;

create policy "Enable everything for authenticated users only"
on "public"."records"
as permissive
for all
to authenticated
using (true)
with check (true);


create policy "Enable insert for authenticated users only"
on "public"."records"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for all users"
on "public"."subscribable_total_points"
as permissive
for select
to public
using (true);



