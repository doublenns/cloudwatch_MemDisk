##########################
# AWS Provider Variables #
##########################

# Can hardcode access/secret keys or can leave it black to have Terraform
# prompt for the values upon plan/apply
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}

# Usually:
# curl -s ipinfo.io | grep ip | cut -f2 -d: | tr -d \"," "
current_public_ip {}
