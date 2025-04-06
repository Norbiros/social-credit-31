drop materialized view if exists "public"."total_points";

alter table "public"."records" add column "created_by" uuid default auth.uid();

alter table "public"."records" add column "description" text default '';

create policy "Insert proper user id"
    on "public"."records"
    for insert
    with check (auth.uid() = created_by);


create materialized view "public"."total_points" as  SELECT combined_points.class,
    sum(combined_points.total_points) AS total_points
   FROM ( SELECT records.from_class AS class,
            records.from_points AS total_points
           FROM records
        UNION ALL
         SELECT records.to_class AS class,
            records.to_points AS total_points
           FROM records) combined_points
  GROUP BY combined_points.class;



