<?xml version="1.0"?>

<queryset>
  <rdbms>
    <type>oracle</type>
    <version>8.1.6</version>
  </rdbms>

  <fullquery name="get_shipping_rates">      
    <querytext>
      select r.shipping_rate_id, l.service_level_description, c.default_name as country, round(r.from_value, 2) as from_value, round(r.to_value, 2) as to_value,
          r.from_zip_code, r.to_zip_code, round(r.shipping_rate, 2) as shipping_rate
      from vbs_rates r, countries c, vbs_service_levels l
      where r.country_iso = c.iso(+) and r.service_level_id = l.service_level_id
      order by l.service_level_description, c.default_name, r.from_value, nvl(r.to_value, 0), nvl(r.from_zip_code, '0')
    </querytext>
  </fullquery>

</queryset>
