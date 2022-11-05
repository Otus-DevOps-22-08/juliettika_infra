terraform {

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "juliettika-tf-state"
    region     = "ru-central1"
    key        = "prod/terraform.tfstate"
    access_key = "111"
    secret_key = "111"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
