package common

import (
	"context"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/appmesh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/require"
)

func TestVirtualGateway(t *testing.T, ctx types.TestContext) {
	appmeshClient := appmesh.NewFromConfig(GetAWSConfig(t))
	meshName := terraform.Output(t, ctx.TerratestTerraformOptions(), "mesh_name")
	gwName := terraform.Output(t, ctx.TerratestTerraformOptions(), "name")

	output, err := appmeshClient.DescribeVirtualGateway(context.TODO(), &appmesh.DescribeVirtualGatewayInput{
		MeshName:           &meshName,
		VirtualGatewayName: &gwName,
	})
	if err != nil {
		t.Errorf("Unable to describe virtual gateway, %v", err)
	}
	virtualGateway := output.VirtualGateway

	t.Run("TestDoesGatewayExist", func(t *testing.T) {
		require.Equal(t, "ACTIVE", string(virtualGateway.Status.Status), "Expected virtual service to be active")
	})

	t.Run("TestDoesGatewayHaveListener", func(t *testing.T) {
		require.NotEmpty(t, virtualGateway.Spec.Listeners, "Expected virtual gateway to have listeners")
	})
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
