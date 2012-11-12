<div class="screenlet">
    <div class="screenlet-title-bar">
        <#if (listSize > 0)>
            <div class="boxhead-right">
                <#if (viewIndex > 1)>
                    <a href="<@ofbizUrl>EditCategoryProducts?productCategoryId=${productCategoryId?if_exists}&amp;VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndex-1}&amp;activeOnly=${activeOnly.toString()}</@ofbizUrl>" class="submenutext">${uiLabelMap.CommonPrevious}</a> |
                </#if>
                <span class="submenutextinfo">${lowIndex} - ${highIndex} ${uiLabelMap.CommonOf} ${listSize}</span>
                <#if (listSize > highIndex)>
                    | <a class="lightbuttontext" href="<@ofbizUrl>EditCategoryProducts?productCategoryId=${productCategoryId?if_exists}&amp;VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndex+1}&amp;activeOnly=${activeOnly.toString()}</@ofbizUrl>" class="submenutextright">${uiLabelMap.CommonNext}</a>
                </#if>
                &nbsp;
            </div>
            <div class="boxhead-left">
                ${uiLabelMap.PageTitleEditCategoryProducts}
            </div>
            <div class="boxhead-fill">&nbsp;</div>
        </#if>
    </div>
    <div class="screenlet-body">
        <#if (listSize == 0)>
           <table cellspacing="0" class="basic-table">
              <tr class="header-row">
                 <td></td>
                 <td></td>
                 <td></td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
              </tr>
           </table>
        <#else>
           <form method="post" action="<@ofbizUrl>updateCategoryProductMember</@ofbizUrl>" name="updateCategoryProductForm">
              <input type="hidden" name="VIEW_SIZE" value="${viewSize}"/>
              <input type="hidden" name="VIEW_INDEX" value="${viewIndex}"/>
              <input type="hidden" name="activeOnly" value="${activeOnly.toString()}" />
              <input type="hidden" name="productCategoryId" value="${productCategoryId?if_exists}" />
              <input type="hidden" name="showProductCategoryId" value="${productCategoryId}" />
              <table cellspacing="0" class="basic-table">
                 <tr class="header-row">
                    <td>${uiLabelMap.ProductProductName}</td>
                    <td>${uiLabelMap.ProductProductId}</td>
                    <td>${uiLabelMap.ProductProductDescription}</td>
                    <td>${uiLabelMap.CommonFromDateTime}</td>
                    <td>&nbsp;</td>
                 </tr>
              <#assign rowClass = "2">
              <#assign rowCount = 0>
              <#list productCategoryMembers as productCategoryMember>
                <#assign suffix = "_o_" + productCategoryMember_index>
                <#assign product = productCategoryMember.getRelatedOne("Product")>
                <#assign hasntStarted = false>
                <#if productCategoryMember.fromDate?exists && nowTimestamp.before(productCategoryMember.getTimestamp("fromDate"))><#assign hasntStarted = true></#if>
                <#assign hasExpired = false>
                <#if productCategoryMember.thruDate?exists && nowTimestamp.after(productCategoryMember.getTimestamp("thruDate"))><#assign hasExpired = true></#if>
                  <tr valign="middle"<#if rowClass == "1"> class="alternate-row"</#if>>
                    <td>
                      <#if (product.smallImageUrl)?exists>
                         <a href="<@ofbizUrl>EditProduct?productId=${(productCategoryMember.productId)?if_exists}</@ofbizUrl>"><img alt="Small Image" src="<@ofbizContentUrl>${product.smallImageUrl}</@ofbizContentUrl>" height="40" width="40" align="middle" /></a>
                      </#if>
                      <a href="<@ofbizUrl>EditProduct?productId=${(productCategoryMember.productId)?if_exists}</@ofbizUrl>" class="buttontext"><#if product?exists>${(product.internalName)?if_exists}</#if></a>
                    </td>
                    <td>[${(productCategoryMember.productId)?if_exists}]</td>
                    <td>${(productCategoryMember.description)?if_exists}</td>
                    <td  <#if hasntStarted> style="color: red;"</#if>>${(productCategoryMember.fromDate)?if_exists}</td>
                    <td>
                    	<#if productCategoryMember.productId?exists>
                    		<a href="javascript:document.deleteProductFromCategory_o_${rowCount}.submit()" class="buttontext">Expire</a>
                    	</#if>	
                    </td	
                  </tr>
                  <#-- toggle the row color -->
                  <#if rowClass == "2">
                      <#assign rowClass = "1">
                  <#else>
                      <#assign rowClass = "2">
                  </#if>
                  <tr valign="middle">
                      <td colspan="4" align="center">
                          <input type="hidden" value="${productCategoryMembers.size()}" name="_rowCount" />
                      </td>
                  </tr>
                  <#assign rowCount = rowCount + 1>
              </#list>
              </table>
           </form>
           <#assign rowCount = 0>
           <#list productCategoryMembers as productCategoryMember>
           <form name="deleteProductFromCategory_o_${rowCount}" method="post" action="<@ofbizUrl>removeCategoryProductMember</@ofbizUrl>">
              <input type="hidden" name="VIEW_SIZE" value="${viewSize}"/>
              <input type="hidden" name="VIEW_INDEX" value="${viewIndex}"/>
              <input type="hidden" name="productId" value="${(productCategoryMember.productId)?if_exists}" />
              <input type="hidden" name="productCategoryId" value="${(productCategoryMember.productCategoryId)?if_exists}"/>
              <input type="hidden" name="fromDate" value="${(productCategoryMember.fromDate)?if_exists}"/>
              <input type="hidden" name="activeOnly" value="${activeOnly.toString()}"/>
           </form>
           <#assign rowCount = rowCount + 1>
           </#list>        
      </#if>
    </div>
    <div class="screenlet-title-bar">
        <#if (listSize > 0)>
            <div class="boxhead-right">
                <#if (viewIndex > 1)>
                    <a href="<@ofbizUrl>EditCategoryProducts?productCategoryId=${productCategoryId?if_exists}&amp;VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndex-1}&amp;activeOnly=${activeOnly.toString()}</@ofbizUrl>" class="submenutext">${uiLabelMap.CommonPrevious}</a> |
                </#if>
                <span class="submenutextinfo">${lowIndex} - ${highIndex} ${uiLabelMap.CommonOf} ${listSize}</span>
                <#if (listSize > highIndex)>
                    | <a class="lightbuttontext" href="<@ofbizUrl>EditCategoryProducts?productCategoryId=${productCategoryId?if_exists}&amp;VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndex+1}&amp;activeOnly=${activeOnly.toString()}</@ofbizUrl>" class="submenutextright">${uiLabelMap.CommonNext}</a>
                </#if>
                &nbsp;
            </div>
            <div class="boxhead-left">
                ${uiLabelMap.PageTitleEditCategoryProducts}
            </div>
            <div class="boxhead-fill">&nbsp;</div>
        </#if>
    </div>
</div>
