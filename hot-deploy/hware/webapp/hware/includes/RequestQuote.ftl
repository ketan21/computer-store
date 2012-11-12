<script language="JavaScript" type="text/javascript">
  function quicklookup() {
    window.location='<@ofbizUrl>LookupBulkAddProducts</@ofbizUrl>';
  }
</script>

<div class="screenlet">
  <div class="clear"></div>
  <div class="screenlet-title-bar">
    <div class="h3">Request a Quote</div><br>
  </div>
  <div class="screenlet-body">
      <form method="post" name="RequestQuoteForm" width="500" action="<@ofbizUrl secure="${request.isSecure()?string}">createQuote</@ofbizUrl>" class="smallForm" >
        <table cellspacing="0" class = "basic-table">
          <tbody>
            <tr>
              <td width=7%><label>Add Product:</label></td> 
              <td>
                <a href="javascript:quicklookup()" class="buttontext">${uiLabelMap.OrderQuickLookup}</a>
                <#if shoppingCart.size()!=0><label>Create Quote  </label>
                <a href="<@ofbizUrl>setCustomerForQuote</@ofbizUrl>" class="buttontext">Create Quote</a>
                </#if>
              </td>
            </tr>
            <tr>
            </tr>

        </table>
     </form>
   </div>
` </div>
<div/>