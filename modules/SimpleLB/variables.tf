locals {
  Subnet = {
    Admin-Machine = aws_subnet.SimpleLB-Subnets["Public-Subnet"].id
    AZ-A-Machine  = aws_subnet.SimpleLB-Subnets["AZ-A"].id
    AZ-B-Machine  = aws_subnet.SimpleLB-Subnets["AZ-B"].id
    AZ-C-Machine  = aws_subnet.SimpleLB-Subnets["AZ-C"].id

  }
  Security_group = {
    Admin-Machine = aws_security_group.AdminNSG.id
    AZ-A-Machine  = aws_security_group.WebNSG.id
    AZ-B-Machine  = aws_security_group.WebNSG.id
    AZ-C-Machine  = aws_security_group.WebNSG.id

  }

}
variable "Subnet" {
  type = map(object({
    name                    = string
    cidr_block              = string
    region                  = string
    map_public_ip_on_launch = bool

  }))
  default = {
    "Public-Subnet" = {
      name                    = "SimpleLB-Public-Subnet"
      cidr_block              = "10.10.1.0/24"
      region                  = "us-east-1a"
      map_public_ip_on_launch = true
    }
    "AZ-A" = {
      name                    = "SimpleLB-AZ-A"
      cidr_block              = "10.10.2.0/24"
      region                  = "us-east-1a"
      map_public_ip_on_launch = true
    }
    "AZ-B" = {
      name                    = "Simple-AZ-B"
      cidr_block              = "10.10.3.0/24"
      region                  = "us-east-1b"
      map_public_ip_on_launch = true
    }
    "AZ-C" = {
      name                    = "Simple-AZ-C"
      cidr_block              = "10.10.4.0/24"
      region                  = "us-east-1c"
      map_public_ip_on_launch = true
    }
  }
}

variable "instances" {
  type = map(object({
    name          = string
    instance_type = string
    ami           = string
    key_name      = string
    command       = string
  }))
  default = {
    "Admin-Machine" = {
      name          = "Admin-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "admin"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update
      EOL
    }
    "AZ-A-Machine" = {
      name          = "AZ-A-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "prod"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update 
      sudo apt install apache2 -y 
      echo $(cat /etc/hostname) | sudo tee /var/www/html/index.html 
      EOL
    }
    "AZ-B-Machine" = {
      name          = "AZ-B-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "prod"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update 
      apt install apache2 -y 
      echo $(cat /etc/hostname) | sudo tee /var/www/html/index.html
      EOL
    }
    "AZ-C-Machine" = {
      name          = "AZ-C-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "prod"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update 
      sudo apt install apache2 -y 
      echo $(cat /etc/hostname) | sudo tee /var/www/html/index.html
      EOL
    }


  }
}

 