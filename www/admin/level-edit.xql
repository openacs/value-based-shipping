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

  <fullquery name="check_service_level">      
    <querytext>
      select service_level_code as orig_service_level_code
      from vbs_service_levels
      where service_level_id = :service_level_id
    </querytext>
  </fullquery>
  
  <fullquery name="update_service_level">      
    <querytext>
      update vbs_service_levels
      set service_level_code = :service_level_code, service_level_description = :service_level_description
      where service_level_id = :service_level_id
    </querytext>
  </fullquery>
  
  <fullquery name="insert_service_level">      
    <querytext>
      insert into vbs_service_levels
      (service_level_id, service_level_code, service_level_description)
      values
      (:service_level_id, :service_level_code, :service_level_description)
    </querytext>
  </fullquery>
  
</queryset>
