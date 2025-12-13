package test

import (
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformCode01(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(
		t,
		&terraform.Options{
			TerraformDir: "../infra/dev",
			NoColor:      true,

			BackendConfig: map[string]interface{}{
				"resource_group_name": "ankurbackend01",
    			"storage_account_name": "ankur01storage01ad01",
    			"container_name": "ankurstorage01container01",
    			"key": "Project03-Test.terraform.tfstate",
			},
			Reconfigure: true,

			RetryableTerraformErrors: map[string]string{
				".*SkuNotAvailable.*":         "Retrying SKU availability",
				".*NicReservedForAnotherVm.*": "Retrying NIC detach delay",
				".*context deadline exceeded.*": "Retrying timeout",
				".*Error waiting for.*":       "Retrying Azure async operation",
			},

			MaxRetries:         3,
			TimeBetweenRetries: 20 * time.Second,
		},
	)

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// ---------- Subnet ID Assertions ----------
	t.Run("Subnet IDs", func(t *testing.T) {
		subnetIDs := terraform.OutputMap(t, terraformOptions, "out_root_subnet_ids")

		assert.Contains(t, subnetIDs["subnet1"], "eagle-subnet1-frontend")
		assert.Contains(t, subnetIDs["subnet2"], "eagle-subnet2-backend")
	})

	// ---------- Subnet → VNet Mapping ----------
	t.Run("Subnet to VNet mapping", func(t *testing.T) {
		subnetVnetMap := terraform.OutputMap(t, terraformOptions, "out_root_subnet_vnet_map")

		assert.Equal(t, "eagle-vnet1", subnetVnetMap["eagle-subnet1-frontend"])
		assert.Equal(t, "eagle-vnet1", subnetVnetMap["eagle-subnet2-backend"])
	})

	// ---------- NSG Name Assertions ----------
	t.Run("NSG names", func(t *testing.T) {
		nsgNames := terraform.OutputMap(t, terraformOptions, "out_root_nsg_names")

		assert.Equal(t, "eagle-nsg1-frontend", nsgNames["nsg1"])
		assert.Equal(t, "eagle-nsg2-backend", nsgNames["nsg2"])
	})

	// ---------- NSG ID Assertions ----------
	t.Run("NSG IDs", func(t *testing.T) {
		nsgIDs := terraform.OutputMap(t, terraformOptions, "out_root_nsg_ids")

		assert.Contains(t, nsgIDs["nsg1"], "eagle-nsg1-frontend")
		assert.Contains(t, nsgIDs["nsg2"], "eagle-nsg2-backend")
	})

	// ---------- NSG Name → ID Mapping ----------
	t.Run("NSG name to ID mapping", func(t *testing.T) {
		nsgNameIDs := terraform.OutputMap(t, terraformOptions, "out_root_nsg_name_ids")

		assert.Contains(t, nsgNameIDs["eagle-nsg1-frontend"], "networkSecurityGroups")
		assert.Contains(t, nsgNameIDs["eagle-nsg2-backend"], "networkSecurityGroups")
	})

	// ---------- NSG Key → Name + ID Composite ----------
	t.Run("NSG key-name-id structure", func(t *testing.T) {
		nsgComposite := terraform.OutputMapOfObjects(
			t,
			terraformOptions,
			"out_root_nsg_key_name_id",
		)

		// ---- NSG1 ----
		nsg1 := nsgComposite["nsg1"].(map[string]interface{})
		assert.Equal(t, "eagle-nsg1-frontend", nsg1["nsg_name"])
		assert.Contains(t, nsg1["nsg_id"], "eagle-nsg1-frontend")

		// ---- NSG2 ----
		nsg2 := nsgComposite["nsg2"].(map[string]interface{})
		assert.Equal(t, "eagle-nsg2-backend", nsg2["nsg_name"])
		assert.Contains(t, nsg2["nsg_id"], "eagle-nsg2-backend")
	})

}
