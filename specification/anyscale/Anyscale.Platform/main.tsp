import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./cloud.tsp";
import "./cloudResource.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Anyscale.Platform Resource Provider management API. */
@armProviderNamespace
@service(#{
  title: "Anyscale.Platform management service",
})
@versioned(Versions)
namespace Anyscale.Platform;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_04_01_preview: "2023-04-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
