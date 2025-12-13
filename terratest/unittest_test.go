package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	// "github.com/stretchr/testify/assert"
)

func TestTerraformCode01(t *testing.T) {
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../infra/dev",
	})

	// defer terraform.Destroy(t, terraformOptions)

	defer terraform.Destroy(t,
    terraform.WithDefaultRetryableErrors(t, terraformOptions),
	)
	
	terraform.InitAndApply(t, terraformOptions)

	// output := terraform.Output(t, terraformOptions, "hello_world")
	// assert.Equal(t, "Hello, World!", output)
}