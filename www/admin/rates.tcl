ad_page_contract {

    List are the defined shipping rates. Offer links to the
    rate-edit and rate-delete for each rate to maintain existing
    rates. The page has a button to rate-edit at the bottom to add
    new rates.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002

} {
} -properties {
    title:onevalue
    context_bar:onevalue
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
    set title "$instance_name: Shipping Administration"
} else {
    set title "Value-based Shipping: Shipping Rates Administration"
}

# Set the context bar.

set context_bar [ad_context_bar "Shipping Rates"]

template::query get_shipping_rates shipping_rates multirow "
    select r.shipping_rate_id, l.service_level_description, c.default_name as country, round(r.from_value, 2) as from_value, round(r.to_value, 2) as to_value,
	r.from_zip_code, r.to_zip_code, round(r.shipping_rate, 2) as shipping_rate
    from vbs_rates r left join countries c on (r.country_iso = c.iso), vbs_service_levels l
    where r.service_level_id = l.service_level_id
    order by l.service_level_description, c.default_name, r.from_value"
