variable "base_name" {
  type    = string
  default = "c3"
}

variable "common_tags" {
  description = "Common tags to attach to every object"

  default = {
    Project = "tf-c3-infra"
  }
}
