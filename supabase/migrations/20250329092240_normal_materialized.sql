drop policy "Enable insert for authenticated users only" on "public"."records";

drop materialized view if exists "public"."total_points";

alter table "public"."records" disable row level security;

create or replace view "public"."total_points" as  SELECT combined_points.class,
    sum(combined_points.total_points) AS total_points
   FROM ( SELECT records.from_class AS class,
            records.from_points AS total_points
           FROM records
        UNION ALL
         SELECT records.to_class AS class,
            records.to_points AS total_points
           FROM records) combined_points
  GROUP BY combined_points.class;



