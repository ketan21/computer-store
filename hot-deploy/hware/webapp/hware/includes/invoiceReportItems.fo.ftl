<#escape x as x?xml>
    <#-- list of orders -->
     <#--  <#if orders?has_content>
    <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="1in"/>
        <fo:table-column column-width="5.5in"/>

        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block font-weight="bold">${uiLabelMap.AccountingOrderNr}:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block font-size ="10pt" font-weight="bold"><#list orders as order>${order} </#list></fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
    </fo:table>
    </#if>

  list of terms 
    <#if terms?has_content>
    <fo:table table-layout="fixed" width="100%" space-before="0.1in">
        <fo:table-column column-width="6.5in"/>

        <fo:table-header height="14px">
          <fo:table-row>
            <fo:table-cell>
              <fo:block font-weight="bold">${uiLabelMap.AccountingAgreementItemTerms}</fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-header>

        <fo:table-body>
          <#list terms as term>
          <#assign termType = term.getRelatedOne("TermType")/>
          <fo:table-row>
            <fo:table-cell>
              <fo:block font-size ="10pt" font-weight="bold">${termType.description?if_exists} ${term.description?if_exists} ${term.termDays?if_exists} ${term.textValue?if_exists}</fo:block>
            </fo:table-cell>
          </fo:table-row>
          </#list>
        </fo:table-body>
    </fo:table>
    </#if>-->

    <fo:table table-layout="fixed" width="100%" space-before="0.2in">
    <fo:table-column column-width="9.5%"/>
    <fo:table-column column-width="30%"/>
    <fo:table-column column-width="28%"/>
    <fo:table-column column-width="7.5%"/>
    <fo:table-column column-width="10%"/>
    <fo:table-column column-width="15%"/>
    
    
    <fo:table-header height="14px">
      <fo:table-row text-align="center">
        <fo:table-cell border="solid" border-right="none">
          <fo:block font-weight="bold">Item</fo:block>
        </fo:table-cell>
        <fo:table-cell border="solid" border-right="none">
          <fo:block font-weight="bold">${uiLabelMap.AccountingProduct}</fo:block>
        </fo:table-cell>
        <fo:table-cell border="solid" border-right="none">
          <fo:block font-weight="bold">${uiLabelMap.CommonDescription}</fo:block>
        </fo:table-cell>
        <fo:table-cell border="solid" border-right="none">
          <fo:block font-weight="bold" >${uiLabelMap.CommonQty}</fo:block>
        </fo:table-cell>
        <fo:table-cell border="solid" border-right="none">
          <fo:block font-weight="bold" >${uiLabelMap.AccountingUnitPrice}</fo:block>
        </fo:table-cell>
        <fo:table-cell border="solid">
          <fo:block font-weight="bold" >${uiLabelMap.CommonAmount}</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>


    <fo:table-body font-size="10pt">
        <#assign currentShipmentId = "">
        <#assign newShipmentId = "">
        <#assign count=0/>
        <#-- if the item has a description, then use its description.  Otherwise, use the description of the invoiceItemType -->
        <#list invoiceItems as invoiceItem>
            <#assign itemType = invoiceItem.getRelatedOne("InvoiceItemType")>
            <#assign isItemAdjustment = Static["org.ofbiz.common.CommonWorkers"].hasParentType(delegator, "InvoiceItemType", "invoiceItemTypeId", itemType.getString("invoiceItemTypeId"), "parentTypeId", "INVOICE_ADJ")/>

            <#assign taxRate = invoiceItem.getRelatedOne("TaxAuthorityRateProduct")?if_exists>
            <#assign itemBillings = invoiceItem.getRelated("OrderItemBilling")?if_exists>
            <#if itemBillings?has_content>
                <#assign itemBilling = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(itemBillings)>
                <#if itemBilling?has_content>
                    <#assign itemIssuance = itemBilling.getRelatedOne("ItemIssuance")?if_exists>
                    <#if itemIssuance?has_content>
                        <#assign newShipmentId = itemIssuance.shipmentId>
                        <#assign issuedDateTime = itemIssuance.issuedDateTime/>
                    </#if>
                </#if>
            </#if>
            <#if invoiceItem.description?has_content>
                <#assign description=invoiceItem.description>
            <#elseif taxRate?has_content & taxRate.get("description",locale)?has_content>
                <#assign description=taxRate.get("description",locale)>
            <#elseif itemType.get("description",locale)?has_content>
                <#assign description=itemType.get("description",locale)>
            </#if>
            <#if newShipmentId?exists & newShipmentId != currentShipmentId>
                <#-- the shipment id is printed at the beginning for each
                     group of invoice items created for the same shipment
                -->
                <fo:table-row height="14px">
                    <fo:table-cell number-columns-spanned="5">
                            <fo:block></fo:block>
                       </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="14px">
                   <fo:table-cell number-columns-spanned="5">
                        <fo:block font-weight="bold"> ${uiLabelMap.ProductShipmentId}: ${newShipmentId}<#if issuedDateTime?exists> ${uiLabelMap.CommonDate}: ${Static["org.ofbiz.base.util.UtilDateTime"].toDateString(issuedDateTime)}</#if></fo:block>
                   </fo:table-cell>
                </fo:table-row>
                <#assign currentShipmentId = newShipmentId>
            </#if>
            <#if !isItemAdjustment>
            <#assign count=count+1>
                <fo:table-row height="14px" space-start=".15in" text-align="center">
                    <fo:table-cell border="solid">
                        <fo:block >${count} </fo:block>
                    </fo:table-cell >
                    <fo:table-cell border="solid" border-right="none">
                        <fo:block >${invoiceItem.productId?if_exists} </fo:block>
                    </fo:table-cell >
                    <fo:table-cell border="solid" border-right="none">
                        <fo:block >${description?if_exists}</fo:block>
                    </fo:table-cell>
                      <fo:table-cell border="solid" border-right="none">
                        <fo:block > <#if invoiceItem.quantity?exists>${invoiceItem.quantity?string.number}</#if> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid" border-right="none">
                        <fo:block> <#if invoiceItem.quantity?exists><@ofbizCurrency amount=invoiceItem.amount?if_exists isoCode=invoice.currencyUomId?if_exists/></#if> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid" text-align="right" padding="2pt">
                        <fo:block> <@ofbizCurrency amount=(Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem)) isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            <#else>
                <#if !(invoiceItem.parentInvoiceId?exists && invoiceItem.parentInvoiceItemSeqId?exists)>
                    <fo:table-row>
                        <fo:table-cell><fo:block/></fo:table-cell>
                        <fo:table-cell border-top-style="solid" border-top-width="thin" border-top-color="black"><fo:block/></fo:table-cell>
                        <fo:table-cell number-columns-spanned="3"><fo:block/></fo:table-cell>
                    </fo:table-row>
                </#if>
                <fo:table-row height="14px" space-start=".15in" background-color="#D4D0C8">

                    <fo:table-cell number-columns-spanned="5" border="solid" padding="2pt" >
                        <fo:block text-align="right" font-weight="bold">Sales Tax</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right" border="solid" padding="2pt">
                        <fo:block > <@ofbizCurrency amount=(Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem)) isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </#if>
            
        </#list>

        <#-- blank line -->


        <#-- the grand total -->
        <fo:table-row>
           <fo:table-cell number-columns-spanned="3">
              <fo:block/>
           </fo:table-cell>
           <fo:table-cell number-columns-spanned="2" border="solid" text-align="right" padding="2pt">
              <fo:block font-weight="bold">${uiLabelMap.AccountingTotalCapital}</fo:block>
           </fo:table-cell>
           <fo:table-cell text-align="right" border="solid" padding="2pt">
              <fo:block font-weight="bold"><@ofbizCurrency amount=invoiceTotal isoCode=invoice.currencyUomId?if_exists/></fo:block>
           </fo:table-cell>
        </fo:table-row>
        <fo:table-row height="14px">
           <fo:table-cell number-columns-spanned="3" >
              <fo:block/>
           </fo:table-cell>
           <fo:table-cell number-columns-spanned="2" border="solid" padding="2pt">
              <fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingTotalExclTax}</fo:block>
           </fo:table-cell>
           <fo:table-cell border="solid">
              <fo:block text-align="right" font-weight="bold" padding="2pt">
                 <@ofbizCurrency amount=invoiceNoTaxTotal isoCode=invoice.currencyUomId?if_exists/>
              </fo:block>
           </fo:table-cell>
        </fo:table-row>
    </fo:table-body>
 </fo:table>

