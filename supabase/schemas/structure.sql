-- Create records table to store data about points exchanged between users
create table records (
    id serial primary key,
    from_name text not null,
    from_class text not null,
    from_points integer not null,
    to_name text not null,
    to_class text not null,
    to_points integer not null,
    description text not null,
    created_at timestamp with time zone default now(),
    created_by uuid default auth.uid()
);

-- Create a materialized view to calculate total points for each class
create materialized view total_points as
select
    class,
    sum(total_points) as total_points
from (
    select from_class as class, from_points as total_points
    from records
    union all

    select to_class as class, to_points as total_points
    from records
) as combined_points
group by class;

-- In supabase we can't subscribe for real-time updates on materialized views, so we need to create a table to store the total points
create table subscribable_total_points (
    class text primary key,
    total_points integer not null
);

-- Create a function to refresh the materialized view
create or replace function refresh_total_points_view()
returns trigger
security definer
as $$
begin
    refresh materialized view total_points;

    insert into subscribable_total_points (class, total_points)
    select class, total_points
    from total_points
        on conflict (class)
        do update set total_points = excluded.total_points;

    return new;
end;
$$ language plpgsql;

-- Create a trigger to refresh the materialized view after each insert, update, or delete on the records table
create trigger refresh_total_points_trigger
    after insert or update or delete on records
    for each statement
    execute function refresh_total_points_view();
