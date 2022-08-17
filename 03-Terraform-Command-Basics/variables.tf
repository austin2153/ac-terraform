variable "name" {
  default = "austinapp"
}

variable "region" {
  default = "eastus"
}

variable "tags" {
  default = {
    application = "austin-app"
  }
}

variable "port" {
  default = {
    "dev" = 8080
    "qa" = 7000
    "prod" = 9000
  }
}