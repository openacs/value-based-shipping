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

  <fullquery name="get_service_levels">      
    <querytext>
      select service_level_description, service_level_id 
      from vbs_service_levels
    </querytext>
  </fullquery>
  
  <fullquery name="get_countries">      
    <querytext>
      select default_name, iso 
      from countries
    </querytext>
  </fullquery>
  
  <fullquery name="check_shipping_rate">      
    <querytext>
      select shipping_rate_id
      from vbs_rates
      where shipping_rate_id = :shipping_rate_id
    </querytext>
  </fullquery>

  
  <fullquery name="update_shipping_rate">      
    <querytext>
      update vbs_rates
      select shipping_rate_id, service_level_id, country_iso, round(from_value, 2) as from_value, round(to_value, 2) as to_value, from_zip_code, to_zip_code, 
          round(shipping_rate, 2) as shipping_rate 
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

  <fullquery name="double_entry">      
    <querytext>
      select shipping_rate_id
      from vbs_rates
      where service_level_id = :service_level_id 
      and country_iso = :country_iso 
      and from_value = :from_value
      and to_value = :to_value 
      and from_zip_code = :from_zip_code
      and to_zip_code = :to_zip_code
    </querytext>
  </fullquery>
  
  <fullquery name="insert_shipping_rate">      
    <querytext>
      insert into vbs_rates
      (shipping_rate_id, service_level_id, country_iso, from_value, to_value, from_zip_code, to_zip_code, shipping_rate)
      values
      (:shipping_rate_id, :service_level_id, :country_iso, :from_value, :to_value, :from_zip_code, :to_zip_code, :shipping_rate)
    </querytext>
  </fullquery>
  
</queryset>
