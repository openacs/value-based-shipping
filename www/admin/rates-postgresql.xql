<?xml version="1.0"?>

<queryset>
  <rdbms>
    <type>postgresql</type>
    <version>7.1</version>
  </rdbms>

  <fullquery name="get_shipping_rates">      
    <querytext>
      select r.shipping_rate_id, l.service_level_description, c.default_name as country, round(r.from_value, 2) as from_value, round(r.to_value, 2) as to_value,
	  r.from_zip_code, r.to_zip_code, round(r.shipping_rate, 2) as shipping_rate
      from vbs_rates r left join countries c on (r.country_iso = c.iso), vbs_service_levels l
      where r.service_level_id = l.service_level_id
      order by l.service_level_description, c.default_name, r.from_value, coalesce(r.to_value, 0), coalesce(r.from_zip_code, '0')
    </querytext>
  </fullquery>
  
</queryset>
