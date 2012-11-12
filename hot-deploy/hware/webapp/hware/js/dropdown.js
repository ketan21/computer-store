var DropDownMenu = (
    function(menuElement) {
    var menuTitle = menuElement.find("h2:first");
    menuElement.children().each(function(node){
      // if there is a submenu
      var submenu = jQuery(this).find("ul:first");

      if(submenu != null){
        // make sub-menu invisible
        submenu.hide();
        // toggle the visibility of the submenu
        if (menuTitle != null) {
          menuTitle.mouseover (function(){ submenu.css({'display': 'block'});});
          menuTitle.mouseout (function(){submenu.hide();});
        }
        jQuery(this).mouseover (function(){submenu.css({'display': 'block'});});
        jQuery(this).mouseout (function(){submenu.hide();});
      }
    });
  }
);