<master>
  <property name="title">@title@</property>
  <property name="context_bar"><table width="100%"><tbody><tr><td>@context_bar@</td><td align="right">[ <a href="/doc/value-based-shipping">help</a> ]</td></tr></tbody></table></property>
  
  <h3>Enter the service level description</h3>
  <blockquote>
    <formtemplate id="level_edit">
      <formwidget id="service_level_id">
      <table>
	<tr>
	  <th valign="top" align="left">Service Level Code:</th>
	  <td>
	    <formwidget id="service_level_code"><br>
	      <font color="red">
 	        <formerror id="service_level_code"></formerror>
	      </font>
          </td>
	</tr>
	<tr>
	  <th valign="top" align="left">Service Level Description:</th>
	  <td>
	    <formwidget id="service_level_description"><br>
	      <font color="red">
 	        <formerror id="service_level_description"></formerror>
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
