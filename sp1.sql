drop function hello_world();
CREATE or replace function hello_world() returns varchar
language plpgsql AS
    $$
        BEGIN
            return CONCAT('hello', 'world', ' ', current_timestamp);
        end;
    $$;

select hello_world result from hello_world();

CREATE or replace function sp_sum(m double precision, n double precision)
returns double precision
language plpgsql AS
    $$
        DECLARE
            x integer := 0;
        BEGIN
            return m + n + x;
        end;
    $$;

select sp_sum result from sp_sum(2.2, 3.5);

drop function sp_product;
CREATE or replace function sp_product(x double precision, y double precision,
    OUT prod double precision,
    OUT div_res double precision)
language plpgsql AS
    $$
        DECLARE
            z double precision := 1.0;
        BEGIN
            prod = x * y * z;
            div_res = x / y;
        end;
    $$;

select * from sp_product(2.2, 3.5);

-- create table movies
-- title, release_date, price, country_id
-- text, timestamp, double precision
-- create table countries

-- create table countries
-- (
--     id   bigserial not null
--         constraint countries_pk
--             primary key,
--     name text      not null
-- )
-- create table movies
-- (
--     id           bigserial                  not null
--         constraint movies_pk
--             primary key,
--     title        text,
--     release_date timestamp                  not null,
--     price        double precision default 0 not null,
--     country_id   bigint
--         constraint movies_countries_id_fk
--             references countries
-- );

insert into movies (title, release_date, price)
values ('batman returns', '2020-12-16 20:21:00', 45.5);
insert into movies (title, release_date, price)
values ('wonder woman', '2018-07-11 08:12:11', 125.5);
insert into movies (title, release_date, price)
values ('matrix resurrection', '2021-01-03 09:10:11', 38.7);

drop function sp_movies_stat;
CREATE or replace function sp_movies_stat(out min_price double precision,
    out max_price double precision,
    out avg_price double precision)
language plpgsql AS
    $$
        BEGIN
            select min(price), max (price), avg(price)::numeric(5, 2)
            into min_price, max_price, avg_price
            from movies;
        end;
    $$;

select * from sp_movies_stat();

-- targil:
-- 1. create sp returns name of the most expansive movie
-- 2. create sp_num_of_movies return the number of movies