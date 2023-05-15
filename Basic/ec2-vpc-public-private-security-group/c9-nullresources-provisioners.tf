# Create a null resources and provisioners

resource "null_resource" "name" {
  depends_on = [ module.ec2_public ]


  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = aws_eip.bastion_eip.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }

  # File provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source = "private-key/terraform-key.pem"
    destination="/tmp/terraform-key.pem"
  }
  
  ## Remote Exac Provisioner: Using remote-exac provisioner fix the private key permission 
  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod 400 /tmp/terraform-key.pem"
     ]
  }

  ##Local Exec Provisioner: local-exec provisioner
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc_id.txt" 
    working_dir = "local-exec-output-files/"
    
    #not important- can continue terraform apply if fail
    on_failure = continue
  }


  /* provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt" 
    working_dir = "local-exec-output-files/"
    #Creation time provisioners - By default they are -Trigger during apply
    #Destroy time provisioners - Will be executed during Terraform Destroy
    when = destroy
    on_failure = continue
    }
  */ 
  


}