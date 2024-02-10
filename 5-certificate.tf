# Retrieves certificate issued for the domain with the status "ISSUED", and selects the most recent one.
data "aws_acm_certificate" "issued" {
  domain = "malgusclan.com"
  statuses = ["ISSUED"]
  most_recent = true
}

# Retrieves the Route 53 hosted zone ID for the domain
data "aws_route53_zone" "selected" {
  name         = "malgusclan.com"
}
# Defines a local value for: "s3_origin_id"
locals {
  s3_origin_id = "s3"
}
