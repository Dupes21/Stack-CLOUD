variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}


variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "MyEC2Keypair"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "MyEC2Keypair.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0742b4e673072066f"
    #us-east-1 = "ami-08f3d892de259504d"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

# variable "RDS_PASSWORD" {
# }

#variable "INSTANCE_USERNAME" {
#}

variable "RDS_DB_NAME" {}

variable "RDS_DB_USER" {}

variable "RDS_DB_PASSWORD"{}

variable "RDS_ENDPOINT" {}

variable "AMI" {
  
}

variable "INSTANCE_TYPE" {
  
}
variable "DB_HOSTNAME" {} 
variable "WP_URL" {}
variable "DB_USER" {}
variable "DB_PWD" {}
variable "DB_NAME" {}