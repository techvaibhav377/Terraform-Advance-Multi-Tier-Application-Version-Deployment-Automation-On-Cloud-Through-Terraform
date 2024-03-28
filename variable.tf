variable "akey" {
  default = "AKIATCKAPTYBEH2MKI4O"
}

variable "skey" {
        default = "9IYxJxBGi58gTuprgdDfH2YZsz9M4+Psh6eGG9c6"
      
}

variable "front_instance_ami" {
  description = "AMI ID for instance1"
  default     = "ami-013168dc3850ef002"
}

variable "front_instance_type" {
  description = "Instance type for instance1"
  default     = "t2.micro"
}

variable "front_instance_subnet" {
description = "this is subnet of first ami instances"
default = "aws_subnet.public.id"  
}

variable "front_instance_count" {
  description = "Number of instances"
  default     = 1
}

variable "front_instance_name" {
  description = "Name for front_instance"
  default     = "FrontEnd-Instance"
}


variable "db_instance_ami" {
  description = "AMI ID for DB Instace"
  default     = "ami-013168dc3850ef002"
}

variable "db_instance_type" {
  description = "Instance type for db_instance"
  default     = "t2.micro"
}

variable "db_instance_subnet" {
description = "this is subnet of DB ami instances"
default = "aws_subnet.private.id"  
}

variable "db_instance_count" {
  description = "Number of instances"
  default     = 1
}

variable "db_instance_name" {
  description = "Name for Database_instance"
  default     = "Database-Instance"
}
variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "vaibhav"
}

variable "pub_key" {
  description = "Public SSH key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxhlAlHPcoP1QzD0lxO114DSiOSq2B0wWDbDogTC0xqcUwniqLUixwC/y5fLEuIbzXdcZHDbHG2xJNww6GNjqvmr5z9Wi/zA9DtuUq32zKWHwrpbK4aarymuQGb7on+JkW0u5E7ovdGm5KWGltIWR4xKp5Ypx7gE0TCSdo9NSnfXmi+urvq9Lxd3mJDUUQmSbr64NVjn9BIMgcY9a7Tnx0wilFPNot/Zcsvg7dvYQDj8V80uGDGEkxVfSKTFQpKNGEm9cttUlo5KtY21T1wCix7mrEIlh4jyM+fxjbpxineijkx3WwlaNeLavvbRAsT0UYiXpOq6OXOs7etTWK/5wZsPI+fq9y9Te90tEfPJEOjLyTWKW3xMNsfY3vagziLd6W+aMi8UNBThwAXg8JmgUFHdeJLSMs+rtfzwI8ddUhVPGglLZdumGGRHCzVbuAVxgpjuhra0YaFanACw/KOhPdmWrvvueH7TneL5hBXREzBDMEfWCqbu9DMzLX/rFv/Lc= vaibh@DESKTOP-0971CIA"
}

variable "front_sg_name" {
  description = "Name of the security group"
  default     = "aws_security_group.front_sg.name"
}

variable "db_sg_name" {
  description = "Name of the security group"
  default     = "aws_security_group.db_sg.name"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}



variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}


variable "public_subnet2_cidr" {
  description = "CIDR Value For Public2 subnet"
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.3.0/24"
}

variable "public_availability_zone" {
  description = "Availability zone for the first public subnet"
  default = "ap-south-1a"
  
}

variable "public_availability_zone2" {
  description = "Availability zone for the secound public subnet"
  default     = "ap-south-1b"  
}


variable "private_availability_zone" {
  default = "ap-south-1b"
}

variable "front_sg_id" {
  default = "[aws_security_group.front_sg_group.id]"
  description = "sg id for launced instance"
  
}

variable "db_sg_id" {
  default = "[aws_security_group.db_sg_group.id]"
  description = "sg id for launced instance"
  
}

variable "public_subnet_id" {
  default = "aws_subnet.public.id"
  description = "subnet id for resurces"
  
}


variable "vpc_id" {
  default = "aws_vpc.my_vpc.id"
  description = "vpc id for resurces"
  
}





