set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.refresh_total_points_view()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
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


