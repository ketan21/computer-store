<#-- model form to test the flow -->
<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">Select Payment Method </li>
    </ul>
  </div>
  <div class="screenlet-body">
            <form method="post" action="<@ofbizUrl>finalizeOrder</@ofbizUrl>" name="checkoutsetupform">
            <input type="hidden" name="finalizeMode" value="payment"/>
            <table width="100%" cellpadding="1" cellspacing="0" border="0">
             <tr>
                <td width="1%">
                  <input type="radio" id="checkOutPaymentId_EXT_OFFLINE" name="checkOutPaymentId" value="EXT_OFFLINE" <#if checkOutPaymentId?exists && checkOutPaymentId == "EXT_OFFLINE">checked="checked"</#if>/>
                </td>
                <td colspan="2" width="50%">
                  <label for="checkOutPaymentId_EXT_OFFLINE">${uiLabelMap.OrderPaymentOfflineCheckMoney}</label>
                </td>
              </tr>
             <tr><td colspan="3"><hr /></td></tr>
              <tr>
                <td width="1%">
                  <input type="radio" id="checkOutPaymentId_EXT_COD" name="checkOutPaymentId" value="CASH" <#if checkOutPaymentId?exists && checkOutPaymentId == "EXT_COD">checked="checked"</#if>/>
                </td>
                <td colspan="2" width="50%">
                  <label for="checkOutPaymentId_EXT_COD">CASH</label>
                </td>
              </tr>
            </table>
  </form>
  </div>
</div>
