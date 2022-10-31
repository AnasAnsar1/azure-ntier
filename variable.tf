variable "rsg_details" {
  type = object({
    name     = string
    location = string
  })
}

variable "subnets_details" {
  type = object ({
    names = list(string)
    address_prefixes = list(string)
  })
}

variable "location" {
  type = string
}

variable "running_number" {
  type = string
}