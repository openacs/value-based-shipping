request create -params {
    service_level_id -datatype integer -optional
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
    set title "Value-based Shipping: Service Levels Administration"
}

# Set the context bar.

set context_bar [ad_context_bar [list levels "Service Levels"] Edit]

template::form create level_edit -elements {
    service_level_id \
	-datatype integer \
	-widget hidden
    service_level_code \
	-datatype text \
	-widget text \
	-html {size 30 maxlength 20} \
	-label "Service Level Code"
    service_level_description \
	-datatype text \
	-widget text \
	-html {size 60 maxlength 50} \
	-label "Service Level Description"
}

if {[string equal $service_level_id {}]} {

    # The request didn't include a service level ID.

    template::element::set_value level_edit service_level_id [db_nextval vbs_service_level_id_sequence]

} else {

    # The request included a service level ID.

    if { [template::form is_request level_edit] } {
	if { ! [query get_service_level service_level onerow "
	    select service_level_id, service_level_code, service_level_description
	    from vbs_service_levels
	    where service_level_id = :service_level_id"]} {
	    request error invalid_service_level_id "Invalid Sevice Level ID"
	} else {
	    template::form set_values level_edit service_level
	}
    } elseif {[template::form is_submission level_edit] } {
	template::form get_values level_edit service_level_id service_level_code service_level_description
	set service_level_code_count [db_string service_code_check "
	    select count(*)
	    from vbs_service_levels
	    where service_level_code = :service_level_code"]
	if {[db_0or1row check_service_level "
	    select service_level_code as orig_service_level_code
	    from vbs_service_levels
	    where service_level_id = :service_level_id"]} {

	    # The user updated an existing service level.

	    if {($service_level_code_count != 0 && $service_level_code != $orig_service_level_code) ||
		($service_level_code_count > 1 && $service_level_code == $orig_service_level_code)} {
		template::element set_error level_edit service_level_code "
		    Service Level Code has to be unique"
		return
	    } elseif {[template::form is_valid level_edit] } {

		db_dml update_service_level "
		    update vbs_service_levels
		    set  service_level_code = :service_level_code, service_level_description = :service_level_description
		    where service_level_id = :service_level_id"
		template::forward levels
	    }
	} else {

	    # The user entered a new service level.

	    if {$service_level_code_count != 0} {
		template::element set_error level_edit service_level_code "
		    Service Level Code has to be unique"
		return
	    } elseif {[template::form is_valid level_edit] } {
		db_dml insert_service_level "
		    insert into vbs_service_levels
		    (service_level_id, service_level_code, service_level_description)
		    values
		    (:service_level_id, :service_level_code, :service_level_description)"
		template::forward levels
	    }
	}
    }
}
