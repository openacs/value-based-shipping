ad_page_contract {

    License information of the Authorize.net Gateway, an
    implementation of the Payment Service Contract.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002

} {
} -properties {
    title:onevalue
    context:onevalue
}

# Authenticate the user

set user_id [ad_maybe_redirect_for_registration]

set package_name "Value-based Shipping"
set title "$package_name License"

# Set the context bar.

set context [list [list . $package_name] License]

# Set signatory for at the bottom of the page

set signatory "bart.teeuwisse@7-sisters.com"
