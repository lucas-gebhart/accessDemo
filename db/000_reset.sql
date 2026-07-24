-- Drops and recreates the public schema so the migration files can be replayed from scratch.
drop schema public cascade;
create schema public;
