ad_proc -public value_based_shipping.rates_and_services_selection {
    orig_country_iso
    orig_zip_code
    dest_country_iso
    dest_zip_code
    shipment_value
    value_currency_code
    shipment_weight
    weight_unit_of_measure
} {
    Retrieve the available shipping service levels and their
    associated charges for the given destination zip code based on
    the value of the shipment.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002
} {

    set rates_and_services [list]
    db_foreach get_rates_and_services "
	select s.service_level_code, round(r.shipping_rate, 2) as shipping_rate
	from vbs_rates r, vbs_service_levels s
	where r.shipping_rate is not null
	and r.service_level_id = s.service_level_id
	and :dest_country_iso = r.country_iso
	and (:dest_zip_code >= r.from_zip_code
	     and :dest_zip_code <= r.to_zip_code
	     and :shipment_value >= r.from_value
	     and (:shipment_value <= r.to_value
		  or (r.to_value is null
		      and not exists (select service_level_id
				      from vbs_rates
				      where :dest_country_iso = country_iso
				      and :dest_zip_code >= from_zip_code
				      and :dest_zip_code <= to_zip_code
				      and :shipment_value >= from_value
				      and :shipment_value <= to_value)))
	     or (r.from_zip_code is null
		 and r.to_zip_code is null
		 and :shipment_value >= r.from_value
		 and (:shipment_value <= r.to_value
		      or (r.to_value is null
			  and not exists (select service_level_id
					  from vbs_rates
					  where :dest_country_iso = country_iso
					  and from_zip_code is null
					  and to_zip_code is null
					  and :shipment_value >= from_value
					  and :shipment_value <= to_value)))
		 and not exists (select service_level_id
				 from vbs_rates
				 where :dest_country_iso = country_iso
				 and :dest_zip_code >= from_zip_code
				 and :dest_zip_code <= to_zip_code)))
	or (r.country_iso is null
	    and r.from_zip_code is null
	    and r.to_zip_code is null
	    and :shipment_value >= r.from_value
	    and (:shipment_value <= r.to_value
		 or (r.to_value is null
		     and not exists (select service_level_id
				     from vbs_rates
				     where :dest_country_iso is null
				     and from_zip_code is null
				     and to_zip_code is null
				     and :shipment_value >= from_value
				     and :shipment_value <= to_value)))
	    and not exists (select service_level_id
			    from vbs_rates
			    where :dest_country_iso = country_iso))" {

	set rate_and_service(service_code) $service_level_code
	set rate_and_service(total_charges) $shipping_rate
	lappend rates_and_services [array get rate_and_service]
    }    
    return $rates_and_services
}

ad_proc -public value_based_shipping.service_description {
    service_code
} {
    Retrieve the description of the given service code.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002
} {

    return [db_string get_service_description "
	select service_level_description
	from vbs_service_levels
	where service_level_code = :service_code"]
}
