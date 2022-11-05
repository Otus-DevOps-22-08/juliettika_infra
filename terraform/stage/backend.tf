terraform {

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "juliettika-tf-state"
    region     = "ru-central1"
    key        = "stage/terraform.tfstate"
    access_key = "YCAJEAN5WDCTnRECO3tt5PKY-"
    secret_key = "YCN3I8zos-wxjihowETUhwL7fGwYjTMCKNqCiZT-"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
