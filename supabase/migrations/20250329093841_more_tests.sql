drop materialized view if exists "public"."total_points";

alter table "public"."normal_table" drop column "to_user_name";

alter table "public"."normal_table" drop column "user_name";

set check_function_bodies = off;

create materialized view "public"."total_points" as  SELECT records.from_class AS user_class,
    sum(records.from_points) AS total_from_points,
    records.to_class AS to_user_class,
    sum(records.to_points) AS total_to_points
   FROM records
  GROUP BY records.from_class, records.to_class;


CREATE OR REPLACE FUNCTION public.update_normal_table()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Insert the new data into the normal table
INSERT INTO normal_table SELECT NEW.*;
RETURN NEW;
END;
$function$
;


