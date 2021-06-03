import { LightningElement } from "lwc";
import OOE_RING from "@salesforce/contentAssetUrl/OOE_SUM21";

export default class HomePage extends LightningElement {
	// Expose the asset file URL for use in the template
	ooeRing = OOE_RING;
}
