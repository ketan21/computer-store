package com.softitude.hware;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.HttpClient;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.webapp.control.RequestHandler;

/**
 * User Validation Events
 */

public class CommonEvents {
     public static String checkProductStoreId(HttpServletRequest request, HttpServletResponse response) {

        String checkUserProductStore = (String) request.getParameter("checkUserProductStore");

        if ("N".equals(checkUserProductStore)) {
            return "success";
        }
        String module = CommonEvents.class.getName();

        HttpSession session = request.getSession();
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        String productStoreId = (String) session
                .getAttribute("productStoreId");
        List<GenericValue> productStoreRoleList = null;
        if (userLogin == null || productStoreId != null) {
            return "success";
        }

        try {
            List<EntityCondition> exprList = FastList.newInstance();
            exprList.add(EntityCondition.makeCondition("partyId" , EntityOperator.EQUALS , userLogin.get("partyId")));
            exprList.add(EntityCondition.makeCondition("roleTypeId" , EntityOperator.IN  , UtilMisc.toList("OWNER","MANAGER")));

            EntityConditionList<EntityCondition> mainCond = EntityCondition.makeCondition(exprList, EntityOperator.AND);

            productStoreRoleList = delegator.findList("ProductStoreRole", mainCond, null, null, null, false);
            if (productStoreRoleList.size() > 1) {
                List<String> productStoreIds = EntityUtil.getFieldListFromEntityList(productStoreRoleList, "productStoreId", true);
                List<GenericValue> userProductStores = delegator.findList("ProductStore", EntityCondition.makeCondition("productStoreId", EntityOperator.IN,productStoreIds), null, null, null, false);
                // If user associated with more then one productStores then
                // redirect it to select productStore page.
                session.setAttribute("userProductStores", userProductStores);
                ServletContext ctx = (ServletContext) request.getAttribute("servletContext");
                RequestHandler rh = (RequestHandler) ctx.getAttribute("_REQUEST_HANDLER_");
                String target = rh.makeLink(request, response,"SelectProductStore?checkUserProductStore=N", false, false, false);
                response.sendRedirect(target);
                return null;
            } else if (productStoreRoleList.size() == 1) {
                // if user is associated to only one productStore then set
                // productStoreId to session
                GenericValue productStoreRole = EntityUtil.getFirst(productStoreRoleList);
                session.setAttribute("productStoreId", productStoreRole.getString("productStoreId"));
                }
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
        } catch (IOException e) {
            Debug.logError(e, "Problem in redirecting request", module);
            return "error";
        }
        return "success";
    }

     public static String setProductStore(HttpServletRequest request, HttpServletResponse response ) {
          HttpSession session=request.getSession();
          Delegator delegator = (Delegator) request.getAttribute("delegator");
          String productStoreId = request.getParameter("productStoreId");
          session.setAttribute("productStoreId", productStoreId);
          try {
              GenericValue productStore = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), false);
              session.setAttribute("productStore", productStore);
              session.setAttribute("facilityId", productStore.getString("inventoryFacilityId"));
              Debug.log("facilityId is ---------------------" + productStore.getString("inventoryFacilityId"));
              // Set productstore specific top category Id (Root Category) in session
              GenericValue productStoreCatalog = EntityUtil.getFirst(productStore.getRelated("ProductStoreCatalog"));
              String topCategoryId = CatalogWorker.getCatalogTopCategoryId(request, productStoreCatalog.getString("prodCatalogId"));
              session.setAttribute("topCategoryId", topCategoryId);
          } catch (GenericEntityException e) {
              e.printStackTrace();
          }

          if (session.getAttribute("productStoreId") != null || session.getAttribute("productStore") != null) {
             return "success";
          } else {
             return "error";
          }
     }
     
}
