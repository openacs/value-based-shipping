create table vbs_service_levels (
    service_level_id 	integer not null primary key,
    service_level_code  varchar(20),
    service_level_description 
			varchar(80)
);

create sequence vbs_service_level_id_seq start 1;
create view vbs_service_level_id_sequence as select nextval('vbs_service_level_id_seq') as nextval;

create unique index vbs_service_level_code on vbs_service_levels (service_level_code);

create table vbs_rates (
    shipping_rate_id    integer not null primary key,
    service_level_id 	integer not null references vbs_service_levels,
    country_iso 	char(2) references countries,
    from_value 		numeric not null,
    to_value 		numeric,
    from_zip_code 	varchar(10),
    to_zip_code 	varchar(10),
    shipping_rate 	numeric
);

create sequence vbs_shipping_rate_id_seq start 1;
create view vbs_shipping_rate_id_sequence as select nextval('vbs_shipping_rate_id_seq') as nextval;

create unique index vbs_all on vbs_rates (service_level_id, country_iso, from_value, to_value, from_zip_code, to_zip_code);

\i value-based-shipping-sc-create.sql
