<div id="content-main-section" class="leftonly">
  <div class="no-clear">
    <div class="screenlet">
      <div class = "screenlet-title-bar">
        <div class = "h3">Enter Product Details: </div><br>
      </div>
      <div class="screenlet-body">
      <div/>
      <table border="0" cellspacing="0" cellpadding="0">
        <tbody>
          <tr>
            <td>
              <form method="post" name="ProductSearchForm" width="500" action="<@ofbizUrl secure="${request.isSecure()?string}">ViewFacilityInventoryByProduct</@ofbizUrl>" class="smallForm" >
                <table cellspacing="0" class = "basic-table">
                  <tbody>
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
                    <tr><td><input type="submit" value="Search"></td></tr>
                  </tbody>
                </table>
              </form>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
