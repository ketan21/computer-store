
// Check Box Select/Toggle Functions for Select/Toggle All

function toggle(e) {
    e.checked = !e.checked;
}

function checkToggleDefault(e) {
    checkToggle(e, "selectAllForm");
}
function checkToggle(e, formName) {
    var cform = document[formName];
    if (e.checked) {
        var len = cform.elements.length;
        var allchecked = true;
        for (var i = 0; i < len; i++) {
            var element = cform.elements[i];
            if (element.name.substring(0, 10) == "_rowSubmit" && !element.checked) {
                allchecked = false;
            }
            cform.selectAll.checked = allchecked;
        }
    } else {
        cform.selectAll.checked = false;
    }
}

function toggleAllDefault(e) {
    toggleAll(e, "selectAllForm");
}
function toggleAll(e, formName) {
    var cform = document[formName];
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        if (element.name.substring(0, 10) == "_rowSubmit" && element.checked != e.checked) {
            toggle(element);
        }
    }
}

function selectAllDefault() {
    selectAll("selectAllForm");
}
function selectAll(formName) {
    var cform = document[formName];
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        if ((element.name == "selectAll" || element.name.substring(0, 10) == "_rowSubmit") && !element.checked) {
            toggle(element);
        }
    }
}

function removeSelectedDefault() {
    removeSelected("selectAllForm");
}
function removeSelected(formName) {
    var cform = document[formName];
    cform.removeSelected.value = true;
    cform.submit();
}

// highlight the selected row(s)

function highlightRow(e,rowId){
    var currentClassName = document.getElementById(rowId).className;
    if (e.checked) {
        if (currentClassName == '' ) {
            document.getElementById(rowId).className = 'selected';
        } else if (currentClassName == 'alternate-row') {
            document.getElementById(rowId).className = 'alternate-rowSelected';
        }
    } else {
        if (currentClassName == 'selected') {
            document.getElementById(rowId).className = '';
        } else if (currentClassName == 'alternate-rowSelected') {
            document.getElementById(rowId).className = 'alternate-row';
        }
    }
}

function highlightAllRows(e, halfRowId, formName){
    var cform = document[formName];
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        if (element.name.substring(0, 10) == "_rowSubmit") {
            highlightRow(e, halfRowId+element.name.substring(13));
        }
    }
}

// popup windows functions

