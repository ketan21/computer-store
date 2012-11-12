<#assign nowTimestamp = Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp()>

<div id="footer">
  <ul>
    <li>
      ${uiLabelMap.CommonCopyright} (c) 2001-${nowTimestamp?string("yyyy")} Softitude Technologies, A Division of Prysmaten IT Soutions - <a href="http://www.softitude.com/" target="_blank">http://www.softitude.com/</a><br/>
      ${uiLabelMap.CommonPoweredBy} <a href="http://www.softitude.com/" target="_blank">Softitude Technologies</a> <#include "../../../../../runtime/svninfo.ftl" />
    </li>
    <li class="opposed">${nowTimestamp?datetime?string.short} -
  <a href="<@ofbizUrl>ListTimezones</@ofbizUrl>">${timeZone.getDisplayName(timeZone.useDaylightTime(), Static["java.util.TimeZone"].LONG, locale)}</a>
    </li>
  </ul>
</div>

<#if layoutSettings.VT_FTR_JAVASCRIPT?has_content>
  <#list layoutSettings.VT_FTR_JAVASCRIPT as javaScript>
    <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
  </#list>
</#if>

</div>
</body>
</html>
