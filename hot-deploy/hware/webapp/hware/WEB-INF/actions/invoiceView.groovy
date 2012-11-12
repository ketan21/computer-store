import java.math.BigDecimal;
import java.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.*;
import org.ofbiz.base.util.collections.*;
import org.ofbiz.order.order.*;
import org.ofbiz.party.contact.*;

import org.ofbiz.accounting.payment.*;


orderId = parameters.orderId;
context.orderId = orderId;
orderHeader = null;
if (orderId) {
    orderHeader = delegator.findByPrimaryKey("OrderHeader", [orderId : orderId]);
}
if (orderHeader) {    
    // note these are overridden in the OrderViewWebSecure.groovy script if run
    context.hasPermission = true;
    context.canViewInternalDetails = true;

    orderReadHelper = new OrderReadHelper(orderHeader);
    context.orderHeader = orderHeader;
    orderType = orderHeader.orderTypeId;
    context.orderType = orderType;

    // get the display party
    displayParty = null;
    if ("PURCHASE_ORDER".equals(orderType)) {
        displayParty = orderReadHelper.getSupplierAgent();
    } else {
        displayParty = orderReadHelper.getPlacingParty();
    }
    if (displayParty) {
        partyId = displayParty.partyId;
        context.displayParty = displayParty;
        context.partyId = partyId;

        paymentMethodValueMaps = PaymentWorker.getPartyPaymentMethodValueMaps(delegator, displayParty.partyId, false);
        context.paymentMethodValueMaps = paymentMethodValueMaps;
    }
    
    shippingAddress = orderReadHelper.getShippingAddress();
    context.shippingAddress = shippingAddress;
    billingAddress=null;
    context.billingAddress = shippingAddress;
    
    ecl = EntityCondition.makeCondition([
                                         EntityCondition.makeCondition("orderId", EntityOperator.EQUALS, orderId),
                                         EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "PAYMENT_CANCELLED")],
                                     EntityOperator.AND);
    orderPaymentPreferences = delegator.findList("OrderPaymentPreference", ecl, null, null, null, false);
    context.orderPaymentPreferences = orderPaymentPreferences;
}


