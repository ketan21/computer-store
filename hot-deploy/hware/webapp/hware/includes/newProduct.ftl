<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>Product:</h3>
    </div>
    <div class="screenlet-body">
        <form name="newProduct" method="post" action="<@ofbizUrl>createProduct</@ofbizUrl>" style="margin: 0;">
            <input type="hidden" name="productCategoryId" value="${productCategoryId}" />
            <input type="hidden" name="primaryProductCategoryId" value="${productCategoryId}" />
            <input type="hidden" name="showProductCategoryId" value="${productCategoryId}" />
            <input type="hidden" name="autoCreateKeywords" value="N"/>
            <table cellspacing="0" class="basic-table">
            	<tr>
            		<td>Product ID:</td>
            		<td><input type="text" name="productId" value=""/></td>
            	</tr>
                <tr>
                    <td width="15%">${uiLabelMap.ProductInternalName}:</td>
                    <td><input type="text" name="internalName" size="30" maxlength="60"/></td>
                </tr>
                <tr>
                    <td width="15%">${uiLabelMap.ProductProductName}:</td>
                    <td><input type="text" name="productName" size="30" maxlength="60"/></td>
                </tr>
                <tr>
                    <td width="15%">${uiLabelMap.ProductShortDescription}:</td>
                    <td><input type="text" name="description" size="60" maxlength="250"/></td>
                </tr>
                <tr>
                  <td></td>
                  <td><input type="submit" value="Create" class="smallSubmit"/></td>
                </tr>
                
            </table>
        </form>
    </div>
</div>