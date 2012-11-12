
$(document).ready(function() {
    $("#autofill").click(function(e) {
           var partyId =$("#0_lookupId_partyId").val();
           var request ="getPartyContactinfo"
           $.ajax({
           type : "post",
           url : request,
           data : {partyId : partyId},
           success :function(data){
           $("#shipToAddress1").val(data.shipToAddress1);
           $("#shipToAddress2").val(data.shipToAddress2);
           $("#shipToCity").val(data.shipToCity);
           $("#shipToPostalCode").val(data.shipToPostalCode);
           $("#firstName").val(data.firstName);
           $("#lastName").val(data.lastName);
           $("#emailAddress").val(data.emailAddress);
           $("#shipToContactNumber").val(data.contactNumber);
          // $("#shipToContactMechId").val(data.shipToContactMechId);
           $("#shipToContactMechId").val(data.shipToContactMechId);
           $("#phoneContactMechId").val(data.phoneContactMechId);
           $("#emailContactMechId").val(data.emailContactMechId);
           $("#shipToStateProvinceGeoId").val(data.stateProvinceGeoId);
           }
       	});
           });
       });
