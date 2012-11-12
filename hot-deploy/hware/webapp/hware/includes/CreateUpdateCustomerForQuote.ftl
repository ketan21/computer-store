<#if security.hasEntityPermission("ORDERMGR", "_CREATE", session) || security.hasEntityPermission("ORDERMGR", "_PURCHASE_CREATE", session)>
<div class="screenlet">
  <div class="screenlet-title-bar">    
    <div class='h3'>Enter Customer Details </div>
  </div>
  <div class="screenlet-body">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="boxbottom">
      <#if forParty?exists && forParty== 'y'>
      	<form name="checkoutsetupform" method="post" action="<@ofbizUrl>createCustomer</@ofbizUrl>">
	  <#else>
        	<form name="checkoutsetupform" method="post" action="<@ofbizUrl>addCustomerToQuote</@ofbizUrl>">
     </#if> 	
      
        <input type="hidden" name="finalizeMode" value="cust" />
        <input type="hidden" name="finalizeReqNewShipAddress" value="true"/>
        <input type="hidden" name="shipToCountryGeoId" value="IND"/>
        <input type="hidden" name="shipToCountryCode" value="0"/>
        <input type="hidden" name="shipToAreaCode" value="91"/>

        <#-- ================ setting hidden parameters to identify update  // not done -->
        <input type="hidden" id="billToContactMechIdInShipingForm" name="billToContactMechId" value="${billToContactMechId?if_exists}" />

        <input type="hidden" id="phoneContactMechId" name="phoneContactMechId"/>
        <input type="hidden" id="emailContactMechId" name="emailContactMechId"/>
        <input type="hidden" name="shipToContactMechId" id="shipToContactMechId"/>

          <#if userLogin?exists>
            <input type="hidden" name="keepAddressBook" value="Y" />
            <input type="hidden" name="setDefaultShipping" value="Y" />
            <input type="hidden" name="userLoginId" id="userLoginId" value="${userLogin.userLoginId?if_exists}" />
            <#assign productStoreId = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStoreId(request) />
            <input type="hidden" name="productStoreId" value="${productStoreId?if_exists}" />
            <#else>
              <input type="hidden" name="keepAddressBook" value="N" />
          </#if>
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="1" cellspacing="0">
              <tr>
                <td><div align = "right">Customer Lookup</div></td>
                <td></td>
                <td width = "26%">
                  <div class='tabletext'>
                    <@htmlTemplate.lookupField value='${thisPartyId?if_exists}' formName="checkoutsetupform" name="partyId" id="partyId" fieldFormName="LookupCustomerName"/>
                  </div>
                  <input type="button" id="autofill" name="autofill" value="Check Customer"/>
                </td>
              </tr>
              <tr>
                <td width="26%" align="right"><div>${uiLabelMap.PartyFirstName}</div></td>
                <td width="5">&nbsp;</td>
                <td width="60%">
                  <input type="text" name="firstName" id="firstName" size="30" maxlength="30"/>
                *</td>
              </tr>
              <tr>
                <td width="26%" align="right"><div>${uiLabelMap.PartyLastName}</div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" name="lastName" id="lastName" size="30" maxlength="30"/>
                *</td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td width="26%" align="right"><div>Contact Number </div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" name="shipToContactNumber" id="shipToContactNumber" size="15" maxlength="15"/>
                  <br/>
                </td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td width="26%" align="right"><div>${uiLabelMap.PartyEmailAddress} </div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" name="emailAddress" id="emailAddress" size="60" maxlength="255" />
                  <br/>
                </td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td width="26%" align="right" valign="top"><div>${uiLabelMap.CommonAddressLine} 1</div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" size="30" maxlength="30" name="shipToAddress1" id="shipToAddress1"/>*
                </td>
              </tr>
              <tr>
                <td width="26%" align="right" valign="top"><div>${uiLabelMap.CommonAddressLine} 2</div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" size="30" maxlength="30" name="shipToAddress2" id="shipToAddress2"/>
                </td>
              </tr>
              <tr>
                <td width="26%" align="right" valign="top"><div>${uiLabelMap.CommonCity}</div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" size="30" maxlength="30" name="shipToCity" id ="shipToCity"/>*
                </td>
              </tr>
              <tr>
                <td width="26%" align="right" valign="top"><div>${uiLabelMap.CommonStateProvince}</div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
				  <select name="shipToStateProvinceGeoId" id="shipToStateProvinceGeoId">
                    <option>
                    	${screens.render("component://hware/widget/CommonScreens.xml#states")}
                    </option>
                  </select>
                </td>
              </tr>
              <tr>
                <td width="26%" align="right" valign="top"><div>${uiLabelMap.CommonZipPostalCode}</div></td>
                <td width="5">&nbsp;</td>
                <td width="74%">
                  <input type="text" size="12" maxlength="10" name="shipToPostalCode" id="shipToPostalCode"/>
                </td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td width="26%" align="right" valign="top"></td>
                <td width="5">&nbsp;</td>
                <td width="74%"><div><input type = "submit" value = "Submit"></div></td>
              </tr>
            </table>
          </td>
        </tr>
      </form>
   </table>
 </div>
</div>

<br />

<#else>
  <h3>${uiLabelMap.OrderViewPermissionError}</h3>
</#if>