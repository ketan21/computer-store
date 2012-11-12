import java.util.ArrayList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;

checkoutSteps = [];

shoppingCart = ShoppingCartEvents.getCartObject(request);

// ----------------------------------
// The ordered list of steps is prepared here
// ----------------------------------
checkoutSteps.add([label : "OrderOrderItems", uri : "orderentry", enabled : "Y"])

checkoutSteps.add([label : "Customer", uri : "setCustomer", enabled : "Y"])

checkoutSteps.add([label : "AccountingPayment", uri : "setBilling", enabled : "Y"])

checkoutSteps.add([label : "OrderReviewOrder", uri : "confirmOrder", enabled : "Y"])

// ---------------------------------------
println("===============");
isLastStep = "N";
enabled = "Y";
checkoutSteps.eachWithIndex { checkoutStep, i ->
    checkoutStep.put("enabled", enabled);
    if (enabled.equals("Y")) {
        if (i == (checkoutSteps.size() - 1)) {
        	println("===============");
            isLastStep = "Y";
        }
        if (stepLabelId.equals(checkoutStep.label)) {
            enabled = "N";
        }
    }
}

context.isLastStep = isLastStep;
context.checkoutSteps = checkoutSteps;
