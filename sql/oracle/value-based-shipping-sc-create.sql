--  This is an implementation of the ShippingGateway service contract

declare
  foo integer;
begin
  foo := acs_sc_impl.new(
           'ShippingGateway',                   -- impl_contract_name
           'value-based-shipping',              -- impl_name
           'value-based-shipping'               -- impl_owner_name
  );

  foo := acs_sc_impl.new_alias(
           'ShippingGateway',                   -- impl_contract_name
           'value-based-shipping',              -- impl_name
           'RatesAndServicesSelection',         -- impl_operation_name
           'value-based-shipping.rates_and_services_selection',         
                                                -- impl_alias
           'TCL'                                -- impl_pl
  );

  foo := acs_sc_impl.new_alias(
           'ShippingGateway',                   -- impl_contract_name
           'value-based-shipping',              -- impl_name
           'ServiceDescription',                -- impl_operation_name
           'value-based-shipping.service_description',
                                                -- impl_alias
           'TCL'                                -- impl_pl
  );
end;
/
show errors

declare
        foo integer;
begin

        -- Add the binding
        acs_sc_binding.new (
            contract_name => 'ShippingGateway',
            impl_name => 'value-based-shipping'
        );
end;
/
show errors
