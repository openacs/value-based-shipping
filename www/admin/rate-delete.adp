<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> -->

<master>
  <property name="title">@title@</property>
  <property name="context">@context@</property>

  <table width="100%">
    <tbody>
      <tr>
	<td align="right">[ <a href="/doc/value-based-shipping">help</a> ]</td>
      </tr>
    </tbody>
  </table>

  <h3>Do you really want to delete this shipping rate?</h3>
  <blockquote>
    <formtemplate id="rate_delete">
      <formwidget id="shipping_rate_id">
      <table>
	<tr>
	  <th align="left">
	    Service Level
	  </th>
	  <th align="left">
	    Country
	  </th>
	  <th align="left">
	    From Value
	  </th>
	  <th align="left">
	    To Value
	  </th>
	  <th align="left">
	    From Zip code
	  </th>
	  <th align="left">
	    To Zip code
	  </th>
	  <th align="left">
	    Shipping Rate
	  </th>
	</tr>
	<tr>
	  <td>@shipping_rate.service_level_description@</td>
	  <td>@shipping_rate.country@</td>
	  <td>@shipping_rate.from_value@</td>
	  <td>@shipping_rate.to_value@</td>
	  <td>@shipping_rate.from_zip_code@</td>
	  <td>@shipping_rate.to_zip_code@</td>
	  <td>@shipping_rate.shipping_rate@</td>
	</tr>
	<tr>
	  <td colspan="7" align="right">
	    <input type="submit" value="Delete">
	  </td>
	</tr>
      </table>
    </formtemplate>
  </blockquote>
