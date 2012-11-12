<#escape x as x?xml>
<fo:table table-layout="fixed" width="100%" space-after="0.3in">
<fo:table-body>
<fo:table-row height="50pt">
      <fo:table-cell>
      <fo:block></fo:block>
      </fo:table-cell>
      </fo:table-row >
 </fo:table-body>
 </fo:table>
<fo:table table-layout="fixed" width="100%" space-after="0.3in">
   <fo:table-column column-width="50%"/>
   <fo:table-column column-width="50%"/>
   <fo:table-body>
      <fo:table-row >
        <fo:table-cell>
 
<fo:table table-layout="fixed" width="100%" space-after="0.3in">
   <fo:table-column column-width="3.5in"/>
    <fo:table-body border="solid">
      <fo:table-row >
        <fo:table-cell>
               <fo:block font-weight="bold">Sold To: </fo:block>
        </fo:table-cell>
        </fo:table-row>
           <fo:table-row >
        <fo:table-cell border-top-style="solid" border-top-width="solid" border-top-color="black">
         </fo:table-cell>
        </fo:table-row>
        <fo:table-row>
        <fo:table-cell text-align="left">
       <#if billingAddress?has_content>
        <#assign billingPartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", billingParty.partyId, "compareDate", invoice.invoiceDate, "userLogin", userLogin))/>
        <fo:block>${billingPartyNameResult.fullName?default(billingAddress.toName)?default("Billing Name Not Found")}</fo:block>
        <#if billingAddress.attnName?exists>
            <fo:block>${billingAddress.attnName}</fo:block>
        </#if>
            <fo:block>${billingAddress.address1?if_exists}</fo:block>
        <#if billingAddress.address2?exists>
            <fo:block>${billingAddress.address2}</fo:block>
        </#if>
        <fo:block>${billingAddress.city?if_exists} ${billingAddress.stateProvinceGeoId?if_exists} ${billingAddress.postalCode?if_exists}</fo:block>
    <#else>
        <fo:block>${uiLabelMap.AccountingNoGenBilAddressFound}${billingParty.partyId}</fo:block>
    </#if>
        </fo:table-cell>
    </fo:table-row>
  </fo:table-body>
</fo:table>
<fo:block space-after="0.2in"/>
</fo:table-cell>
<fo:table-cell>
<fo:table table-layout="fixed" width="100%" space-after="0.3in">
   <fo:table-column column-width="3.5in"/>
    <fo:table-body border="solid">
    <fo:table-row>
    <fo:table-cell>
<#if orderPaymentPreferences?has_content>
    <fo:block font-weight="bold">${uiLabelMap.AccountingPaymentInformation}:</fo:block>
    </fo:table-cell>
    </fo:table-row>
    <fo:table-row >
    <fo:table-cell border-top-style="solid" border-top-width="solid" border-top-color="black">
    </fo:table-cell>
    </fo:table-row>
    <fo:table-row>
    <fo:table-cell>
    <#list orderPaymentPreferences as orderPaymentPreference>
        <fo:block text-indent="0.2in">
            <#assign paymentMethodType = orderPaymentPreference.getRelatedOne("PaymentMethodType")?if_exists>
            <#if ((orderPaymentPreference != null) && (orderPaymentPreference.getString("paymentMethodTypeId") == "CREDIT_CARD") && (orderPaymentPreference.getString("paymentMethodId")?has_content))>
                <#assign creditCard = orderPaymentPreference.getRelatedOne("PaymentMethod").getRelatedOne("CreditCard")>
                ${Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)}
            <#else>
                ${paymentMethodType.get("description",locale)?if_exists}
            </#if>
        </fo:block>
    </#list>
</#if>
</fo:table-cell>
</fo:table-row>
</fo:table-body>
</fo:table>
</fo:table-cell>
</fo:table-row>
</fo:table-body>
</fo:table>
</#escape>