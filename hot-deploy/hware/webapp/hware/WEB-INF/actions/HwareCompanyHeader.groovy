import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.party.contact.*;
import org.ofbiz.order.order.OrderReadHelper;
import java.sql.Timestamp;



orderHeader = parameters.orderHeader;
orderId = parameters.orderID;
fromPartyId = parameters.fromPartyId;
shipmentId = parameters.shipmentId;

if (!orderHeader && orderId) {
    orderHeader = delegator.findByPrimaryKey("OrderHeader", [orderId : orderId]);
} else if (shipmentId) {
    shipment = delegator.findByPrimaryKey("Shipment", [shipmentId : shipmentId]);
    orderHeader = shipment.getRelatedOne("PrimaryOrderHeader");
}


// defaults:
logoImageUrl = "/images/ofbiz_powered.gif"; // the default value, "/images/ofbiz_powered.gif", is set in the screen decorators
partyId = null;

// get the logo partyId from order or invoice - note that it is better to do comparisons this way in case the there are null values
if (orderHeader) {
    orh = new OrderReadHelper(orderHeader);
    // for sales order, the logo party is the "BILL_FROM_VENDOR" of the order.  If that's not available, we'll use the OrderHeader's ProductStore's payToPartyId
    if ("SALES_ORDER".equals(orderHeader.orderTypeId)) {
        if (orh.getBillToParty()) {
            partyId = orh.getBillFromParty().partyId;
        } else {
            productStore = orderHeader.getRelatedOne("ProductStore");
            if (orderHeader.orderTypeId.equals("SALES_ORDER") && productStore?.payToPartyId) {
                partyId = productStore.payToPartyId;
            }
        }
    // purchase orders - use the BILL_TO_CUSTOMER of the order
    } else if ("PURCHASE_ORDER".equals(orderHeader.orderTypeId)) {
        partyId = orh.getBillToParty().partyId;
        billToCustomer = EntityUtil.getFirst(orderHeader.getRelatedByAnd("OrderRole", [roleTypeId : "BILL_TO_CUSTOMER"]));
        if (billToCustomer) {
            partyId = billToCustomer.partyId;
        }
    }
} 

// if partyId wasn't found use fromPartyId-parameter
if (!partyId) {
    if (fromPartyId) {
        partyId = fromPartyId;
    } else {
        partyId = "Company";
    }
}

// the logo
partyGroup = delegator.findByPrimaryKey("PartyGroup", [partyId : partyId]);
if (partyGroup?.logoImageUrl) {
    logoImageUrl = partyGroup.logoImageUrl;
}
context.logoImageUrl = logoImageUrl;

// the company name
companyName = "not found";
if (partyGroup?.groupName) {
    companyName = partyGroup.groupName;
}
context.companyName = companyName;
// the address
addresses = delegator.findByAnd("PartyContactMechPurpose", [partyId : partyId, contactMechPurposeTypeId : "GENERAL_LOCATION"]);
selAddresses = EntityUtil.filterByDate(addresses, nowTimestamp, "fromDate", "thruDate", true);
address = null;
if (selAddresses) {
    address = delegator.findByPrimaryKey("PostalAddress", [contactMechId : selAddresses[0].contactMechId]);
}
if (address)    {
   // get the country name and state/province abbreviation
   country = address.getRelatedOneCache("CountryGeo");
   if (country) {
      context.countryName = country.geoName;
   }
   stateProvince = address.getRelatedOneCache("StateProvinceGeo");
   if (stateProvince) {
       context.stateProvinceAbbr = stateProvince.abbreviation;
   }
}
context.postalAddress = address;

//telephone
phones = delegator.findByAnd("PartyContactMechPurpose", [partyId : partyId, contactMechPurposeTypeId : "PRIMARY_PHONE"]);
selPhones = EntityUtil.filterByDate(phones, nowTimestamp, "fromDate", "thruDate", true);
if (selPhones) {
    context.phone = delegator.findByPrimaryKey("TelecomNumber", [contactMechId : selPhones[0].contactMechId]);
}

// Fax 
faxNumbers = delegator.findByAnd("PartyContactMechPurpose", [partyId : partyId, contactMechPurposeTypeId : "FAX_NUMBER"]);
faxNumbers = EntityUtil.filterByDate(faxNumbers, nowTimestamp, null, null, true);
if (faxNumbers) {  
    context.fax = delegator.findOne("TelecomNumber", [contactMechId : faxNumbers[0].contactMechId], false);
}

//Email
emails = delegator.findByAnd("PartyContactMechPurpose", [partyId : partyId, contactMechPurposeTypeId : "PRIMARY_EMAIL"]);
selEmails = EntityUtil.filterByDate(emails, nowTimestamp, "fromDate", "thruDate", true);
if (selEmails) {
    context.email = delegator.findByPrimaryKey("ContactMech", [contactMechId : selEmails[0].contactMechId]);
} else {    //get email address from party contact mech
    contacts = delegator.findByAnd("PartyContactMech", [partyId : partyId]);
    selContacts = EntityUtil.filterByDate(contacts, nowTimestamp, "fromDate", "thruDate", true);
    if (selContacts) {
        i = selContacts.iterator();
        while (i.hasNext())    {
            email = i.next().getRelatedOne("ContactMech");
            if ("ELECTRONIC_ADDRESS".equals(email.contactMechTypeId))    {
                context.email = email;
                break;
            }
        }
    }
}

// website
contacts = delegator.findByAnd("PartyContactMech", [partyId : partyId]);
selContacts = EntityUtil.filterByDate(contacts, nowTimestamp, "fromDate", "thruDate", true);
if (selContacts) {
    Iterator i = selContacts.iterator();
    while (i.hasNext())    {
        website = i.next().getRelatedOne("ContactMech");
        if ("WEB_ADDRESS".equals(website.contactMechTypeId)) {
            context.website = website;
            break;
        }
    }
}

//Bank account
paymentMethods = delegator.findByAnd("PaymentMethod", [partyId : partyId, paymentMethodTypeId : "EFT_ACCOUNT"]);
selPayments = EntityUtil.filterByDate(paymentMethods, nowTimestamp, "fromDate", "thruDate", true);
if (selPayments) {
    context.eftAccount = delegator.findByPrimaryKey("EftAccount", [paymentMethodId : selPayments[0].paymentMethodId]);
}
