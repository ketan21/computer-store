<#escape x as x?xml>

<fo:table table-layout="fixed" width="100%" >
<fo:table-column column-width="100%"/>
<fo:table-body>
<fo:table-row>
  <fo:table-cell>
     <fo:block number-columns-spanned="2" font-weight="bold" font-size="30pt" space-before="5px" text-align="right">Quote</fo:block>
  </fo:table-cell>
</fo:table-row>
<fo:table-row>
  <fo:table-cell border-top-style="solid" border-top-width="thin" border-top-color="black">
  </fo:table-cell>
</fo:table-row>
<fo:table-row height="10pt">
  <fo:table-cell>
  </fo:table-cell>
</fo:table-row>
</fo:table-body>
</fo:table>
<fo:table table-layout="fixed" width="100%">
<fo:table-column column-width="50%"/>
<fo:table-column column-width="50%"/>
<fo:table-body>
<fo:table-row>
<fo:table-cell border="solid">
<fo:block font-weight="bold">${uiLabelMap.OrderOrderQuoteType}</fo:block>
</fo:table-cell>
<fo:table-cell border="solid">
<fo:block font-weight="bold">${(quoteType.get("description",locale))?default(quote.quoteTypeId?if_exists)}</fo:block>
</fo:table-cell>
</fo:table-row>
<fo:table-row>
<fo:table-cell border="solid">
<fo:block>${uiLabelMap.OrderOrderQuoteIssueDate}</fo:block>
</fo:table-cell>
<fo:table-cell border="solid">
<fo:block>${(quote.issueDate.toString())?if_exists}</fo:block>
</fo:table-cell>
</fo:table-row>
<fo:table-row>
<fo:table-cell border="solid">
<fo:block>${uiLabelMap.OrderOrderQuoteId}</fo:block>
</fo:table-cell>
<fo:table-cell border="solid">
<fo:block>${quote.quoteId}</fo:block>
</fo:table-cell>
</fo:table-row>
<fo:table-row>
<fo:table-cell border="solid">
<fo:block>${uiLabelMap.CommonStatus}</fo:block>
</fo:table-cell>
<fo:table-cell border="solid">
<fo:block font-weight="bold">${(statusItem.get("description", locale))?default(quote.statusId?if_exists)}</fo:block>
</fo:table-cell>
</fo:table-row>
</fo:table-body>
</fo:table>
</#escape>
