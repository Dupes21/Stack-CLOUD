/*
# Default VPC
resource "aws_default_vpc" "default" {
tags = {
Name = "Default VPC"
  }
}
*/

/*
#WordPress EC2 instance
resource "aws_instance" "my-rds-wp" {

# ami                     =  "ami-0742b4e673072066f"
  ami                     =  var.AMI
  #instance_type           =  "t2.micro"
  instance_type           =  var.INSTANCE_TYPE
  iam_instance_profile    =  "${aws_iam_instance_profile.test_profile.name}"
  key_name                =  "${aws_key_pair.ec2-key.id}"
  security_groups         =  [aws_security_group.wp_efs_sg.name]
  #user_data               =  "${file("bootstrap1.sh")}"
  #file_system_id         =  [aws_efs_file_system.wp_efs.id]
  user_data               = templatefile("bootstrap3.sh",{
                                  DB_USER      = var.DB_USER,
                                  DB_PWD       = var.DB_PWD,
                                  RDS_ENDPOINT = var.RDS_ENDPOINT,
                                  DB_NAME      = var.DB_NAME,
                                  WP_URL       = var.WP_URL
    })
 
      
    tags = {
    Name   = "RDS_WP" 
  
  }
}
*/
#Restoring Clixxdb snapshot

resource "aws_db_instance" "prod" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "wordpressdb"
  username             = "wordpressuser"
  password             = "W3lcome123"
  #db_subnet_group_name = "my_database_subnet_group"
  #parameter_group_name = "default.mysql5.6"
}

data "aws_db_snapshot" "wordpressdbclixx" {
  db_instance_identifier = aws_db_instance.prod.id
  most_recent            = true
}

# Use the latest production snapshot to create a dev instance.
resource "aws_db_instance" "dev" {
  instance_class      = "db.t2.micro"
  name                = "mydbdev"
  snapshot_identifier = data.aws_db_snapshot.wordpressdbclixx.id

  #lifecycle {
   # ignore_changes = [snapshot_identifier]
  #}
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