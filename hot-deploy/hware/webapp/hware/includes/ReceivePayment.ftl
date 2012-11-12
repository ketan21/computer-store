<#if security.hasEntityPermission("ORDERMGR", "_UPDATE", session)>
<div class="screenlet">
    <div class="screenlet-title-bar">
      <ul>
        <li class="h3">${uiLabelMap.OrderReceiveOfflinePayments}</li>
      </ul>
      <br class="clear"/>
    </div>
    <div class="screenlet-body">
      <form method="post" action="<@ofbizUrl>receiveOfflinePayments/orderview?orderId=${orderId}</@ofbizUrl>" name="paysetupform">
        
        <table class="basic-table" cellspacing='0'>
          <tr class="header-row">
            <td width="30%" align="right">${uiLabelMap.OrderPaymentType}</td>
            <td width="1">&nbsp;&nbsp;&nbsp;</td>
            <td width="1">${uiLabelMap.OrderAmount}</td>
            <td width="1">&nbsp;&nbsp;&nbsp;</td>
            <td width="70%">${uiLabelMap.OrderReference}</td>
          </tr>
         
          <tr>
            <td width="30%" align="right">Personal Cheque </td>
            <td width="1">&nbsp;&nbsp;&nbsp;</td>
            <td width="1"><input type="text" size="7" name="PERSONAL_CHECK_amount" /></td>
            <td width="1">&nbsp;&nbsp;&nbsp;</td>
            <td width="70%"><input type="text" size="15" name="PERSONAL_CHECK_reference" /></td>
          </tr>

          <tr>
            <td width="30%" align="right">Cash</td>
            <td width="1">&nbsp;&nbsp;&nbsp;</td>
            <td width="1"><input type="text" size="7" name="CASH_amount" /></td>
            <td width="1">&nbsp;&nbsp;&nbsp;</td>
            <td width="70%"><input type="text" size="15" name="CASH_reference" /></td>
          </tr>        
        </table>
        
      </form>

      <a href="<@ofbizUrl>authview/orderview?orderId=${orderId}</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonBack}</a>
      <a href="javascript:document.paysetupform.submit()" class="buttontext">${uiLabelMap.CommonSave}</a>
    </div>
</div>
<br />
<#else>
  <h3>${uiLabelMap.OrderViewPermissionError}</h3>
</#if>