plugin "azurerm" {
    enabled = true
    version = "0.27.0"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# General Terraform rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}
 
# Disallow variables, data sources, and locals that are declared but never used.
rule "terraform_unused_declarations" {
  enabled = true
}
 
# Disallow // comments in favor of #.
rule "terraform_comment_syntax" {
  enabled = true
}