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
 
  ami                     =  "ami-0742b4e673072066f"
  instance_type           =  "t2.micro"
  iam_instance_profile    =  "${aws_iam_instance_profile.test_profile.name}"
  key_name                = "${aws_key_pair.ec2-key.id}"
  security_groups         =  [aws_security_group.wp_efs_sg.name]
  #user_data              =  "${file("bootstrap1.sh")}"
 
  tags = {
    Name   = "RDS_WP" 
  }
}

/*
## Create EFS
resource "aws_efs_file_system" "wp_efs" {
   creation_token = "wp_efs"
   
   tags = {
     Name = "wp_efs"
   }
 }

##Create Mount Target EFS
resource "aws_efs_mount_target" "wp_efs_mount" {
   file_system_id  = "${aws_efs_file_system.wp_efs.id}"
   subnet_id = aws_instance.my-rds-wp[0].subnet_id
   security_groups = ["${aws_security_group.wp_efs_sg.id}"]
 }

 # Creating Mount Point for EFS
resource "null_resource" "EC2_mount" {
depends_on = [aws_efs_mount_target.wp_efs_mount]
connection {
type     = "ssh"
user     = "ec2-user"
#key_name                =  "MyEC2Keypair"
#private_key = tls_private_key.MyEC2Keypair.private_key_pem
host     = aws_instance.my-rds-wp[0].public_ip
 }

provisioner "remote-exec" {
inline = [

# Mounting Efs 
"sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.wp_efs.dns_name}:/  /var/www/html",
  ]
 }
}
*/