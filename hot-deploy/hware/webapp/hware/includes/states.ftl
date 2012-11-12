<#-- code to get states limited to a region  -->

<#assign stateAssocs = Static["org.ofbiz.common.CommonWorkers"].getAssociatedStateList(delegator,"IND")>

<#list stateAssocs as state>
   <#-- <#assign state = delegator.getRelatedOne("AssocGeo", stateAssoc )> -->
    <option value='${state.geoId}'>${state.geoName?default(state.geoId)}</option>
</#list>