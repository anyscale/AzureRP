import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Anyscale.Platform;

@resource("clouds")
model Cloud is TrackedResource<CloudProperties> {
  @pattern("^[a-zA-Z0-9]*$")
  @key("cloudName")
  @path
  @segment("clouds")
  name: string;
}

model CloudProperties {
  @visibility(Lifecycle.Read)
  ssoUrl?: string;

  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Provisioning state enum */
union ProvisioningState {
  string,
  ResourceProvisioningState,
}

@armResourceOperations
interface Clouds {
  get is ArmResourceRead<Cloud>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cloud>;
  update is ArmCustomPatchSync<
    Cloud,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Cloud,
      CloudProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Cloud>;
  listByResourceGroup is ArmResourceListByParent<Cloud>;
  listBySubscription is ArmListBySubscription<Cloud>;
}
