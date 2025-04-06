drop trigger if exists "update_class_points_trigger" on "public"."records";

revoke delete on table "public"."class_points" from "anon";

revoke insert on table "public"."class_points" from "anon";

revoke references on table "public"."class_points" from "anon";

revoke select on table "public"."class_points" from "anon";

revoke trigger on table "public"."class_points" from "anon";

revoke truncate on table "public"."class_points" from "anon";

revoke update on table "public"."class_points" from "anon";

revoke delete on table "public"."class_points" from "authenticated";

revoke insert on table "public"."class_points" from "authenticated";

revoke references on table "public"."class_points" from "authenticated";

revoke select on table "public"."class_points" from "authenticated";

revoke trigger on table "public"."class_points" from "authenticated";

revoke truncate on table "public"."class_points" from "authenticated";

revoke update on table "public"."class_points" from "authenticated";

revoke delete on table "public"."class_points" from "service_role";

revoke insert on table "public"."class_points" from "service_role";

revoke references on table "public"."class_points" from "service_role";

revoke select on table "public"."class_points" from "service_role";

revoke trigger on table "public"."class_points" from "service_role";

revoke truncate on table "public"."class_points" from "service_role";

revoke update on table "public"."class_points" from "service_role";

drop function if exists "public"."update_class_points"();

alter table "public"."class_points" drop constraint "class_points_pkey";

drop index if exists "public"."class_points_pkey";

drop table "public"."class_points";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.refresh_total_points_view()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  refresh materialized view total_points;
return new;
end;
$function$
;

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


CREATE TRIGGER refresh_total_points_trigger AFTER INSERT ON public.records FOR EACH STATEMENT EXECUTE FUNCTION refresh_total_points_view();


