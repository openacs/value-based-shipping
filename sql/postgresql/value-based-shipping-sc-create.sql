-- This is a shipment value based implementation of the ShippingGateway
-- service contract

select acs_sc_impl__new(
	   'ShippingGateway',               	-- impl_contract_name
           'value-based-shipping',              -- impl_name
	   'value-based-shipping'               -- impl_owner_name
);

select acs_sc_impl_alias__new(
           'ShippingGateway',			-- impl_contract_name
           'value-based-shipping',		-- impl_name
	   'RatesAndServicesSelection',		-- impl_operation_name
	   'value_based_shipping.rates_and_services_selection',
					 	-- impl_alias
	   'TCL'    				-- impl_pl
);

select acs_sc_impl_alias__new(
           'ShippingGateway',			-- impl_contract_name
           'value-based-shipping',		-- impl_name
	   'ServiceDescription',		-- impl_operation_name
	   'value_based_shipping.service_description',
					 	-- impl_alias
	   'TCL'    				-- impl_pl
);

-- Add the binding

select acs_sc_binding__new (
           'ShippingGateway',
           'value-based-shipping'
);
