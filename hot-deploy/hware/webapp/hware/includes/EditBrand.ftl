<div class="screenlet">
<#if ! productCategory?has_content>
    <#if productCategoryId?has_content>
        <div class="screenlet-title-bar">
          <ul>
            <li class="h3">${uiLabelMap.ProductCouldNotFindProductCategoryWithId} "${productCategoryId}".</li>
          </ul>
          <br class="clear" />
        </div>
        <div class="screenlet-body">
            <form action="<@ofbizUrl>CreateAndAddBrand</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm">
                <table cellspacing="0" class="basic-table">
                    <tr>
                        <td align="right" class="label">${uiLabelMap.ProductProductCategoryId}</td>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" name="productCategoryId" size="20" maxlength="40" value="${productCategoryId}"/>
                        </td>
                    </tr>
    <#else>
        <div class="screenlet-title-bar">
          <ul>
            <li class="h3">${uiLabelMap.CommonCreate} ${uiLabelMap.CommonAnd} ${uiLabelMap.CommonAdd} Brand</li>
          </ul>
          <br class="clear" />
        </div>
        <div class="screenlet-body">
            <form action="<@ofbizUrl>CreateAndAddBrand</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm">
              <input type="hidden" id="productCategoryTypeId" name="productCategoryTypeId" value="CATALOG_CATEGORY">
              <input type= "hidden" name="primaryParentCategoryId" id="primaryParentCategoryId" value="${parameters.parentProductCategoryId}">
              <input type="hidden" name="showProductCategoryId" value="${parameters.parentProductCategoryId?if_exists}" />
              <input type="hidden" name="parentProductCategoryId" value="${parameters.parentProductCategoryId}" />
                <table cellspacing="0" class="basic-table">
                    <tr>
                        <td align="right" class="label">Brand ID</td>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" name="productCategoryId" size="20" maxlength="40">
                        </td>
                    </tr>
    </#if>
<#else>
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.PageTitleEditProductCategories}</h3>
    </div>
    <div class="screenlet-body">
        <form action="<@ofbizUrl>updateProductCategory</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm">
            <input type="hidden" name="productCategoryId" value="${productCategoryId}"/>
            <input type="hidden" name="productCategoryTypeId" value="CATALOG_CATEGORY">
            <input type="hidden" name="showProductCategoryId" value="${productCategoryId}" />
            <input type="hidden" name="parentProductCategoryId" value="${parentProductCategoryId}" />
            
            <table cellspacing="0" class="basic-table">
                <tr>
                    <td align="right" class="label">${uiLabelMap.ProductProductCategoryId}</td>
                    <td>&nbsp;</td>
                    <td>
                      <b>${productCategoryId}</b> (${uiLabelMap.ProductNotModificationRecreationCategory}.)
                    </td>
                </tr>
</#if>
                <tr>
                    <td width="26%" align="right" class="label">Brand Name</td>
                    <td>&nbsp;</td>
                    <td width="74%"><input type="text" value="${(productCategory.categoryName)?if_exists}" name="categoryName" size="60" maxlength="60"/></td>
                </tr>
                <tr>
                    <td width="26%" align="right" class="label">Brand Details</td>
                    <td>&nbsp;</td>
                    <td width="74%"><textarea name="description" cols="60" rows="2"><#if productCategory?has_content>${(productCategory.description)?if_exists}</#if></textarea></td>
                </tr>
                <tr>

                  <td width="26%" align="right" class="label">${uiLabelMap.CommonFromDate}</td>
                  <td>&nbsp;</td>
                  <td width="74%"><input type="text" size="25" name="fromDate" value="${nowTimestamp}"/>
                  </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                    <td><input type="submit" name="Create" value="${uiLabelMap.CommonSubmit}"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
