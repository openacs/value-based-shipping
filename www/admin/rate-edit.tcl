request create -params {
    shipping_rate_id -datatype integer -optional
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

set context_bar [ad_context_bar "Shipping Rates"]

template::form create rate_edit -elements {
    shipping_rate_id \
	-datatype integer \
	-widget hidden
    service_level_id \
	-datatype integer \
	-widget select \
	-options [db_list_of_lists get_service_levels "select service_level_description, service_level_id from vbs_service_levels"] \
	-label "Service Level"
    from_value \
	-datatype text \
	-widget text \
	-label "From Value" \
	-html {size 20 maxlength 15} \
	-validate {from_value_number_check \
		       {regexp {^[0-9]{0,3}(,?[0-9]{3})*\.?[0-9]{0,2}$} $value} \
		       {The value has to be an amount} \
		   from_value_positive_check \
		       {expr [string compare $value 0] >= 0} \
		       {The value can not be less than 0}}
    to_value \
	-datatype text \
	-widget text \
	-label "To Value" \
	-html {size 20 maxlength 15} \
	-optional \
	-validate {to_value_check \
		       {template::form get_values rate_edit from_value; \
			    if {![empty_string_p $from_value] && [regexp {^[0-9]{0,3}(,?[0-9]{3})*\.?[0-9]*$} $value] && [regexp {^[0-9]{0,3}(,?[0-9]{3})*\.?[0-9]*$} $from_value] } { \
				expr $value > $from_value \
			    } else { \
				expr 1 == 1}} \
		       {The 'To Value' must be larger than the 'From Value'} \
		   to_value_positive_check \
		       {expr [string compare $value 0] >= 0} \
		       {The value can not be less than 0} \
		   to_value_number_check \
		       {regexp {^[0-9]{0,3}(,?[0-9]{3})*\.?[0-9]{0,2}$} $value} \
		       {The value has to be an amount}}
    country_iso \
	-datatype text \
	-widget select \
	-options [concat [list {}] [db_list_of_lists get_countries "select default_name, iso from countries"]] \
	-optional \
	-label "Country"
    from_zip_code \
	-datatype text \
	-widget text \
	-label "From Zip code" \
	-html {size 20 maxlength 15} \
	-optional
    to_zip_code \
	-datatype text \
	-widget text \
	-label "To Zip code" \
	-html {size 20 maxlength 15} \
	-optional \
	-validate {from_zip_code_check \
		       {template::form get_values rate_edit from_zip_code; expr ([empty_string_p $value] && [empty_string_p $from_zip_code]) || \
			    (![empty_string_p $value] && ![empty_string_p $from_zip_code]) } \
		       {The 'To Zip code' and 'From Zip code' must both be entered or must both remain empty } \
		   to_zip_code_check \
		       {template::form get_values rate_edit from_zip_code; expr [string compare $value $from_zip_code] >= 0} \
		       {The 'To Zip code' must be larger than the 'From Zip code'}}
    shipping_rate \
	-datatype text \
	-widget text \
	-label "Shipping rate" \
	-html {size 20 maxlength 15} \
	-optional \
	-validate {shipping_rate_positive_check \
		       {expr [string compare $value 0] >= 0} \
		       {The shipping rate can not be less than 0} \
		   shipping_rate_number_check \
		       {regexp {^[0-9]{0,3}(,?[0-9]{3})*\.?[0-9]{0,2}$} $value} \
		       {The shipping rate has to be an amount}}
}

if {[string equal $shipping_rate_id {}]} {

    # The request didn't include a shipping rate ID.

    template::element set_value rate_edit shipping_rate_id [db_nextval vbs_shipping_rate_id_sequence]

} else {

    # The request included a shipping rate ID.

    if { [template::form is_request rate_edit] } {
	if { ! [query get_shipping_rate shipping_rate onerow "
	    select shipping_rate_id, service_level_id, country_iso, round(from_value, 2) as from_value, round(to_value, 2) as to_value, from_zip_code, to_zip_code, 
		round(shipping_rate, 2) as shipping_rate 
	    from vbs_rates
	    where shipping_rate_id = :shipping_rate_id"]} {
	    request error invalid_shipping_rate_id "Invalid Shipping Rate ID"
	} else {
	    template::form set_values rate_edit shipping_rate
	}
    }

    if {[form is_valid rate_edit] } {
	template::form get_values rate_edit shipping_rate_id service_level_id country_iso from_value to_value from_zip_code to_zip_code shipping_rate
	if {[db_0or1row check_shipping_rate "
	    select shipping_rate_id
	    from vbs_rates
	    where shipping_rate_id = :shipping_rate_id"]} {

	    # The user updated an existing shipping rate.

	    db_dml update_shipping_rate "
		update vbs_rates
		set shipping_rate_id = :shipping_rate_id, service_level_id = :service_level_id, country_iso = :country_iso, from_value = :from_value,
		    to_value = :to_value, from_zip_code = :from_zip_code, to_zip_code = :to_zip_code, shipping_rate = :shipping_rate
		where shipping_rate_id = :shipping_rate_id"
		template::forward rates
	} else {

	    # The user entered a new shipping rate.

	    if {[db_0or1row double_entry "
		select shipping_rate_id
		from vbs_rates
		where service_level_id = :service_level_id 
		and country_iso = :country_iso 
		and from_value = :from_value
		and to_value = :to_value 
		and from_zip_code = :from_zip_code
		and to_zip_code = :to_zip_code"]} {

		# There is already an entry in the shipping rate table
		# for this combination of service level, values and
		# zip codes.

		request error double_entry "There is already an entry in the rates table for this combination of service level, country, values and zip codes."
		
	    } else {
		db_dml insert_shipping_rate "
		    insert into vbs_rates
		    (shipping_rate_id, service_level_id, country_iso, from_value, to_value, from_zip_code, to_zip_code, shipping_rate)
		    values
		    (:shipping_rate_id, :service_level_id, :country_iso, :from_value, :to_value, :from_zip_code, :to_zip_code, :shipping_rate)"
		template::forward rates
	    }
	}
    }
}
