ad_page_contract {

    Index to documentation of the Value-based Shipping, an
    implementation of the Shipping Service Contract.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002

} {
} -properties {
    title:onevalue
    context:onevalue
}

# Authenticate the user

set user_id [auth::require_login]

set package_name "Value-based Shipping"
set title "$package_name Documentation"

# Check for admin privileges

set package_url [apm_package_url_from_key "value-based-shipping"]
set package_id [apm_package_id_from_key "value-based-shipping"]
set admin_p [ad_permission_p $package_id admin]

# Check if the package has been mounted.

set value_based_shipping_mounted [expr ![empty_string_p $package_url]]

# Check if the ecommerce and the shipping service contract packages
# are installed on the system.

set ecommerce_installed [apm_package_installed_p ecommerce]
set shipping_gateway_installed [apm_package_installed_p "shipping-gateway"]

# Set the context bar.

set context_bar [ad_context_bar $package_name]

# Set signatory for at the bottom of the page

set signatory "bart.teeuwisse@7-sisters.com"
