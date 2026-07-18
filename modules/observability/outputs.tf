output "observability_appinsights_instrumentation_key" {
  value       = azurerm_application_insights.observability_appinsights.instrumentation_key
  description = "Instrumentation Key for Application Insights observability."
}
output "observability_function_default_hostname" {
  value       = azurerm_function_app_flex_consumption.observability_function.default_hostname
  description = "Default hostname for the observability function app."
}