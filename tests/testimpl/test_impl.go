package testimpl

import (
	"context"
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/network/armnetwork/v2"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

var (
	computeClient *armcompute.VirtualMachinesClient
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")

	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		log.Fatal(err)
	}

	computeClient, err = armcompute.NewVirtualMachinesClient(subscriptionId, cred, nil)
	if err != nil {
		log.Fatal(err)
	}

	nicClient, err := armnetwork.NewInterfacesClient(subscriptionId, cred, nil)
	if err != nil {
		fmt.Println(err)
	}

	vmId := terraform.Output(t, ctx.TerratestTerraformOptions(), "id")
	vmName := terraform.Output(t, ctx.TerratestTerraformOptions(), "name")
	rgName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")

	t.Run("TestAlwaysSucceeds", func(t *testing.T) {
		assert.Equal(t, "foo", "foo", "Should always be the same!")
		assert.NotEqual(t, "foo", "bar", "Should never be the same!")
	})

	t.Run("VirtualMachineHasIPAddress", func(t *testing.T) {
		vm_ctx := context.Background()
		vm, err := computeClient.Get(vm_ctx, rgName, vmName, nil)
		if err != nil {
			t.Error(err)
		}

		fmt.Printf("Returned VM ID: %s", *vm.ID)
		fmt.Printf("Returned VM Name: %s", *vm.Name)

		assert.Equal(t, vmId, *vm.ID, "Unexpected Virtual Machine ID!")
		assert.Equal(t, vmName, *vm.Name, "Unexpected Virtual Machine Name!")

		for _, nicRef := range vm.Properties.NetworkProfile.NetworkInterfaces {
			nicID, _ := arm.ParseResourceID(*nicRef.ID)
			nic, _ := nicClient.Get(context.Background(), nicID.ResourceGroupName, nicID.Name, nil)
			for _, ipCfg := range nic.Properties.IPConfigurations {
				assert.NotNil(t, ipCfg.Properties.PrivateIPAddress, "Private IP address must exist!")
			}
		}
	})
}
