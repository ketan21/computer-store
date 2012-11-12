<#if shoppingCart?has_content>
 <div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <#if shoppingCart.getOrderType() == "PURCHASE_ORDER">
        <#if shoppingCart.getOrderPartyId() == "_NA_" || (shoppingCart.size() = 0)>
          <li class="disabled">${uiLabelMap.OrderCreateOrder}</li>
          <li class="disabled">${uiLabelMap.OrderFinalizeOrder}</li>
        <#else>
        </#if>
      <#else>
        <#if shoppingCart.size() = 0>
        <#else>
        </#if>
      </#if>

      <#if (shoppingCart.size() > 0)>
        <li><a href="javascript:document.cartform.submit()">Recalculate Quote</a></li>
        <li><a href="javascript:removeSelected();">${uiLabelMap.OrderRemoveSelected}</a></li>
      <#else>
        <li class="disabled">Recalculate Quote</li>
        <li class="disabled">${uiLabelMap.OrderRemoveSelected}</li>
      </#if>
      <li><a href="<@ofbizUrl>emptyquote</@ofbizUrl>">Clear Quote</a></li>
    </ul>
  </div>
</div>
<#else>
</#if>