<master>
  <property name="title">@title;noquote@</property>
  <property name="context_bar"><table width="100%"><tbody><tr><td>@context_bar;noquote@</td><td align="right">[ <a href="/doc/value-based-shipping">help</a> ]</td></tr></tbody></table></property>

  <h3>Do you really want to delete this service level?</h3>
  <blockquote>
    <formtemplate id="level_delete">
      <formwidget id="service_level_id">
      <table>
	<tr>
	  <th valign="top">Service Level:</th>
	  <td>
	    @service_level.service_level_code@
	  </td>
	  <td>
	    @service_level.service_level_description@
	  </td>
	</tr>
	<tr>
	  <td colspan="3" align="right">
	    <input type="submit" value="Delete">
	  </td>
	</tr>
      </table>
    </formtemplate>
  </blockquote>
