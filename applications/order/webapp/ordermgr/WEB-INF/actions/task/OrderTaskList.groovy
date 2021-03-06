/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.ofbiz.order.task.*;

context.userLogin = userLogin;

// create the sort order
sort = parameters.sort;
sortOrder = ["currentStatusId", "-priority", "orderDate"];
if (sort) {
    if (sort.equals("name")) {
        sortOrder.add(0, "firstName");
        sortOrder.add(0, "lastName");
    } else if (sort.equals("grandTotal")) {
        sortOrder.add(0, "-grandTotal");
    } else {
        sortOrder.add(0, sort);
    }
}

partyBase = [EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "CAL_ACCEPTED"), EntityCondition.makeCondition("wepaPartyId", EntityOperator.EQUALS, userLogin.partyId)];
partyRole = [EntityCondition.makeCondition("orderRoleTypeId", EntityOperator.EQUALS, "PLACING_CUSTOMER"), EntityCondition.makeCondition("orderRoleTypeId", EntityOperator.EQUALS, "SUPPLIER_AGENT")];
partyExpr = [EntityCondition.makeCondition(partyBase, EntityOperator.AND), EntityCondition.makeCondition(partyRole, EntityOperator.OR)];
partyCond = EntityCondition.makeCondition(partyExpr, EntityOperator.AND);
partyTasks = delegator.findList("OrderTaskList", partyCond, null, sortOrder, null, false);

if (partyTasks) partyTasks = EntityUtil.filterByDate(partyTasks);
context.partyTasks = partyTasks;

// Build a map of orderId and currency
orderCurrencyMap = [:];
partyTasks.each { ptItem ->
    orderHeader = delegator.findByPrimaryKey("OrderHeader", [orderId : ptItem.orderId]);
    orderCurrencyMap[ptItem.orderId] = orderHeader.currencyUom;
}

// get this user's roles
partyRoles = delegator.findByAnd("PartyRole", [partyId = userLogin.partyId]);

// build the role list
pRolesList = [];
partyRoles.each { partyRole ->
    if (!partyRole.roleTypeId.equals("_NA_"))
        pRolesList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, partyRole.roleTypeId));
}

custList = [EntityCondition.makeCondition("orderRoleTypeId", EntityOperator.EQUALS, "PLACING_CUSTOMER"), EntityCondition.makeCondition("orderRoleTypeId", EntityOperator.EQUALS, "SUPPLIER_AGENT")];
baseList = [EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_CANCELLED"), EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_COMPLETED"), EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_DELEGATED")];
expressions = [];
expressions.add(EntityCondition.makeCondition(custList, EntityOperator.OR));
if (pRolesList) expressions.add(EntityCondition.makeCondition(pRolesList, EntityOperator.OR));
expressions.add(EntityCondition.makeCondition(baseList, EntityOperator.AND));
conditions = EntityCondition.makeCondition(expressions, EntityOperator.AND);

// invoke the query
roleTasks = delegator.findList("OrderTaskList", conditions, null, sortOrder, null, false);
roleTasks = EntityUtil.filterByAnd(roleTasks, baseList);
roleTasks = EntityUtil.filterByDate(roleTasks);
context.roleTasks = roleTasks;

// Add to the map of orderId and currency
roleTasks.each { rtItem ->
    orderHeader = delegator.findByPrimaryKey("OrderHeader", [orderId : rtItem.orderId]);
    orderCurrencyMap[rtItem.orderId] = orderHeader.currencyUom;
}
context.orderCurrencyMap = orderCurrencyMap;

context.now = nowTimestamp;

// purchase order schedule
poList = delegator.findByAnd("OrderHeaderAndRoles", [partyId : userLogin.partyId, orderTypeId : "PURCHASE_ORDER"]);
poIter = poList.iterator();
listedPoIds = new HashSet();
while (poIter.hasNext()) {
    poGv = poIter.next();
    poOrderId = poGv.orderId;
    if (listedPoIds.contains(poOrderId)) {
        poIter.remove();
    } else {
        listedPoIds.add(poOrderId);
    }
}
context.poList = poList;

