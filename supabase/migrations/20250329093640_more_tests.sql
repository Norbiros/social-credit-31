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

create table "public"."normal_table" (
    "user_name" text,
    "user_class" text,
    "total_from_points" bigint,
    "to_user_name" text,
    "to_user_class" text,
    "total_to_points" bigint
);


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

create materialized view "public"."total_points" as  SELECT records.from_name AS user_name,
    records.from_class AS user_class,
    sum(records.from_points) AS total_from_points,
    records.to_name AS to_user_name,
    records.to_class AS to_user_class,
    sum(records.to_points) AS total_to_points
   FROM records
  GROUP BY records.from_name, records.from_class, records.to_name, records.to_class;


CREATE OR REPLACE FUNCTION public.update_normal_table()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Your logic for handling updates from materialized view to normal table
    -- Example for updating an INSERT:
INSERT INTO normal_table SELECT NEW.*;
RETURN NEW;
END;
$function$
;

grant delete on table "public"."normal_table" to "anon";

grant insert on table "public"."normal_table" to "anon";

grant references on table "public"."normal_table" to "anon";

grant select on table "public"."normal_table" to "anon";

grant trigger on table "public"."normal_table" to "anon";

grant truncate on table "public"."normal_table" to "anon";

grant update on table "public"."normal_table" to "anon";

grant delete on table "public"."normal_table" to "authenticated";

grant insert on table "public"."normal_table" to "authenticated";

grant references on table "public"."normal_table" to "authenticated";

grant select on table "public"."normal_table" to "authenticated";

grant trigger on table "public"."normal_table" to "authenticated";

grant truncate on table "public"."normal_table" to "authenticated";

grant update on table "public"."normal_table" to "authenticated";

grant delete on table "public"."normal_table" to "service_role";

grant insert on table "public"."normal_table" to "service_role";

grant references on table "public"."normal_table" to "service_role";

grant select on table "public"."normal_table" to "service_role";

grant trigger on table "public"."normal_table" to "service_role";

grant truncate on table "public"."normal_table" to "service_role";

grant update on table "public"."normal_table" to "service_role";

CREATE TRIGGER materialized_view_update AFTER INSERT OR DELETE OR UPDATE ON public.records FOR EACH ROW EXECUTE FUNCTION update_normal_table();

CREATE TRIGGER refresh_total_points_trigger AFTER INSERT ON public.records FOR EACH STATEMENT EXECUTE FUNCTION refresh_total_points_view();


