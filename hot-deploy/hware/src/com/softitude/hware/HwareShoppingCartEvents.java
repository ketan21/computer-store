package com.softitude.hware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.security.Security;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class HwareShoppingCartEvents {

     public static final String resource_error = "OrderErrorUiLabels";

     public static String initializeOrder(HttpServletRequest request, HttpServletResponse response) {

          Delegator delegator = (Delegator) request.getAttribute("delegator");
          HttpSession session = request.getSession();
          GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
          Locale locale = UtilHttp.getLocale(request);
          // Security ????
          Security security = (Security) request.getAttribute("security");
          String productStoreId = (String) session.getAttribute("productStoreId");
          GenericValue productStore = (GenericValue) session.getAttribute("productStore");
          ShoppingCart cart = ShoppingCartEvents.getCartObject(request);

          // orderMode="SALES_ORDER" hidden parameter??
          String orderMode = "SALES_ORDER";
          cart.setOrderType(orderMode);
          session.setAttribute("orderMode", orderMode);
          // check the selected product store
          if (productStore != null) {
               // check permission for taking the order
               boolean hasPermission = false;
               if (cart.getOrderType().equals("SALES_ORDER")) {
                    if (security.hasEntityPermission("ORDERMGR", "_SALES_CREATE", session)) {
                         hasPermission = true;
                    }
               }
               if (hasPermission) {
                    cart = ShoppingCartEvents.getCartObject(request, null,productStore.getString("defaultCurrencyUomId"));
               } else {
                    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resource_error,"OrderYouDoNotHavePermissionToTakeOrdersForThisStore",locale));
                    cart.clear();
                    session.removeAttribute("orderMode");
                    return "error";
               }
               cart.setProductStoreId(productStoreId);
          } else {
               cart.setProductStoreId(null);
          }
          if ("SALES_ORDER".equals(cart.getOrderType()) && UtilValidate.isEmpty(cart.getProductStoreId())) {
               request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resource_error, "OrderAProductStoreMustBeSelectedForASalesOrder", locale));
               cart.clear();
               session.removeAttribute("orderMode");
               return "error";
          }
          // Set default values required for checkout
          cart.setFacilityId((String)session.getAttribute("facilityId"));
          cart.setShipmentMethodTypeId(0, "NO_SHIPPING");
          cart.setCarrierPartyId(0, "_NA_");
         // cart.addPayment("CASH");

          return "success";
     }

     /**
      * Totally wipe out the cart, removes all stored info. This method is
      * imported from OOTB because we don't want to remove the session attribute
      * 'productStoreId'
      */
     public static String destroyCart(HttpServletRequest request, HttpServletResponse response) {
          HttpSession session = request.getSession();
          ShoppingCartEvents.clearCart(request, response);
          session.removeAttribute("shoppingCart");
          session.removeAttribute("orderPartyId");
          session.removeAttribute("orderMode");
          session.removeAttribute("CURRENT_CATALOG_ID");
          return "success";
     }
/**
 * Overriden from ShoppingCartEvents.java to allow our custom destroyCart method to run.
 * 
 * @param request
 * @param response
 * @return
 */
     public static String createQuoteFromCart(HttpServletRequest request, HttpServletResponse response) {
         LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
         HttpSession session = request.getSession();
         GenericValue userLogin = (GenericValue)session.getAttribute("userLogin");

         ShoppingCart cart = ShoppingCartEvents.getCartObject(request);
         Map result = null;
         String quoteId = null;
         try {
             result = dispatcher.runSync("createQuoteFromCart",
                     UtilMisc.toMap("cart", cart,
                             "userLogin", userLogin));
             quoteId = (String) result.get("quoteId");
         } catch (GenericServiceException exc) {
             request.setAttribute("_ERROR_MESSAGE_", exc.getMessage());
             return "error";
         }
         if (ServiceUtil.isError(result)) {
            request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(result));
            return "error";
         }
         request.setAttribute("quoteId", quoteId);

         destroyCart(request, response);

         return "success";
     }

     public static String determineNextStep (HttpServletRequest request, HttpServletResponse response){
         
         ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("shoppingCart");
         
         boolean requireCustomer = true;
         
         boolean requirePayment = true;
         
         HttpSession session = request.getSession();
         
         String requireCustomerStr = request.getParameter("finalizeReqCustInfo");
         
         String mode = request.getParameter("finalizeMode");
         
         String requirePaymentStr = request.getParameter("finalizeReqPayInfo");
         requireCustomer = requireCustomerStr == null || requireCustomerStr.equalsIgnoreCase("true");
         if (requirePayment) {
             requirePayment = requirePaymentStr == null || requirePaymentStr.equalsIgnoreCase("true");
         }
         String customerPartyId = cart.getPartyId();
          
         if (mode != null && mode.equals("payment")) {
        	 String paymentMethod = request.getParameter("checkOutPaymentId"); 
        	 Debug.log("===============payment=========================="+paymentMethod);
        	 cart.addPayment(paymentMethod);
        	 if (paymentMethod.equals("CASH"))
        	 session.setAttribute("faceToFace","true");
        	 else
        	 session.setAttribute("faceToFace","false");
        	 
         }
         
         String[] processOrder = {"customer", "payment"};
                                  
         for (int i = 0; i < processOrder.length; i++) {
             String currProcess = processOrder[i];
             if (currProcess.equals("customer")) {
           
                 if (requireCustomer && (customerPartyId == null || customerPartyId.equals("_NA_"))) {
                     return "customer";
                 }
             } else if (currProcess.equals("payment")) {
                 List paymentMethodIds = cart.getPaymentMethodIds();
                 List paymentMethodTypeIds = cart.getPaymentMethodTypeIds();
                 if (requirePayment && UtilValidate.isEmpty(paymentMethodIds) && UtilValidate.isEmpty(paymentMethodTypeIds))
                 {
                     return "payment";
                 }}
      }
         if ("SALES_ORDER".equals(cart.getOrderType())) {
          return "sales";
      } else {
          return "error";
      }
       
 }  
}
