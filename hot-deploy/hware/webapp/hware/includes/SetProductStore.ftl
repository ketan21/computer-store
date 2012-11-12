<form method="post" action="<@ofbizUrl secure="${request.isSecure()?string}">setProductStore</@ofbizUrl>" class="smallForm" >
  <fieldset>
    <input type="hidden" name="checkUserProductStore" value="N" />
    <legend>Select Store</legend>
    <#if !companyPartyGroups?has_content>
      <#assign userProductStores = (parameters.userProductStores)?if_exists />
    </#if>
    <#list userProductStores as userProductStore>
      <div>
        <#if userProductStore.productStoreId != parameters.productStoreId?if_exists>
        <input type="radio" name="productStoreId" id="userProductStore_${userProductStore_index}" value="${userProductStore.productStoreId}" />
        <label for="userProductStore_${userProductStore_index}">${userProductStore.storeName?default(userProductStore.storeName)}</label>
        </#if>
      </div>
    </#list>
    <div>
      <input type="submit" value="Submit" />
    </div>
  </fieldset>
</form> 