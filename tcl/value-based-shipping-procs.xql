<?xml version="1.0"?>
<queryset>

  <fullquery name="get_rates_and_services">      
    <querytext>
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
			    where :dest_country_iso = country_iso))
    </querytext>
  </fullquery>
 
  <fullquery name="get_service_description">      
    <querytext>
      select service_level_description
      from vbs_service_levels
      where service_level_code = :service_code
    </querytext>
  </fullquery>
  
</queryset>
