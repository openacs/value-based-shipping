ad_page_contract {

    List are the defined shipping service levels. Offer links to the
    level-edit and level-delete for each service level to maintain
    existing service levels. The page has a button to level-edit at
    the bottom to add new service levels.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002

} {
} -properties {
    title:onevalue
    context:onevalue
}

# Authenticate the user

set user_id [auth::require_login]

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

set context_bar [ad_context_bar "Service Levels"]

template::query get_service_levels service_levels multirow "
    select *
    from vbs_service_levels
    order by service_level_code"
