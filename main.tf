module "vpc" {
    source = "./vpc"
}

module "cloudwatch" {
    source = "./cloudwatch"
}