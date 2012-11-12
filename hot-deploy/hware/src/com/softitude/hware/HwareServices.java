package com.softitude.hware;
import java.util.HashMap;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.order.OrderChangeHelper;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;

public class HwareServices {
	
    public static Map HwareCompleteOrder (DispatchContext ctx, Map context) {
        LocalDispatcher dispatcher = ctx.getDispatcher();
        Delegator delegator = ctx.getDelegator();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        String orderId = (String) context.get("orderId");
        Map result = new HashMap();
        boolean ok = OrderChangeHelper.completeOrder(dispatcher, userLogin, orderId);
        if (ok)
        {
        Debug.log("=========================================ok================================"+ok);
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);	
        return result;
        }
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_ERROR);
        return result;
        }
}
