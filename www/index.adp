<master>
  <property name="title">@title@</property>
  <if @admin_p@ eq 1>
    <property name="context_bar"><table width="100%"><tbody><tr><td align="left">@context_bar@</td><td align="right">[ <a href="admin/">Administer</a> ]</td></tr></tbody></table></property>
  </if> 
  <else>
    <property name="context_bar">@context_bar@</property>
  </else>

  <p>There are no user pages for this package.</p>
