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

</queryset>
