drop materialized view if exists "public"."total_points";

alter table "public"."normal_table" drop column "to_user_class";

alter table "public"."normal_table" drop column "total_from_points";

alter table "public"."normal_table" drop column "total_to_points";

alter table "public"."normal_table" add column "score" bigint;

create materialized view "public"."total_points" as  SELECT records.from_class AS user_class,
    (sum(records.to_points) - sum(records.from_points)) AS score
   FROM records
  GROUP BY records.from_class;



