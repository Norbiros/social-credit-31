create table "public"."subscribable_total_points" (
    "class" text not null,
    "total_points" integer not null
);


CREATE UNIQUE INDEX subscribable_total_points_pkey ON public.subscribable_total_points USING btree (class);

alter table "public"."subscribable_total_points" add constraint "subscribable_total_points_pkey" PRIMARY KEY using index "subscribable_total_points_pkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.refresh_total_points_view()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
    refresh materialized view total_points;

insert into subscribable_total_points (class, total_points)
select class, total_points
from total_points
    on conflict (class)
    do update set total_points = excluded.total_points;

return new;
end;
$function$
;

grant delete on table "public"."subscribable_total_points" to "anon";

grant insert on table "public"."subscribable_total_points" to "anon";

grant references on table "public"."subscribable_total_points" to "anon";

grant select on table "public"."subscribable_total_points" to "anon";

grant trigger on table "public"."subscribable_total_points" to "anon";

grant truncate on table "public"."subscribable_total_points" to "anon";

grant update on table "public"."subscribable_total_points" to "anon";

grant delete on table "public"."subscribable_total_points" to "authenticated";

grant insert on table "public"."subscribable_total_points" to "authenticated";

grant references on table "public"."subscribable_total_points" to "authenticated";

grant select on table "public"."subscribable_total_points" to "authenticated";

grant trigger on table "public"."subscribable_total_points" to "authenticated";

grant truncate on table "public"."subscribable_total_points" to "authenticated";

grant update on table "public"."subscribable_total_points" to "authenticated";

grant delete on table "public"."subscribable_total_points" to "service_role";

grant insert on table "public"."subscribable_total_points" to "service_role";

grant references on table "public"."subscribable_total_points" to "service_role";

grant select on table "public"."subscribable_total_points" to "service_role";

grant trigger on table "public"."subscribable_total_points" to "service_role";

grant truncate on table "public"."subscribable_total_points" to "service_role";

grant update on table "public"."subscribable_total_points" to "service_role";


