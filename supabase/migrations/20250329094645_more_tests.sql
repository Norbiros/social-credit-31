drop trigger if exists "materialized_view_update" on "public"."records";

revoke delete on table "public"."normal_table" from "anon";

revoke insert on table "public"."normal_table" from "anon";

revoke references on table "public"."normal_table" from "anon";

revoke select on table "public"."normal_table" from "anon";

revoke trigger on table "public"."normal_table" from "anon";

revoke truncate on table "public"."normal_table" from "anon";

revoke update on table "public"."normal_table" from "anon";

revoke delete on table "public"."normal_table" from "authenticated";

revoke insert on table "public"."normal_table" from "authenticated";

revoke references on table "public"."normal_table" from "authenticated";

revoke select on table "public"."normal_table" from "authenticated";

revoke trigger on table "public"."normal_table" from "authenticated";

revoke truncate on table "public"."normal_table" from "authenticated";

revoke update on table "public"."normal_table" from "authenticated";

revoke delete on table "public"."normal_table" from "service_role";

revoke insert on table "public"."normal_table" from "service_role";

revoke references on table "public"."normal_table" from "service_role";

revoke select on table "public"."normal_table" from "service_role";

revoke trigger on table "public"."normal_table" from "service_role";

revoke truncate on table "public"."normal_table" from "service_role";

revoke update on table "public"."normal_table" from "service_role";

drop function if exists "public"."update_normal_table"();

drop materialized view if exists "public"."total_points";

drop table "public"."normal_table";

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



