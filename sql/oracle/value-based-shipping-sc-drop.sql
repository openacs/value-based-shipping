declare
  foo integer;
begin
  foo := acs_sc_impl.delete_alias(
    'ShippingGateway',
    'value-based-shipping',
    'RatesAndServicesSelection'
  );

  foo := acs_sc_impl.delete_alias(
    'ShippingGateway',
    'value-based-shipping',
    'ServiceDescription'
  );

  acs_sc_binding.del(
    contract_name => 'ShippingGateway',
    impl_name => 'value-based-shipping'
  );

  acs_sc_impl.del(
    'ShippingGateway',
    'value-based-shipping'
  );
end;
/
show errors

