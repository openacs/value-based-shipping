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

  <fullquery name="get_service_level">
    <querytext>
      select service_level_id, service_level_code, service_level_description
      from vbs_service_levels
      where service_level_id = :service_level_id
    </querytext>
  </fullquery>

  <fullquery name="check_shipping_rates">      
    <querytext>
      select service_level_id 
      from vbs_rates
      where service_level_id = :service_level_id
      limit 1
    </querytext>
  </fullquery>

  <fullquery name="delete_service_level">      
    <querytext>
      delete from vbs_service_levels
      where service_level_id = :service_level_id
    </querytext>
  </fullquery>

</queryset>
