<master>
  <property name="title">@title;noquote@</property>
  <property name="signatory">@signatory;noquote@</property>
  <property name="header_stuff"><link href="index.css" type="text/css" rel="stylesheet"></property>
  <if @admin_p@ and @value_based_shipping_mounted@>
    <property name="context_bar"><table width="100%"><tbody><tr><td align="left">@context_bar;noquote@</td><td align="right">[ <a href="@package_url;noquote@admin/">Administer</a> ]</td></tr> </tbody></table></property>
  </if>
  <else>
    <property name="context_bar">@context_bar;noquote@</property>
  </else>

  <h2>Why</h2>

  <p>@package_name@ provides a simple yet flexible way to maintain a
  set of custom shipping rates based on the total value of the
  shipment.</p>

  <h2>Background</h2>

  <p><a href="http://www.berklee.edu">Berklee College Of Music</a>
  needed a value based shipping rates for use with the <if
  @ecommerce_installed@ eq 1><a href="/doc/ecommerce"></if>ecommerce
  package<if @ecommerce_installed@ eq 1></a></if>. While the ecommerce
  package can base shipping rates on the number of items in the
  shipment or the total weight it is does not offer value based
  shipping rates. Thus the need arose for either a modification of the
  ecommerce code or an <a href="/doc/acs-service-contract">ACS Service
  Contract API</a> based solution. Opting for flexibility and
  re-usability <a href="mailto:bart.teeuwisse@7-sisters.com">Bart
  Teeuwisse</a> developed the <if @shipping_gateway_installed@ eq
  1><a href="/doc/shipping-gateway"></if>Shipping Service Contract<if
  @shipping_gateway_installed@ eq 1></a></if>.</p>

  <h2>Usage</h2>

  <p class="note">Note: This release has been developed on PostgreSQL
  only. Please report any problems you might find in the <a
  href="http://openacs.org/sdm/">OpenACS SDM</a>. The SDM can also be
  used to contribute patches to the @package_name@ package (for
  example to add Oracle support).</p>

  <p>@package_name@ is based on 2 principles: Service Levels and
  Shipping Rates.</p>

  <blockquote>

    <h3>Service Levels</h3>

    <p>Value-based shipping rates are specific to service
    levels. E.g. the shipping rate for 'Ground Service' differs from
    the '2nd Day Air' or 'Next Day Air' rates. Hence, service levels
    need to be defined before shipping rates can be
    entered. Maintenance of the service levels is through the <if
    @value_based_shipping_mounted@><a
    href="@package_url@admin/levels"></if>Service Levels
    Administration<if @value_based_shipping_mounted@></a></if>
    pages.</p>

    <p>As said, services levels need to be defined before shipping
    rates can be defined. Conversely service levels can not be deleted
    as long as there are shipping rates for the service
    level. However, service levels can be renamed at any time. All
    changes have an immediate effect on life systems.</p>

    <h3>Shipping Rates</h3>

    <p>Shipping rates can be defined after the service levels have
    been entered. Maintenance of the shipping rates is through the <if
    @value_based_shipping_mounted@><a
    href="@package_url@admin/rates"></if>Shipping Rates
    Administration<if @value_based_shipping_mounted@></a></if>
    pages.</p>

    <p>Shipping rates a specific to a service level, the location of
    the destination and the value of the shipment. Rather than listing
    each possible location in the shipping rates table, @package_name@
    uses the concept of <i>regions</i>.A region is defined by a
    combination of Country, From zip code and To zip code. </p>

    <ul>

      <li>The most global region is the world, which is a combination
      of <i>no</i> country and <i>no</i> zip codes.</li>

      <li>Following the world are entire countries, which are defined
      by selecting the country while leaving the zip codes blanc.</li>

      <li>Regions within a country can be defined by choosing are range
      of zip codes, ranging from the From zip code to the To zip
      code.</li>

    </ul>    

    <p>When selecting services and rates, the
    RatesAndServicesSelection operation compares the value of the
    shipment against the values of the From value and To value
    fields.</p>

    <ul>

      <li>RatesAndServicesSelection selects shipping rate if the
      package value is between the From value and To value.</li>

      <li>RatesAndServicesSelection <i>also</i> selects shipping rate
      if the package value is over the From value and no To value has
      been defined.</li>

    </ul>

    <p>The RatesAndServicesSelection operation selects shipping rates
    from the bottom up. More specific shipping rate definitions are
    selected before global shipping rates.</p>

    <p>Geographical exclusions are possible too. Create a shipping
    rate with an empty rate (=charge amount) and the location of the
    shipping rate will be excluded from more global shipping rates for
    the same service. </p>

    <blockquote>E.g. To define a shipping rate of $30.50 for all
    'International Air' shipments out side the US one would create
    shipping rate of $30.50 for the world for orders over $0 with a
    second shipping rate for the US for orders over $0 with a rate of
    no value.</blockquote>

  </blockquote>

  <p class="note">Please be aware that the query executed by
  RatesAndServicesSelection is an expensive query to perform and most
  likey doesn't scale well to thousands of shipping rate entries. </p> 

  <h2>API Reference</h2>

  <p>The <if @shipping_gateway_installed@ eq 1><a
  href="/doc/shipping-gateway"></if>Shipping Service Contract<if
  @shipping_gateway_installed@ eq 1></a></if> explains the API in
  detail.</p>

  <h2>Credits</h2>

  <p>@package_name@ was designed and written by <a
  href="mailto:bart.teeuwisse@7-sisters.com">Bart Teeuwisse</a> for <a
  href="http://www.berklee.edu">Berklee College Of Music</a> while
  working as a subcontractor for <a
  href="http://www.furfly.net">furfly.net</a>.</p>

  <p>@package_name@ is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of the
    License, or (at your option) any later version.</p>

  <p>@package_name@ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.</p>

  <p>A <a href="license">copy of the GNU General Public License</a> is
    included. If not write to the Free Software Foundation, Inc., 59
    Temple Place, Suite 330, Boston, MA 02111-1307 USA
