request create -params {
    service_level_id -datatype integer
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
    set title "$instance_name: Service Levels Administration"
} else {
    set title "Sale Based Shipping: Service Levels Administration"
}

# Set the context bar.

set context [list]

template::form create level_delete -elements {
    service_level_id \
	-datatype integer \
	-widget hidden
}

if {[template::form is_request level_delete]} {
    if {![query get_service_level service_level onerow "
	select service_level_id, service_level_code, service_level_description
	from vbs_service_levels
	where service_level_id = :service_level_id"]} {
	request error invalid_service_level_id "Invalid Sevice Level ID"
    } else {
	template::element set_value level_delete service_level_id $service_level_id
    }
}

if {[form is_valid level_delete]} {
    template::form get_values level_delete service_level_id
    if {[db_0or1row check_shipping_rates "
	select service_level_id 
	from vbs_rates
	where service_level_id = :service_level_id
	limit 1"]} {

	# Can't delete the service level; there are rows in the
	# shipping rates table for this service level.

	request error rates_exist_for_service_level "Can't delete the service level; there are shipping rates for this service level."

    } else {
	db_dml delete_service_level "
	    delete from vbs_service_levels
	    where service_level_id = :service_level_id"
	template::forward levels
    }
}
