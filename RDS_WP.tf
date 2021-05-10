/*
# Default VPC
resource "aws_default_vpc" "default" {
tags = {
Name = "Default VPC"
  }
}
*/


#WordPress EC2 instance
resource "aws_instance" "my-rds-wp" {

 # ami                     =  "ami-0742b4e673072066f"
  ami                     =  var.AMI
  #instance_type           =  "t2.micro"
  instance_type           =  var.INSTANCE_TYPE
  iam_instance_profile    =  "${aws_iam_instance_profile.test_profile.name}"
  key_name                =  "${aws_key_pair.ec2-key.id}"
  security_groups         =  [aws_security_group.wp_efs_sg.name]
  user_data               =  templatefile("bootstrap1.sh", {
                                  DB_HOSTNAME=var.DB_HOSTNAME
                                  WP_URL=var.WP_URL
                                  DB_USER=var.DB_USER
                                  DB_PWD=var.DB_PWD
                                  DB_NAME=var.DB_NAME
      })
      
  #file_system_id         =  [aws_efs_file_system.wp_efs.id]

  tags = {
    Name   = "RDS_WP" 
  }
}

#Store state file in S3 bucket
terraform {
    backend "s3"{
        bucket= "stackbuckstatedupe"
        key= "terraform.tfstate"
        region= "us-east-1"
        dynamodb_table= "statelock-tf"
    }
}