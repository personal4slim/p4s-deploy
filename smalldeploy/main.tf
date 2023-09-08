terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "p4s-tf-resource"
    storage_account_name  = "p4stfstorage"
    container_name        = "p4s-tffiles"
    key                   = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  client_id       = "62ba6d2f-4192-4cf5-a00d-42328f7d7dfd"
  client_secret   = "nJP8Q~_EqLNHRP2WxOe.b1HjVrKytOXVprvW1ca9"
  tenant_id       = "104e77d4-81e7-4c16-ab44-935220bed6dd"
  subscription_id = "606e824b-aaf7-4b4e-9057-b459f6a4436d"
}

provider "azuread" {}

provider "random" {}

resource "random_pet" "p4s_aksrandom" {
  length = 2
}
