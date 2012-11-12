<#if productCategoryId?has_content>
<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.ProductProductCategory}</h3>
    </div>
    <div class="screenlet-body">
        <#if parentProductCategoryRollups.size() == 0>
            <table cellspacing="0" class="basic-table">
                <tr class="header-row">
                    <td><b>${uiLabelMap.ProductChildCategoryId}</b></td>
                    <td><b>${uiLabelMap.CommonFromDate}</b></td>
                    <td align="center"><b>${uiLabelMap.ProductThruDateTimeSequence}</b></td>
                    <td><b>&nbsp;</b></td>
                </tr>
                <tr valign="middle">
                    <td colspan="4">${uiLabelMap.ProductNoChildCategoriesFound}.</td>
                </tr>
            </table>
        <#else>
            <form method="post" action="<@ofbizUrl>updateProductCategoryToCategory</@ofbizUrl>" name="updateProductCategoryToCategoryChild">
            <input type="hidden" name="showProductCategoryId" value="${productCategoryId}" />
            <table cellspacing="0" class="basic-table">
                <tr class="header-row">
                    <td><b>${uiLabelMap.ProductCategoryId}</b></td>
                    <td><b>${uiLabelMap.CommonFromDate}</b></td>
                    <td align="center"></td>
                    <td><b>&nbsp;</b></td>
                </tr>           
                    <#assign lineChild = 0>
                    <#assign rowClass = "2">
                    <#list parentProductCategoryRollups as productCategoryRollup>
                    <#assign suffix = "_o_" + lineChild>
                    <#assign lineChild = lineChild + 1>
                    <#assign curCategory = productCategoryRollup.getRelatedOne("CurrentProductCategory")>
                    <#assign hasntStarted = false>
                    <#if productCategoryRollup.fromDate?exists && nowTimestamp.before(productCategoryRollup.getTimestamp("fromDate"))><#assign hasntStarted = true></#if>
                    <#assign hasExpired = false>
                    <#if productCategoryRollup.thruDate?exists && nowTimestamp.after(productCategoryRollup.getTimestamp("thruDate"))><#assign hasExpired = true></#if>
                        <tr valign="middle"<#if rowClass == "1"> class="alternate-row"</#if>>
                            <td><#if curCategory?has_content><a href="<@ofbizUrl>EditBrandRollup?showProductCategoryId=${curCategory.productCategoryId}</@ofbizUrl>" class="buttontext">${curCategory.description?if_exists} [${curCategory.productCategoryId}]</a></#if></td>
                            <td <#if hasntStarted>style="color: red"</#if>>${productCategoryRollup.fromDate}</td>
                            <td align="center">
                                <#if curCategory?has_content><a href="<@ofbizUrl>EditCategory?productCategoryId=${curCategory.productCategoryId}</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonEdit}</a></#if>
                                <input type="hidden" name="showProductCategoryId" value="${productCategoryId}" />
                                <input type="hidden" name="productCategoryId${suffix}" value="${productCategoryRollup.productCategoryId}" />
                                <input type="hidden" name="parentProductCategoryId${suffix}" value="${productCategoryRollup.parentProductCategoryId}" />
                                <input type="hidden" name="fromDate${suffix}" value="${productCategoryRollup.fromDate}" />
                            </td>
                            <td>
                                <a href="javascript:document.removeProductCategoryFromCategory_1_${productCategoryRollup_index}.submit();" class="buttontext">${uiLabelMap.CommonDelete}</a>
                            </td>
                        </tr>
                        <#-- toggle the row color -->
                        <#if rowClass == "2">
                            <#assign rowClass = "1">
                        <#else>
                            <#assign rowClass = "2">
                        </#if>
                    </#list>
                    <tr valign="middle">
                        <td colspan="4" align="center">
                            <input type="hidden" value="${lineChild}" name="_rowCount" />
                        </td>
                    </tr>
            </table>
            </form>
            <#list parentProductCategoryRollups as productCategoryRollup>
               <form name="removeProductCategoryFromCategory_1_${productCategoryRollup_index}" method="post" action="<@ofbizUrl>removeCategoryFromCategory</@ofbizUrl>">
                   <input type="hidden" name="showProductCategoryId" value="${productCategoryId}"/>
                   <input type="hidden" name="productCategoryId" value="${productCategoryRollup.productCategoryId}"/>
                   <input type="hidden" name="parentProductCategoryId" value="${productCategoryRollup.parentProductCategoryId}"/>
                   <input type="hidden" name="fromDate" value="${productCategoryRollup.fromDate}"/>
                   <input type="hidden" name="primaryParentProductCategoryId" value="${productCategoryRollup.parentProductCategoryId}" />
               </form>
            </#list>
        </#if>
    </div>
</div>

<#-- Commented

<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>Add New ${uiLabelMap.ProductProductCategory}</h3>
    </div>
    <div class="screenlet-body">
        <table cellspacing="0" class="basic-table">
            <tr><td>
                <form method="post" action="<@ofbizUrl>addProductCategoryToCategory</@ofbizUrl>" style="margin: 0;" name="addChildForm">
                    <input type="hidden" name="showProductCategoryId" value="${productCategoryId}" />
                    <input type="hidden" name="parentProductCategoryId" value="${productCategoryId}" />
                    <@htmlTemplate.lookupField value="${requestParameters.SEARCH_CATEGORY_ID?if_exists}" formName="addChildForm" name="productCategoryId" id="productCategoryId" fieldFormName="LookupProductCategory"/>
                    <input type="text" size="25" name="fromDate" />
                    <a href="javascript:call_cal(document.addChildForm.fromDate, null);"><img src="<@ofbizContentUrl>/images/cal.gif</@ofbizContentUrl>" width="16" height="16" border="0" alt="Calendar" /></a>
                    <input type="submit" value="${uiLabelMap.CommonAdd}" />
                </form>
            </td></tr>
        </table>
    </div>
</div>

 -->

</#if>