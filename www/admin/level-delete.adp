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
