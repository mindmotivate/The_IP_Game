# Provides the CloudFront domain name for accessing the site.
output "cloudfront_url" {
  value = aws_cloudfront_distribution.site_access.domain_name
  description = "CloudFront domain name"
}

# Formats the CloudFront domain name into a clickable URL for easy access
output "cloudfront_url_link" {
  value = format("https://%s", aws_cloudfront_distribution.site_access.domain_name)
  description = "Clickable CloudFront URL"
}

# Provides the custom domain name configured for the CloudFront distribution
output "cloudfront_custom_domain" {
  value       = aws_route53_record.site-domain.fqdn
  description = "Custom domain name"
}

# Formats the custom domain name into a clickable URL for easy access
output "cloudfront_custom_domain_link" {
  value = format("https://%s", aws_route53_record.site-domain.fqdn)
  description = "Clickable CloudFront URL"
}