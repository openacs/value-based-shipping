<?xml version="1.0"?>
<queryset>

  <fullquery name="get_package_name">
    <querytext>
      select p.instance_name 
      from apm_packages p, apm_package_versions v
      where p.package_id = :package_id
      and p.package_key = v.package_key
      and v.enabled_p = 't'
    </querytext>
  </fullquery>

  <fullquery name="delete_shipping_rate">      
    <querytext>
      delete from vbs_rates
      where shipping_rate_id = :shipping_rate_id
    </querytext>
  </fullquery>

  
  <fullquery name="get_shipping_rate">      
    <querytext>
      select l.service_level_description, c.default_name as country, round(r.from_value, 2) as from_value, round(r.to_value, 2) as to_value,  
	  r.from_zip_code, r.to_zip_code, round(r.shipping_rate, 2) as shipping_rate
      from vbs_rates r left join countries c on (r.country_iso = c.iso), vbs_service_levels l
      where r.shipping_rate_id = :shipping_rate_id
      and r.service_level_id = l.service_level_id
    </querytext>
  </fullquery>
  
</queryset>