function popUp(url, name, height, width) {
    popupWindow = window.open(url, name, 'location=no,scrollbars,width=' + width + ',height=' + height);
}
function popUpSmall(url, name) {
    popUp(url, name, '300', '450');
}
function popUpPrint(printserver, screen1) {
    popUpPrint(printserver, screen1, null, null);
}
function popUpPrint(printserver, screen1, screen2) {
    popUpPrint(printserver, screen1, screen2, null);
}
function popUpPrint(printserver, screen1, screen2, screen3) {
    if  (printserver == null) {
        printserver = "http://localhost:10080/"; // default print server port
    }

    if (screen1 != null) {
        screen1 = screen1.replace(/\:/g, "%3A");
        screen1 = screen1.replace(/\//g, "%2F");
        screen1 = screen1.replace(/\#/g, "%23");
        screen1 = screen1.replace(/\?/g, "%3F");
        screen1 = screen1.replace(/\=/g, "%3D");
        url = printserver + screen1;
        window.open(url, "screen1", 'location=no,statusbar=1,menubar=0,scrollbars,width=60,height=10,top=0,left=0');
        self.focus();

        if (screen2 != null) {
            screen2 = screen2.replace(/\:/g, "%3A");
            screen2 = screen2.replace(/\//g, "%2F");
            screen2 = screen2.replace(/\#/g, "%23");
            screen2 = screen2.replace(/\?/g, "%3F");
            screen2 = screen2.replace(/\=/g, "%3D");
            url = printserver + screen2;
            window.open(url, "screen2", 'location=no,statusbar=1,menubar=0,scrollbars,width=60,height=10,top=0,left=0');
            self.focus();

            if (screen3 != null) {
                screen3 = screen3.replace(/\:/g, "%3A");
                screen3 = screen3.replace(/\//g, "%2F");
                screen3 = screen3.replace(/\#/g, "%23");
                screen3 = screen3.replace(/\?/g, "%3F");
                screen3 = screen3.replace(/\=/g, "%3D");
                url = printserver + screen3;
                window.open(url, "screen13", 'location=no,statusbar=1,menubar=0,scrollbars,width=60,height=10,top=0,left=0');
                self.focus();
            }
        }
    }
}

// Post a form from a pop up using the parent window
function doPostViaParent(formName) {
    var theForm = document[formName];
    var newForm = theForm.cloneNode(true);
    var hiddenDiv = document.createElement('div');
    hiddenDiv.style.visibility = 'hidden';
    hiddenDiv.appendChild(newForm);
    window.opener.document.body.appendChild(hiddenDiv);
    newForm.submit();
    window.opener.focus();
}
// From a child window, navigate the parent window to the supplied url
function doGetViaParent(url) {
    window.opener.location = url;
    window.opener.focus();
}

// hidden div functions

function getStyleObject(objectId) {
    if (document.getElementById && document.getElementById(objectId)) {
        return document.getElementById(objectId).style;
    } else if (document.all && document.all(objectId)) {
        return document.all(objectId).style;
    } else if (document.layers && document.layers[objectId]) {
        return document.layers[objectId];
    } else {
        return false;
    }
}
function changeObjectVisibility(objectId, newVisibility) {
    var styleObject = getStyleObject(objectId);
    if (styleObject) {
        styleObject.visibility = newVisibility;
        return true;
    } else {
        return false;
    }
}

// To use this in a link use a URL like this: javascript:confirmActionLink('You want to delete this party?', 'deleteParty?partyId=${partyId}')
function confirmActionLink(msg, newLocation) {
    if (msg == null) {
        msg = "Are you sure you want to do this?";
    }
    var agree = confirm(msg);
    if (agree) {
        if (newLocation != null) location.replace(newLocation);
    }
}

// To use this in a link use a URL like this: javascript:confirmActionFormLink('You want to update this party?', 'updateParty')
function confirmActionFormLink(msg, formName) {
    if (msg == null) {
        msg = "Are you sure you want to do this?";
    }
    var agree = confirm(msg);
    if (agree) {
        if (formName != null) document.forms[formName].submit();
    }
}

// ===== Ajax Functions - based on protoype.js ===== //

/** Update an area (HTML container element).
  * @param areaId The id of the HTML container to update
  * @param target The URL to call to update the HTML container
  * @param targetParams The URL parameters
*/
function ajaxUpdateArea(areaId, target, targetParams) {
    waitSpinnerShow();
    new Ajax.Updater(areaId, target, {parameters: targetParams, evalScripts: true,
        onSuccess: function(transport) {waitSpinnerHide();},
        onFailure: function() {waitSpinnerHide();}
    });
}

/** Update multiple areas (HTML container elements).
  * @param areaCsvString The area CSV string. The CSV string is a flat array in the
  * form of: areaId, target, target parameters [, areaId, target, target parameters...].
*/
function ajaxUpdateAreas(areaCsvString) {
    waitSpinnerShow();
    var areaArray = areaCsvString.split(",");
    var numAreas = parseInt(areaArray.length / 3);
    for (var i = 0; i < numAreas * 3; i = i + 3) {
        jQuery("#" + areaArray[i]).load(areaArray[i + 1], areaArray[i + 2], function () {waitSpinnerHide();});
    }
}

/** Update an area (HTML container element) periodically.
  * @param areaId The id of the HTML container to update
  * @param target The URL to call to update the HTML container
  * @param targetParams The URL parameters
  * @param interval The update interval, in seconds.
*/
function ajaxUpdateAreaPeriodic(areaId, target, targetParams, interval) {
    new Ajax.PeriodicalUpdater(areaId, target, {parameters: targetParams, frequency: interval});
}

/** Submit request, update multiple areas (HTML container elements).
  * @param target The URL to call to update the HTML container
  * @param targetParams The URL parameters
  * @param areaCsvString The area CSV string. The CSV string is a flat array in the
  * form of: areaId, target, target parameters [, areaId, target, target parameters...].
*/
function ajaxSubmitRequestUpdateAreas(target, targetParams, areaCsvString) {
    updateFunction = function(transport) {
        ajaxUpdateAreas(areaCsvString);
    }
    new Ajax.Request(target, {
        parameters: targetParams,
        onComplete: updateFunction });
}

/** Submit form, update an area (HTML container element).
  * @param form The form element
  * @param areaId The id of the HTML container to update
  * @param submitUrl The URL to call to update the HTML container
*/
function submitFormInBackground(form, areaId, submitUrl) {
    submitFormDisableSubmits(form);
    updateFunction = function() {
        new Ajax.Updater(areaId, submitUrl);
    }
    new Ajax.Request(form.action, {
        parameters: form.serialize(true),
        onComplete: updateFunction });
}

/** Submit form, update multiple areas (HTML container elements).
 * @param form The form element
 * @param areaCsvString The area CSV string. The CSV string is a flat array in the
 * form of: areaId, target, target parameters [, areaId, target, target parameters...].
*/
function ajaxSubmitFormUpdateAreas(form, areaCsvString) {
   waitSpinnerShow();
   hideErrorContainer = function() {
       jQuery('#content-messages').removeClass('errorMessage').fadeIn('fast');
   }
   updateFunction = function(data) {
       if (data._ERROR_MESSAGE_LIST_ != undefined || data._ERROR_MESSAGE_ != undefined) {
           if(!jQuery('#content-messages')) {
              //add this div just after app-navigation
              if(jQuery('#content-main-section')){
                  jQuery('#content-main-section' ).before('<div id="content-messages" onclick="hideErrorContainer()"></div>');
              }
           }
           jQuery('#content-messages').addClass('errorMessage');
          if (data._ERROR_MESSAGE_LIST_ != undefined && data._ERROR_MESSAGE_ != undefined) {
              jQuery('#content-messages' ).html(data._ERROR_MESSAGE_LIST_ + " " + data._ERROR_MESSAGE_);
          } else if (data._ERROR_MESSAGE_LIST_ != undefined) {
              jQuery('#content-messages' ).html(data._ERROR_MESSAGE_LIST_);
          } else {
              jQuery('#content-messages' ).html(data._ERROR_MESSAGE_);
          }
          jQuery('#content-messages').fadeIn('fast');
       }else {
           if(jQuery('#content-messages')) {
               jQuery('#content-messages').removeClass('errorMessage').fadeIn("fast");
           }
           ajaxUpdateAreas(areaCsvString);
       }
       waitSpinnerHide();
   }
   
   jQuery.ajax({
       type: "POST",
       url: jQuery("#" + form).attr("action"),
       data: jQuery("#" + form).serialize(),
       dataType: "json",
       success: function(data) {
               updateFunction(data);
       }
   });
}

/** Enable auto-completion for text elements.
 * @param areaCsvString The area CSV string. The CSV string is a flat array in the
 * form of: areaId, target, target parameters [, areaId, target, target parameters...].
*/
function ajaxAutoCompleter(areaCsvString, showDescription) {
   var areaArray = areaCsvString.replace('&amp;','&').split(",");
   var numAreas = parseInt(areaArray.length / 3);

   for (var i = 0; i < numAreas * 3; i = i + 3) {
          var url = areaArray[i + 1] + "?" + areaArray[i + 2];
          var div = areaArray[i];
          // create a seperate div where the result JSON Opbject will be placed
          if ((jQuery("#" + div + "_auto")).length < 1) {
              jQuery("<div id='" + div + "_auto'></div>").insertBefore("#" + areaArray[i]);
          }
          
          jQuery("#" + div).autocomplete({
           source: function(request, response) {
                jQuery.ajax({
                    url: url,
                    async: false,
                    data: {term : request.term},
                    success: function(data) {
                        //update the result div
                        jQuery("#" + div + "_auto").html(data)
                        // autocomp is the JSON Object which will be used for the autocomplete box
                        response(autocomp);
                    }
                })
            }
        });
   }
}

function setSelection(text, li) {
    text.value = li.id;
    var delay = function() { text.fire("lookup:changed"); };
    setTimeout(delay, 100);
}

function setLookDescription(textFieldId, description) {
    if (description) {
        var start = description.lastIndexOf(' [');
        if (start != -1) {
            description = description.substring(0, start);
        }
    }
    var lookupWrapperEl = $(textFieldId).up('.field-lookup');
    if (lookupWrapperEl) {
        var tooltipElement = $(textFieldId + '_lookupDescription');
        if (!tooltipElement) {
            tooltipElement = new Element('span', {id : textFieldId + '_lookupDescription', 'class' : 'tooltip'});
        }
        tooltipElement.update(description);
        lookupWrapperEl.appendChild(tooltipElement);
    }
}

/** Enable auto-completion for drop-down elements.
  * @param descriptionElement The id of the text field
  * @param hiddenElement The id of the drop-down.  Used as the id of hidden field inserted.
  * @param data Choices for Autocompleter.Local, form of: {key: 'description',.......}
  * @param options
*/

function ajaxAutoCompleteDropDown(descriptionElement, hiddenElement, data, options) {
    var update = hiddenElement + "_autoCompleterOptions";
    $(descriptionElement).insert({after: '<div class="autocomplete"' + 'id=' + update + '></div>'});
    new Autocompleter.Local($(descriptionElement), update, $H(data), {autoSelect: options.autoSelect, frequency: options.frequency, minChars: options.minChars, choices: options.choices, partialSearch: options.partialSearch, partialChars: options.partialChars, ignoreCase: options.ignoreCase, fullSearch: options.fullSearch, afterUpdateElement: setKeyAsParameter});

    function setKeyAsParameter(text, li) {
        $(hiddenElement).value = li.id;
    }
}

/** Toggle area visibility on/off.
 * @param link The <a> element calling this function
 * @param areaId The id of the HTML container to toggle
 * @param expandTxt Localized 'Expand' text
 * @param collapseTxt Localized 'Collapse' text
*/
function toggleCollapsiblePanel(link, areaId, expandTxt, collapseTxt){
   var container = jQuery("#" + areaId);
   var liElement = jQuery(link).parents('li:first');
   if(container.is(':visible')){
       liElement.removeClass('expanded');
       liElement.addClass('collapsed');
       link.title = expandTxt;
   } else {
       liElement.removeClass('collapsed');
       liElement.addClass('expanded');
       link.title = collapseTxt;
   }
   container.animate({opacity: 'toggle', height: 'toggle'}, "slow");
}

/** Toggle screenlet visibility on/off.
 * @param link The <a> element calling this function
 * @param areaId The id of the HTML container to toggle
 * @param expandTxt Localized 'Expand' text
 * @param collapseTxt Localized 'Collapse' text
*/
function toggleScreenlet(link, areaId, saveCollapsed, expandTxt, collapseTxt){
   toggleCollapsiblePanel(link, areaId, expandTxt, collapseTxt);
   var container = jQuery("#" + areaId);
   var screenlet = jQuery(link).parents('div:first');;
   if(container.is(':visible')){
       var currentParam = screenlet.id + "_collapsed=false";
       var newParam = screenlet.id + "_collapsed=true";
       if(saveCollapsed=='true'){
           setUserLayoutPreferences('GLOBAL_PREFERENCES',screenlet.id+"_collapsed",'true');
       }
   } else {
       var currentParam = screenlet.id + "_collapsed=true";
       var newParam = screenlet.id + "_collapsed=false";
       if(saveCollapsed=='true'){
           setUserLayoutPreferences('GLOBAL_PREFERENCES',screenlet.id+"_collapsed",'false');
       }
   }
   var paginationMenus = jQuery('div.nav-pager');
   jQuery.each(paginationMenus, function(menu) {
       if (menu) {
           var childElements = menu.getElementsByTagName('a');
           for (var i = 0; i < childElements.length; i++) {
               if (childElements[i].href.indexOf("http") == 0) {
                   childElements[i].href = replaceQueryParam(childElements[i].href, currentParam, newParam);
               }
           }
           childElements = menu.getElementsByTagName('select');
           for (i = 0; i < childElements.length; i++) {
               if (childElements[i].href.indexOf("location.href") >= 0) {
                   Element.extend(childElements[i]);
                   childElements[i].writeAttribute("onchange", replaceQueryParam(childElements[i].readAttribute("onchange"), currentParam, newParam));
               }
           }
       }
   });
}

/** In Place Editor for display elements
  * @param element The id of the display field
  * @param url The request to be called to update the display field
  * @param options Options to be passed to Ajax.InPlaceEditor
*/

function ajaxInPlaceEditDisplayField(element, url, options) {
    var jElement = jQuery("#" + element);
    jElement.mouseover(function() {
        $(this).css('background-color', 'rgb(255, 255, 153)');
    });
    
    jElement.mouseout(function() {
        $(this).css('background-color', 'transparent');
    });
    
    jElement.editable(function(value, settings){
        // removes all line breaks from the value param, because the parseJSON Function can't work with line breaks
        value = value.replace("\n", " ");
        var resultField = jQuery.parseJSON('{"' + settings.name + '":"' + value + '"}');
        // merge both parameter objects together
        jQuery.extend(settings.submitdata, resultField);
        jQuery.ajax({
            type : settings.method,
            url : url,
            data : settings.submitdata,
            success : function(data) {
                // adding the new value to the field and make the modified field 'blink' a little bit to show the user that somethink have changed
                jElement.html(value).fadeOut(500).fadeIn(500).fadeOut(500).fadeIn(500).css('background-color', 'transparent');
            }
        });
    }, options);
}

// ===== End of Ajax Functions ===== //

function replaceQueryParam(queryString, currentParam, newParam) {
    var result = queryString.replace(currentParam, newParam);
    if (result.indexOf(newParam) < 0) {
        if (result.indexOf("?") < 0) {
            result = result + "?" + newParam;
        } else if (result.endsWith("#")) {
            result = result.replace("#", "&" + newParam + "#");
        } else if (result.endsWith(";")) {
            result = result.replace(";", " + '&" + newParam + "';");
        } else {
            result = result + "&" + newParam;
        }
    }
    return result;
}

function submitFormDisableSubmits(form) {
    for (var i=0;i<form.length;i++) {
        var formel = form.elements[i];
        if (formel.type == "submit") {
            submitFormDisableButton(formel);
            var formName = form.name;
            var formelName = formel.name;
            var timeoutString = "submitFormEnableButtonByName('" + formName + "', '" + formelName + "')";
            var t = setTimeout(timeoutString, 1500);
        }
    }
}

// prevents doubleposts for <submit> inputs of type "button" or "image"
function submitFormDisableButton(button) {
    if (button.form.action != null && button.form.action.length > 0) {
        button.disabled = true;
    }
    button.className = button.className + " disabled";
    button.value = button.value + "*";
}

function submitFormEnableButtonByName(formName, buttonName) {
    // alert("formName=" + formName + " buttonName=" + buttonName);
    var form = document[formName];
    var button = form.elements[buttonName];
    submitFormEnableButton(button);
}
function submitFormEnableButton(button) {
    button.disabled = false;
    button.className = button.className.substring(0, button.className.length - " disabled".length);
    button.value = button.value.substring(0, button.value.length - 1);
}

function expandAll(expanded) {
  var divs,divs1,i,j,links,groupbody;

  divs=document.getElementsByTagName('div');
  for(i=0;i<divs.length;i++) {
    if(/fieldgroup$/.test(divs[i].className)) {
      links=divs[i].getElementsByTagName('a');
      if(links.length>0) {
        divs1=divs[i].getElementsByTagName('div');
        for(j=0;j<divs1.length;j++){
          if(/fieldgroup-body/.test(divs1[j].className)) {
            groupbody=divs1[j];
          }
        }
        if(groupbody.style.visible != expanded) {
          toggleCollapsiblePanel(links[0], groupbody.id, 'expand', 'collapse');
        }
      }
    }
  }
}

//calls ajax request for storing user layout preferences
function setUserLayoutPreferences(userPrefGroupTypeId, userPrefTypeId, userPrefValue){
  new Ajax.Request('ajaxSetUserPreference',{
    method: "post",
    parameters: {userPrefGroupTypeId: userPrefGroupTypeId, userPrefTypeId: userPrefTypeId, userPrefValue: userPrefValue},
    onLoading: function(transport){
    },

    onSuccess: function(transport){
    },

    onComplete: function(transport){
    }
 });
}

function toggleLeftColumn(){
}

function waitSpinnerShow() {
    document.getElementById("wait-spinner").style.visibility = 'visible';
}

function waitSpinnerHide() {
    document.getElementById("wait-spinner").style.visibility = 'hidden';
}

/* Code for display Calander  
 * need to add class 'dateTimePicker' for field that are of time dateTime. */
jQuery(document).ready(function() { 
    jQuery("input.dateTimePicker").datetimepicker({
        showSecond: true,
        timeFormat: 'hh:mm:ss',
        stepHour: 1,
        stepMinute: 5,
        stepSecond: 10,
        showOn: 'button',
        alwaysSetTime: false,
        buttonImage: '/tomahawk/images/cal.png',
        buttonText: '',
        dateFormat: 'yy-mm-dd'
    }); 
});