<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>Edit Taxes On Products</h3>
    </div>
    <div class="screenlet-body">
        <form action="<@ofbizUrl>ProductTaxAssoc</@ofbizUrl>" method="post" style="margin: 0;" name="editProductAssocForm">
              <table cellspacing="0" class="basic-table">
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductId}</td>
                <td>&nbsp;</td>
                <td><input type="text" name="productId" size="20" maxlength="40" value="${productId?if_exists}" /></td>
                </tr>
                <tr>
                <td align="right" class="label">Tax Category</td>
                <td>&nbsp;</td>
                <td>
                    <select name="productCategoryId" size="1">
                                     <#list TaxCategories as assocType>
                     <option value="${(assocType.productCategoryId)?if_exists}" >${(assocType.categoryName)?if_exists}</option>
                    </#list>
                    </select>
                </td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.CommonFromDate}</td>
                <td>&nbsp;</td>
                <td>
                    <div>
                        <input type="text" name="fromDate" size="25" maxlength="40" value="${fromDate?if_exists}" />
                        <a href="javascript:call_cal(document.editProductAssocForm.FROM_DATE, '${fromDate?default(nowTimestampString)}');"><img src="<@ofbizContentUrl>/images/cal.gif</@ofbizContentUrl>" width="16" height="16" border="0" alt="Calendar" /></a>
                        ${uiLabelMap.CommonSetNowEmpty}
                    </div>
                </td>
                </tr>
            <tr>
                        <td><input type="submit" value="ADD"></td>
            </tr>
           
        </table>


    </div>
</div>

<br />
