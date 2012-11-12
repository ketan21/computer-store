<#escape x as x?xml>
<fo:table table-layout="fixed" width="100%" >
<fo:table-column column-width="100%"/>
<fo:table-body>
<fo:table-row>
  <fo:table-cell>
     <fo:block number-columns-spanned="2" font-weight="bold" font-size="30pt" space-before="5px" text-align="right">Invoice</fo:block>
  </fo:table-cell>
</fo:table-row>
<fo:table-row>
  <fo:table-cell border-top-style="solid" border-top-width="thin" border-top-color="black">
  </fo:table-cell>
</fo:table-row>
</fo:table-body>
</fo:table>
<fo:table table-layout="fixed" width="100%">
<fo:table-column column-width="1.5in"/>
<fo:table-column column-width="1in"/>
<fo:table-column column-width="1.3in"/>
<fo:table-body>
<fo:table-row>
 <fo:table-cell number-columns-spanned = "3" padding = "10pt">
 <fo:block font-weight = "bold"></fo:block>
 </fo:table-cell>
</fo:table-row >
<fo:table-row text-align="center">
<fo:table-cell border="solid" border-right="none"><fo:block font-weight="bold">Date</fo:block></fo:table-cell>
<fo:table-cell border="solid" border-right="none"><fo:block font-weight="bold">CustId</fo:block></fo:table-cell>
<fo:table-cell border="solid" ><fo:block font-weight="bold">Order no.</fo:block></fo:table-cell>
</fo:table-row>
<fo:table-row text-align="center">
<fo:table-cell border="solid" border-right="none"><fo:block>${invoiceDate?if_exists}</fo:block></fo:table-cell>
<fo:table-cell border="solid" border-right="none"><fo:block><#if billingParty?has_content>${billingParty.partyId}</#if></fo:block></fo:table-cell>
<fo:table-cell border="solid" ><fo:block><#list orders as order>${order} </#list></fo:block></fo:table-cell>
</fo:table-row>
</fo:table-body>
</fo:table>
</#escape>
