create table vbs_service_levels (
    service_level_id    number not null primary key,
    service_level_code  varchar2(20),
    service_level_description 
                        varchar2(80)
);

create sequence vbs_service_level_id_seq increment by 1 start with 1;
create function vbs_sequence return number is
ret number;
begin
   select vbs_service_level_id_seq.nextval into ret from dual;
   return ret;
   end;
/
show errors;
create view vbs_service_level_id_sequence as select vbs_sequence from dual;

alter table vbs_service_levels add(constraint vbs_service_levels_uk unique(service_level_code));

create table vbs_rates(
    shipping_rate_id number not null, 
    service_level_id number not null, 
    country_iso char(2), 
    from_value number not null, 
    to_value number, 
    from_zip_code varchar2(10), 
    to_zip_code varchar2(10), 
    shipping_rate number, 
    primary key(shipping_rate_id), 
    foreign key(service_level_id) references vbs_service_levels(service_level_id), 
    foreign key(country_iso) references countries(iso));

create sequence vbs_shipping_rate_id_seq increment by 1 start with 1;
create function vbs_ship_sequence return number is
ret number;
begin
   select vbs_shipping_rate_id_seq.nextval into ret from dual;
   return ret;
   end;
/
show errors;
create view vbs_shipping_rate_id_sequence as select vbs_ship_sequence from dual;

alter table vbs_rates add(constraint vbs_rates_uk unique(service_level_id, country_iso, from_value, to_value, from_zip_code, to_zip_code));

@value-based-shipping-sc-create.sql
