# EC2 instance Terrform Mofule
# EC2 that will be create in VPC Private Subnets


module "ec2_private" {
  depends_on = [ module.vpc ]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  # insert the 10 required variales here
  name = "${var.environment}-vm"

  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  
  vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]
  
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]  
  #subnet_id = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  instance_count = var.private_instance_count
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags

}
