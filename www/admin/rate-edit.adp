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
  
  <h3>Enter the service level description</h3>
  <blockquote>
    <formtemplate id="rate_edit">
      <formwidget id="shipping_rate_id">
      <table>
	<tr>
	  <th valign="top" align="left">Service Level:</th>
	  <td>
	    <formwidget id="service_level_id">
	  </td>
	</tr>
	<tr>
	  <th valign="top" align="left">From Value:</th>
	  <td>
	    <formwidget id="from_value"><br>
	    <font color="red">
	      <formerror id="from_value"></formerror>
	    </font>
	  </td>
	</tr>
	<tr>
	  <th valign="top" align="left">To Value:</th>
	  <td>
	    <formwidget id="to_value"><br>
	    <font color="red">
	      <formerror id="to_value"></formerror>
	    </font>
	  </td>
	</tr>
	<tr>
	  <th valign="top" align="left">Country:</th>
	  <td>
	    <formwidget id="country_iso">
	  </td>
	</tr>
	<tr>
	  <th valign="top" align="left">From Zip code:</th>
	  <td>
	    <formwidget id="from_zip_code"><br>
	    <font color="red">
	      <formerror id="from_zip_code"></formerror>
	    </font>
	  </td>
	</tr>
	<tr>
	  <th valign="top" align="left">To Zip code:</th>
	  <td>
	    <formwidget id="to_zip_code"><br>
	    <font color="red">
	      <formerror id="to_zip_code"></formerror>
	    </font>
	  </td>
	</tr>
	<tr>
	  <th valign="top" align="left">Shipping rate:</th>
	  <td>
	    <formwidget id="shipping_rate"><br>
	    <font color="red">
	      <formerror id="shipping_rate"></formerror>
	    </font>
	  </td>
	</tr>
	<tr>
	  <td colspan="2" align="right">
	    <input type="submit" value="Submit">
	  </td>
	</tr>
      </table>
    </formtemplate>
  </blockquote>
