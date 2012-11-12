import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.party.contact.ContactHelper;

if (party) {
    address = EntityUtil.getFirst(ContactHelper.getContactMech(party, "SHIPPING_LOCATION", "POSTAL_ADDRESS", false));
    if (address) {
        toPostalAddress = address.getRelatedOne("PostalAddress");
        context.toPostalAddress = toPostalAddress;
    }
}