<#if vatTaxIds?has_content>
 <fo:table>
    <fo:table-column column-width="105mm"/>
    <fo:table-column column-width="40mm"/>
    <fo:table-column column-width="25mm"/>

    <fo:table-header>
      <fo:table-row>
        <fo:table-cell>
          <fo:block/>
        </fo:table-cell>
        <fo:table-cell border-bottom-style="solid" border-bottom-width="thin" border-bottom-color="black">
          <fo:block font-weight="bold">${uiLabelMap.AccountingVat}</fo:block>
        </fo:table-cell>
        <fo:table-cell text-align="right" border-bottom-style="solid" border-bottom-width="thin" border-bottom-color="black">
          <fo:block font-weight="bold">${uiLabelMap.AccountingAmount}</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>

    <fo:table-body font-size="10pt">

    <#list vatTaxIds as vatTaxId>
    <#assign taxRate = delegator.findOne("TaxAuthorityRateProduct", Static["org.ofbiz.base.util.UtilMisc"].toMap("taxAuthorityRateSeqId", vatTaxId), true)/>
    <fo:table-row>
        <fo:table-cell>
          <fo:block/>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="1">
            <fo:block>${taxRate.description}</fo:block>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="1" text-align="right">
            <fo:block font-weight="bold"><@ofbizCurrency amount=vatTaxesByType[vatTaxId] isoCode=invoice.currencyUomId?if_exists/></fo:block>
        </fo:table-cell>
    </fo:table-row>
    </#list>
    </fo:table-body>
 </fo:table>
</#if>

 <#-- a block with the invoice message-->
 <#if invoice.invoiceMessage?has_content><fo:block>${invoice.invoiceMessage}</fo:block></#if>
 <fo:block></fo:block>
</#escape>