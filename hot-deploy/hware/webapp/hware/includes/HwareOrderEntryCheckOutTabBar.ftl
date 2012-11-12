<#if stepTitleId?exists>
    <#assign stepTitle = uiLabelMap.get(stepTitleId)>
</#if>
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">
        ${uiLabelMap.OrderSalesOrder}
        :&nbsp;${stepTitle?if_exists}
      </li>
      
      <#if isLastStep == "N">
        <li><a href="javascript:document.checkoutsetupform.submit();">${uiLabelMap.CommonContinue}</a></li>
      <#else>
        <li><a href="<@ofbizUrl>processorder</@ofbizUrl>">${uiLabelMap.OrderCreateOrder}</a></li>
      </#if>

      <#list checkoutSteps?reverse as checkoutStep>
        <#assign stepUiLabel = uiLabelMap.get(checkoutStep.label)>
        <#if checkoutStep.enabled == "N">
            <li><span class="disabled">${stepUiLabel}</span></li>
        <#else>
            <li><a href="<@ofbizUrl>${checkoutStep.uri}</@ofbizUrl>">${stepUiLabel}</a></li>
        </#if>
      </#list>
    </ul>
    <br class="clear" />
  </div>
</div>
