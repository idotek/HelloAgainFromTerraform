resource "aws_instance" "SimpleLB-Instance" {
  depends_on             = [aws_key_pair.gen_admin_public_key, aws_key_pair.gen_prod_servers_public_key]
  for_each               = var.instances
  instance_type          = each.value.instance_type
  ami                    = each.value.ami
  key_name               = each.value.key_name
  subnet_id              = local.Subnet[each.value.name]
  vpc_security_group_ids = [local.Security_group[each.value.name]]
  user_data = each.value.command
  tags = {
    Name = each.value.name
  }
}



