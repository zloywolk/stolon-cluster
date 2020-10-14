create role ocity with login superuser encrypted password 'password';
create database ocity owner ocity encoding utf8;
grant all privileges on database ocity to ocity;