<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> -->

<master>
  <property name="title">@title@</property>

  <h2>@title@</h2>
  <table width="100%">
    <tbody>
      <tr>
	<td align="left">@context_bar@</td>
	<td align="right">[ <a href="/doc/value-based-shipping">help</a> ]</td>
      </tr>
    </tbody>
  </table>
  <hr>

  <h3>Defined service levels</h3>
  <blockquote>
    <table>
      <multiple name="service_levels">
	<if @service_levels.rownum@ odd>
	  <tr>
	</if>
	<else>
	  <tr bgcolor="#eeeeee">
	</else>
	  <th align="left">@service_levels.service_level_code@</th>
	  <td align="left">@service_levels.service_level_description@</td>
	  <td>[ <a href="level-edit?service_level_id=@service_levels.service_level_id@">edit</a> ]</td>
	  <td>[ <a href="level-delete?service_level_id=@service_levels.service_level_id@">delete</a> ]</td>
        </tr>
      </multiple>
	<tr>
	  <td colspan="4" align="right">
	    <form action="level-edit">
	      <p><input type="submit" value="Add a service level"></p>
	    </form>
	  </td>
	</tr>
    </table>
  </blockquote>

