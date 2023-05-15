# AWS EC2 Instance Terraform Outputs
## EC2 Bastion Public ids
output "ec2_bastion_public_ids" {
  description = "The ID of the bastion instance"
  value       = module.ec2_public.id
}
## ec2_bastion_public_ip
output "ec2_public_ip" {
  description = "List of public IP names assigned to the instances"
  value       = module.ec2_public.public_ip
}

# Private EC2 Instance
## ec2_private_instance_ids
output "ec2_private_ids" {
  description = "The ID of the private instance"
  value       = module.ec2_private.id
}
## ec2_private_ip
output "ec2_private_ip" {
  description = "List of public IP names assigned to the instances"
  value       = module.ec2_private.private_ip
}
