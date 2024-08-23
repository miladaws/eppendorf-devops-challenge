variable "topic_name" {
  description = "The name of the SNS topic."
  type        = string
}

variable "protocol" {
  description = "The protocol to use for the subscription (e.g., email, sms)."
  type        = string
}

variable "endpoint" {
  description = "The endpoint for the subscription (e.g., email address)."
  type        = string
}
