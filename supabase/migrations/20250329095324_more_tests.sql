drop trigger if exists "refresh_total_points_trigger" on "public"."records";

CREATE TRIGGER refresh_total_points_trigger AFTER INSERT OR DELETE OR UPDATE ON public.records FOR EACH STATEMENT EXECUTE FUNCTION refresh_total_points_view();


