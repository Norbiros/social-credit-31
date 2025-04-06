create sequence "public"."records_id_seq";

create table "public"."records" (
    "id" integer not null default nextval('records_id_seq'::regclass),
    "from_name" text not null,
    "from_class" text not null,
    "from_points" integer not null,
    "to_name" text not null,
    "to_class" text not null,
    "to_points" integer not null,
    "created_at" timestamp with time zone default now()
);


alter sequence "public"."records_id_seq" owned by "public"."records"."id";

CREATE UNIQUE INDEX records_pkey ON public.records USING btree (id);

alter table "public"."records" add constraint "records_pkey" PRIMARY KEY using index "records_pkey";

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


grant delete on table "public"."records" to "anon";

grant insert on table "public"."records" to "anon";

grant references on table "public"."records" to "anon";

grant select on table "public"."records" to "anon";

grant trigger on table "public"."records" to "anon";

grant truncate on table "public"."records" to "anon";

grant update on table "public"."records" to "anon";

grant delete on table "public"."records" to "authenticated";

grant insert on table "public"."records" to "authenticated";

grant references on table "public"."records" to "authenticated";

grant select on table "public"."records" to "authenticated";

grant trigger on table "public"."records" to "authenticated";

grant truncate on table "public"."records" to "authenticated";

grant update on table "public"."records" to "authenticated";

grant delete on table "public"."records" to "service_role";

grant insert on table "public"."records" to "service_role";

grant references on table "public"."records" to "service_role";

grant select on table "public"."records" to "service_role";

grant trigger on table "public"."records" to "service_role";

grant truncate on table "public"."records" to "service_role";

grant update on table "public"."records" to "service_role";

CREATE TRIGGER refresh_total_points_trigger AFTER INSERT ON public.records FOR EACH STATEMENT EXECUTE FUNCTION refresh_total_points_view();


