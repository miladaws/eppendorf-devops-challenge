variable "alarm_name" {
  description = "The name of the CloudWatch alarm."
  type        = string
}

variable "metric_name" {
  description = "The name of the metric to monitor. For 5xx errors."
  type        = string
}

variable "namespace" {
  description = "The namespace of the CloudWatch metric."
  type        = string
}

variable "threshold" {
  description = "The threshold for triggering the alarm. Set to 10 for more than 10 errors."
  type        = number
}

variable "evaluation_periods" {
  description = "Number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 1
}

variable "api_name" {
  description = "The name of the API Gateway."
  type        = string
}

variable "stage_name" {
  description = "The environment stage name (e.g., dev, prod)."
  type        = string
}

variable "alarm_actions" {
  description = "List of ARNs for actions to execute when the alarm is triggered."
  type        = list(string)
}