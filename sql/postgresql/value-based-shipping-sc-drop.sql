select acs_sc_binding__delete('ShippingGateway', 'value-based-shipping');
select acs_sc_impl_alias__delete('ShippingGateway', 'value-based-shipping', 'RatesAndServicesSelection');
select acs_sc_impl_alias__delete('ShippingGateway', 'value-based-shipping', 'ServiceDescription');
select acs_sc_binding__delete('ShippingGateway', 'value-based-shipping');
select acs_sc_impl__delete('ShippingGateway', 'value-based-shipping');

