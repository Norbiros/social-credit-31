drop trigger if exists "refresh_total_points_trigger" on "public"."records";

drop function if exists "public"."refresh_total_points_view"();

drop view if exists "public"."total_points";

create table "public"."class_points" (
    "class" text not null,
    "total_points" integer not null default 0
);


CREATE UNIQUE INDEX class_points_pkey ON public.class_points USING btree (class);

alter table "public"."class_points" add constraint "class_points_pkey" PRIMARY KEY using index "class_points_pkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.update_class_points()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
    -- Update points for the "from_class"
insert into class_points (class, total_points)
values (new.from_class, new.from_points)
    on conflict (class)
    do update set total_points = class_points.total_points + new.from_points;

-- Update points for the "to_class"
insert into class_points (class, total_points)
values (new.to_class, new.to_points)
    on conflict (class)
    do update set total_points = class_points.total_points + new.to_points;

return new;
end;
$function$
;

grant delete on table "public"."class_points" to "anon";

grant insert on table "public"."class_points" to "anon";

grant references on table "public"."class_points" to "anon";

grant select on table "public"."class_points" to "anon";

grant trigger on table "public"."class_points" to "anon";

grant truncate on table "public"."class_points" to "anon";

grant update on table "public"."class_points" to "anon";

grant delete on table "public"."class_points" to "authenticated";

grant insert on table "public"."class_points" to "authenticated";

grant references on table "public"."class_points" to "authenticated";

grant select on table "public"."class_points" to "authenticated";

grant trigger on table "public"."class_points" to "authenticated";

grant truncate on table "public"."class_points" to "authenticated";

grant update on table "public"."class_points" to "authenticated";

grant delete on table "public"."class_points" to "service_role";

grant insert on table "public"."class_points" to "service_role";

grant references on table "public"."class_points" to "service_role";

grant select on table "public"."class_points" to "service_role";

grant trigger on table "public"."class_points" to "service_role";

grant truncate on table "public"."class_points" to "service_role";

grant update on table "public"."class_points" to "service_role";

CREATE TRIGGER update_class_points_trigger AFTER INSERT ON public.records FOR EACH ROW EXECUTE FUNCTION update_class_points();


