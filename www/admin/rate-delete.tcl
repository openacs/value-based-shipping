request create -params {
    shipping_rate_id -datatype integer
}

# Return error messages for any incorrect parameter values.

if {![request is_valid]} { 
    return 
}

# Authenticate the user

set user_id [ad_maybe_redirect_for_registration]

# Check for admin privileges

set package_id [ad_conn package_id]
set admin_p [ad_permission_p $package_id admin]

# Get the name of the package

if {[db_0or1row package_name "
    select p.instance_name 
    from apm_packages p, apm_package_versions v
    where p.package_id = :package_id
    and p.package_key = v.package_key
    and v.enabled_p = 't'"]} {
    set title "$instance_name: Shipping Rates Administration"
} else {
    set title "Value-based Shipping: Shipping Rates Administration"
}

# Set the context bar.

set context [list "Shipping Rates"]

template::form create rate_delete -elements {
    shipping_rate_id \
	-datatype integer \
	-widget hidden
}

if {[template::form is_request rate_delete]} {
    if {![template::query get_shipping_rate shipping_rate onerow "
	select l.service_level_description, c.default_name as country, round(r.from_value, 2) as from_value, round(r.to_value, 2) as to_value,  
	r.from_zip_code, r.to_zip_code, round(r.shipping_rate, 2) as shipping_rate
	from vbs_rates r left join countries c on (r.country_iso = c.iso), vbs_service_levels l
	where r.shipping_rate_id = :shipping_rate_id
	and r.service_level_id = l.service_level_id"]} {
	request error invalid_shipping_rate_id "Invalid Shipping Rate ID"
    } else {
	template::element set_value rate_delete shipping_rate_id $shipping_rate_id
    }
}

if {[form is_valid rate_delete]} {
    template::form get_values rate_delete shipping_rate_id
    db_dml delete_shipping_rate "
	delete from vbs_rates
	where shipping_rate_id = :shipping_rate_id"
    template::forward rates
}
