<#escape x as x?xml>

        <fo:table border-spacing="3pt" space-before="1in" space-after="1in">
            <fo:table-column column-width="3.75in"/>
            <fo:table-column column-width="3.75in"/>
            <fo:table-body>
                <fo:table-row height="50pt">
                <fo:table-cell>
                </fo:table-cell>
                <fo:table-cell>
                </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="solid" padding="2pt">
                        <fo:block>
                            <fo:block font-weight="bold">${uiLabelMap.OrderAddress}: </fo:block>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border="solid" padding="2pt">
                         <#if quote.partyId?exists>
                                <#assign quotePartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", quote.partyId, "compareDate", quote.issueDate, "userLogin", userLogin))/>
                                <fo:block>${quotePartyNameResult.fullName?default("[${uiLabelMap.OrderPartyNameNotFound}]")}</fo:block>
                            <#else>
                                <fo:block>[${uiLabelMap.OrderPartyNameNotFound}]</fo:block>
                            </#if>
                        <fo:block>
                            <#if toPostalAddress?exists>
                            <fo:block>${toPostalAddress.address1?if_exists}</fo:block>
                            <fo:block>${toPostalAddress.address2?if_exists}</fo:block>
                            <fo:block>${toPostalAddress.city?if_exists}<#if toPostalAddress.stateProvinceGeoId?has_content>, ${toPostalAddress.stateProvinceGeoId}</#if> ${toPostalAddress.postalCode?if_exists}</fo:block>
                            </#if>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
</#escape>
