<#escape x as x?xml>
<fo:block space-after="40pt"/>
<#if orderHeader.getString("orderTypeId") == "SALES_ORDER">
  <fo:block font-size="8pt" font-weight="bold">
This order is NON-Cancelable and NON-Refundable.
Payment terms are Net 30 Days ROG (Receipt of Goods).
Late Fee of 1.5% Per Month Overdue will be applied to all Past Due invoices.
</fo:block>
<fo:block font-size="8pt" font-weight="bold">
Please send remittance to:
 </fo:block>
 <fo:block font-size="8pt">
    <fo:block>${companyName}</fo:block>
    <#if postalAddress?exists>
        <#if postalAddress?has_content>
            <fo:block>${postalAddress.address1?if_exists}</fo:block>
            <#if postalAddress.address2?has_content><fo:block>${postalAddress.address2?if_exists}</fo:block></#if>
            <fo:block>${postalAddress.city?if_exists}, ${stateProvinceAbbr?if_exists} ${postalAddress.postalCode?if_exists}, ${countryName?if_exists}</fo:block>
        </#if>
    <#else>
        <fo:block>${uiLabelMap.CommonNoPostalAddress}</fo:block>
        <fo:block>${uiLabelMap.CommonFor}: ${companyName}</fo:block>
    </#if>
    </fo:block>
<fo:block font-size="8pt" font-weight="bold" text-align="center">
   Thank You for shopping at Webex Computers !
    <#--    Here is a good place to put policies and return information. -->
  </fo:block>
<#elseif orderHeader.getString("orderTypeId") == "PURCHASE_ORDER">
  <fo:block font-size="8pt" text-align="center">
    <#-- Here is a good place to put boilerplate terms and conditions for a purchase order. -->
  </fo:block>
</#if>
</#escape>
