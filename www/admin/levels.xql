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
      select *
      from vbs_service_levels
      order by service_level_code
    </querytext>
  </fullquery>
  
</queryset>
