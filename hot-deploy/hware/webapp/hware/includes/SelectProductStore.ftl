<div class="screenlet">
  <div class="clear"></div>
  <div class="screenlet-title-bar">
    <div class="h3">Select Store to View Inventory</div><br>
  </div>
  <div class="screenlet-body">
    <form method="post" action="<@ofbizUrl>ShopBasedSummary</@ofbizUrl>" class="smallForm" >
    <fieldset>
      <input type="hidden" name="checkUserProductStore" value="N" />
      <#if !companyPartyGroups?has_content>
        <#assign userProductStores = (parameters.userProductStores)?if_exists />
      </#if>

      <br>
      <input type="hidden" name="action" id="action" value="SEARCH"/>
      <input type="hidden" name="facilityId" id="facilityId" value="${facilityId}">
      <form method="post" name="ProductSearchForm" width="500" action="<@ofbizUrl secure="${request.isSecure()?string}">ViewFacilityInventoryByProduct</@ofbizUrl>" class="smallForm" >
        <table cellspacing="0" class = "basic-table">
          <tbody>
            <tr>
              <td width=7%>Select Store : </td>
              <td>
                <select name="stockProductStoreId" id="stockProductStoreId"/>
                  <option value="">--${uiLabelMap.CommonSelect}--</option>
                  <#list userProductStores as userProductStore>
                    <div>
                      <option value="${userProductStore.productStoreId}">${userProductStore.storeName?default(userProductStore.storeName)}</option>
                    </div>
                  </#list>
                  <option value="all">Show From All</option>
                </select>
              </td>
            </tr>
            <tr>
              <td>Category :</td>
              <td>
                <select id = "category" name = "category" class="dependentSelectMaster">
                  <option value="">--${uiLabelMap.CommonSelect}--</option>
                  <#list categories as category>
                    <option value = "${category.get("productCategoryId")}" title="${category.get("productCategoryId")?if_exists}" <#if (parameters.category?if_exists == category.productCategoryId?if_exists)> selected="selected"</#if>>${category.get("categoryName")}</option>
                  </#list>
                </select>
              </td>
            </tr>
            <tr>
              <td>Brands :</td>
              <td>
                <select id = "brand" name = "brand" class="category dependentSelectMaster">
                  <option value="">--${uiLabelMap.CommonSelect}--</option>
                  <#list categories as category>
                    <#list brands as brand>
                       <#if category.productCategoryId == brand.parentProductCategoryId>
                          <option value = "${brand.get("productCategoryId")}" title="${brand.get("productCategoryId")?if_exists}" class="${category.get("productCategoryId")}" <#if parameters.brand?has_content && parameters.brand?default("") == brand.get("productCategoryId")>selected="selected" </#if>>${brand.get("categoryName")?if_exists}</option>
                       </#if>
                    </#list>
                  </#list>
                </select>
              </td>
            </tr>
            <tr>
              <td>Product:</td>
              <td>
                <select id = "productId" name = "productId" class="brand">
                  <option value="">--${uiLabelMap.CommonSelect}--</option>
                  <#list brands as brand>
                    <#list products as product>
                      <#if brand.productCategoryId == product.productCategoryId>
                        <option value= "${product.get("productId")}" title="${product.get("productId")?if_exists}"  class="${brand.get("productCategoryId")}" <#if parameters.product?has_content && parameters.product?default("") == product.get("productId")>selected="selected" </#if>>${product.get("productName")}
                      </#if>
                    </#list>
                  </#list>
                </select>
              </td>
            </tr>
            <tr></tr>
            <tr>
              <td></td>
              <td><input type="submit" value="Search"></td>
            </tr>

        </table>
      </form>
    </fieldset>
</form>
</div>
</div>
<div/>