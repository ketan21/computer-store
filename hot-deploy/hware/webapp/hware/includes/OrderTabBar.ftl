<#if shoppingCart?has_content>
 <div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">
        ${uiLabelMap.CommonCreate}&nbsp;
          ${uiLabelMap.OrderSalesOrder}
      </li>
      <#if shoppingCart.getOrderType() == "PURCHASE_ORDER">
        <#if shoppingCart.getOrderPartyId() == "_NA_" || (shoppingCart.size() = 0)>
          <li class="disabled">${uiLabelMap.OrderCreateOrder}</li>
          <li class="disabled">${uiLabelMap.OrderFinalizeOrder}</li>
        <#else>
          <li><a href="<@ofbizUrl>finalizeOrder?finalizeMode=purchase&amp;finalizeReqCustInfo=false&amp;finalizeReqShipInfo=false&amp;finalizeReqOptions=false&amp;finalizeReqPayInfo=false</@ofbizUrl>">${uiLabelMap.OrderOrder}</a></li>
        </#if>
      <#else>
        <#if shoppingCart.size() = 0>
          <li class="disabled">${uiLabelMap.OrderCreateOrder}</li>
          <li class="disabled">${uiLabelMap.OrderFinalizeOrderDefault}</li>
        <#else>
          <#if isLastStep?exists && isLastStep?has_content && isLastStep == "Y">
            <li><a href="<@ofbizUrl>processorder</@ofbizUrl>">${uiLabelMap.OrderCreateOrder}</li>
          <#else>
            <li class="disabled">${uiLabelMap.OrderCreateOrder}</li>
          </#if>
          <li><a href="<@ofbizUrl>finalizeOrder</@ofbizUrl>">${uiLabelMap.FinalizeOrder}</a></li>
        </#if>
      </#if>

      <#if (shoppingCart.size() > 0)>
        <li><a href="javascript:document.cartform.submit()">${uiLabelMap.OrderRecalculateOrder}</a></li>
        <li><a href="javascript:removeSelected();">${uiLabelMap.OrderRemoveSelected}</a></li>
      <#else>
        <li class="disabled">${uiLabelMap.OrderRecalculateOrder}</li>
        <li class="disabled">${uiLabelMap.OrderRemoveSelected}</li>
      </#if>
      <li><a href="<@ofbizUrl>emptycart</@ofbizUrl>">${uiLabelMap.OrderClearOrder}</a></li>
    </ul>
  </div>
</div>
<#else>
</#if>