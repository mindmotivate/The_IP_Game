# Creates "A" record in route 53
resource "aws_route53_record" "site-domain" {
  zone_id = data.aws_route53_zone.selected.id
  name = "malgusclan.com"
  type = "A"

  alias {
    name   = aws_cloudfront_distribution.site_access.domain_name
    zone_id = aws_cloudfront_distribution.site_access.hosted_zone_id
    evaluate_target_health = true
  }

  # Ensures that the new Route 53 record is fully created and operational before the old record is removed
  lifecycle {
    create_before_destroy = true
  }
}



