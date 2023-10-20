package test

import (
	"context"
	"fmt"
	"os"
	"strconv"
	"testing"
	"reflect"
	// "time"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/appmesh"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)


var standardTags = map[string]string{
	"provisioner": "Terraform",
}

const (
	base            = "../../examples/"
	testVarFileName = "/test.tfvars"
	caModule        = "module.private_ca"
)

func TestAppMeshVirtualGateway(t *testing.T) {
	t.Parallel()
	stage := test_structure.RunTestStage

	files, err := os.ReadDir(base)
	if err != nil {
		assert.Error(t, err)
	}
	for _, file := range files {
		dir := base + file.Name()
		if file.IsDir() {
			defer stage(t, "teardown_appmesh_virtualgateway", func() { tearDownAppMeshVirtualGateway(t, dir) })
			stage(t, "setup_and_test_appmesh_virtualgateway", func() { setupAndTestAppMeshVirtualGateway(t, dir) })
		}
	}
}

func setupAndTestAppMeshVirtualGateway(t *testing.T, dir string) {
	varsFilePath := []string{dir + testVarFileName}

	terraformOptionsCA := &terraform.Options{
		TerraformDir: dir,
		Targets:      []string{caModule},
		VarFiles:     varsFilePath,
		// Logger:       logger.Discard,

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}
	terraformOptionsCA.VarFiles = varsFilePath

	terraformOptions := &terraform.Options{
		TerraformDir: dir,
		VarFiles:     []string{dir + testVarFileName},
		NoColor:      true,
		// Logger:       logger.Discard,
	}

	test_structure.SaveTerraformOptions(t, dir, terraformOptions)

	terraform.InitAndApply(t, terraformOptionsCA)
	// sleep for 1 minutes for the CA status change to ISSUED
	// time.Sleep(1 * time.Minute)
	terraform.InitAndApply(t, terraformOptions)

	expectedPatternARN := "^arn:aws:appmesh:[a-z]{2}-[a-z]+-[0-9]{1}:[0-9]{12}:mesh/[a-zA-Z0-9-]+/virtualGateway/[a-zA-Z0-9-]+$"

	actualVirtualGatewayId := terraform.Output(t, terraformOptions, "id")
	assert.NotEmpty(t, actualVirtualGatewayId, "Virtual Gateway Id is empty")
	actualVgwARN := terraform.Output(t, terraformOptions, "arn")
	assert.Regexp(t, expectedPatternARN, actualVgwARN, "ARN does not match expected pattern")
	actualRandomId := terraform.Output(t, terraformOptions, "random_int")
	assert.NotEmpty(t, actualRandomId, "Random ID is empty")

	expectedNamePrefix := terraform.GetVariableAsStringFromVarFile(t, dir+testVarFileName, "naming_prefix")
	expectedMeshName := expectedNamePrefix + "-app-mesh-" + actualRandomId
	expectedVirtualGatewayName := expectedNamePrefix + "-vgw-" + actualRandomId

	cfg, err := config.LoadDefaultConfig(
		context.TODO(),
		config.WithSharedConfigProfile(os.Getenv("AWS_PROFILE")),
	)
	if err != nil {
		assert.Error(t, err, "can't connect to aws")
	}

	client := appmesh.NewFromConfig(cfg)
	input := &appmesh.DescribeVirtualGatewayInput{
		VirtualGatewayName: aws.String(expectedVirtualGatewayName),
		MeshName:           aws.String(expectedMeshName),
	}
	result, err := client.DescribeVirtualGateway(context.TODO(), input)
	if err != nil {
		assert.Fail(t, fmt.Sprintf("The Expected Virtual Gateway was not found %s", err.Error()))

	}
	virtualGateway := result.VirtualGateway
	expectedId := *virtualGateway.Metadata.Uid

	expectedArn := *virtualGateway.Metadata.Arn
	assert.Regexp(t, expectedPatternARN, actualVgwARN, "VGW ARN does not match expected pattern")
	assert.Equal(t, expectedArn, actualVgwARN, "VGW ARN does not match")
	assert.Equal(t, expectedId, actualVirtualGatewayId, "vgw id does not match")

	ActualVgwListeners := virtualGateway.Spec.Listeners
	ActualTLSEnforce := strconv.FormatBool(*virtualGateway.Spec.BackendDefaults.ClientPolicy.Tls.Enforce)

	for _, listener := range ActualVgwListeners {
		ActualVgwTlsMode := listener.Tls.Mode
		ActualVgwPort := fmt.Sprintf("%d", listener.PortMapping.Port)
		expectedTlsPort, err := terraform.GetVariableAsStringFromVarFileE(t, dir+testVarFileName, "listener_port")
		if err == nil {
			assert.Equal(t, string(expectedTlsPort), ActualVgwPort, "Vgw TLS Port does not match")
		}
		expectedTlsMode, err := terraform.GetVariableAsStringFromVarFileE(t, dir+testVarFileName, "tls_mode")
		if err == nil {
			assert.Equal(t, expectedTlsMode, string(ActualVgwTlsMode), "Vgw TLS Mode does not match")
		}

		expectedTlsEnforce, err := terraform.GetVariableAsStringFromVarFileE(t, dir+testVarFileName, "tls_enforce")
		if err == nil {
			assert.Equal(t, expectedTlsEnforce, string(ActualTLSEnforce), "Vgw TLS Enforce does not match")
		}

	}

	checkTagsMatch(t, dir, actualVgwARN, client)

}

func checkTagsMatch(t *testing.T, dir string, actualARN string, client *appmesh.Client) {
	expectedTags, err := terraform.GetVariableAsMapFromVarFileE(t, dir+testVarFileName, "tags")
	if err == nil {
		result2, errListTags := client.ListTagsForResource(context.TODO(), &appmesh.ListTagsForResourceInput{ResourceArn: aws.String(actualARN)})
		if errListTags != nil {
			assert.Error(t, errListTags, "Failed to retrieve tags from AWS")
		}
		// convert AWS Tag[] to map so we can compare
		actualTags := map[string]string{}
		for _, tag := range result2.Tags {
			actualTags[*tag.Key] = *tag.Value
		}

		// add the standard tags to the expected tags
		for k, v := range standardTags {
			expectedTags[k] = v
		}
		expectedTags["env"] = actualTags["env"]
		assert.True(t, reflect.DeepEqual(actualTags, expectedTags), fmt.Sprintf("tags did not match, expected: %v\nactual: %v", expectedTags, actualTags))
	}
}


func tearDownAppMeshVirtualGateway(t *testing.T, dir string) {
	terraformOptions := test_structure.LoadTerraformOptions(t, dir)
	terraformOptions.Logger = logger.Discard
	terraform.Destroy(t, terraformOptions)

}
