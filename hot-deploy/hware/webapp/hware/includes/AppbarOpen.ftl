<#assign appModelMenu = Static["org.ofbiz.widget.menu.MenuFactory"].getMenuFromLocation(applicationMenuLocation,applicationMenuName,delegator,dispatcher)>
<#if appModelMenu.getModelMenuItemByName(headerItem)?exists>
  <#if headerItem!="main">
    <#assign show_last_menu = true>
  </#if>
</#if>

<#if parameters.portalPageId?exists && !appModelMenu.getModelMenuItemByName(headerItem)?exists>
  <#assign show_last_menu = true>
</#if>

<div class="tabbar">
  <div class="breadcrumbs<#if show_last_menu?exists> menu_selected</#if>">
    <#if userLogin?has_content>
      <div id="main-navigation">
        <h2>${uiLabelMap.CommonApplications}</h2>
        <ul>
          <li>
            <ul class="main">
              <li>
                <ul class="primary">
                  <#--To do: Use Ui labels here -->
                  <li <#if appBarItem?exists && appBarItem == "Order">class= "selected"</#if>><a href="<@ofbizUrl>OrderMain</@ofbizUrl>">Order</a></li>
                  <li <#if appBarItem?exists && appBarItem == "Facility">class= "selected"</#if>><a href="<@ofbizUrl>FacilityMain</@ofbizUrl>">Stock Summary</a></li>
                  <li <#if appBarItem?exists && appBarItem == "Catalog">class= "selected"</#if>><a href="<@ofbizUrl>CatalogMain</@ofbizUrl>">Catalog</a></li>
                  <li <#if appBarItem?exists && appBarItem == "Party">class="selected"</#if>><a href="<@ofbizUrl>PartyMain</@ofbizUrl>">Party</a></li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </#if>
