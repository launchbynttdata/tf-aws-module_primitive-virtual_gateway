package test

import (
	"testing"

	"github.com/launchbynttdata/lcaf-component-terratest/lib"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	testimpl "github.com/launchbynttdata/tf-aws-module_primitive-virtual_gateway/tests/testimpl"
)

const (
	testConfigsExamplesFolderDefault = "../../examples"
	infraTFVarFileNameDefault        = "test.tfvars"
)

// TestVirtualGatewayModuleReadOnly validates deployed infrastructure without
// creating, mutating, or destroying Terraform-managed resources.
func TestVirtualGatewayModuleReadOnly(t *testing.T) {
	ctx := types.CreateTestContextBuilder().
		SetTestConfig(&testimpl.ThisTFModuleConfig{}).
		SetTestConfigFolderName(testConfigsExamplesFolderDefault).
		SetTestConfigFileName(infraTFVarFileNameDefault).
		Build()

	lib.RunNonDestructiveTest(t, *ctx, testimpl.TestComposableVirtualGatewayReadOnly)
}
