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

  <h3>Defined shipping rates</h3>
  <blockquote>
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
      <multiple name="shipping_rates">
	<if @shipping_rates.rownum@ odd>
	  <tr>
	</if>
	<else>
	  <tr bgcolor="#eeeeee">
	</else>
	<td>@shipping_rates.service_level_description@</td>
	<td>@shipping_rates.country@</td>
	<td align="right">@shipping_rates.from_value@</td>
	<td align="right">@shipping_rates.to_value@</td>
	<td>@shipping_rates.from_zip_code@</td>
	<td>@shipping_rates.to_zip_code@</td>
	<td align="right">@shipping_rates.shipping_rate@</td>
	<td width="30"></td>
	<td>[&nbsp;<a href="rate-edit?shipping_rate_id=@shipping_rates.shipping_rate_id@">edit</a>&nbsp;]</td>
	<td>[&nbsp;<a href="rate-delete?shipping_rate_id=@shipping_rates.shipping_rate_id@">delete</a>&nbsp;]</td>
      </tr>
      </multiple>
      <tr>
	<td colspan="10" align="right">
	  <form action="rate-edit">
	    <p><input type="submit" value="Add a shipping rate"></p>
	  </form>
	</td>
      </tr>
    </table>

  </blockquote>
