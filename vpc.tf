# #------------------VPC-------------------------------------------

# resource "aws_vpc" "simple-web-app" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "simple-web-app"
#   }
# }

# #------------------Subnets---------------------------------------------------------

# resource "aws_subnet" "public_subnet" {
#   vpc_id = aws_vpc.simple-web-app.id

#   cidr_block = "10.0.1.0/24"

#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "webserver-subnet"
#   }

#   route_table_id = aws_route_table.public.id
# }
# #------------------Security_group---------------------------------------------------------

# resource "aws_security_group" "web_app_security_group" {
#   name_prefix = "web-app-sg"
#   description = "Allow HTTP traffic from anywhere"

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# #------------------EC2---------------------------------------------------------

# resource "aws_instance" "web_app_instance" {
#   ami           = "ami-0a91cd140a1fc148a"
#   instance_type = "t3a.micro"
#   key_name      = "my-key-pair"
#   subnet_id     = aws_subnet.public_subnet.id
#   vpc_security_group_ids = [aws_security_group.web_app_security_group.id]

#   tags = {
#     Name = "Webserver"
#   }

#   # Associate an Elastic IP address with the instance
#   associate_public_ip_address = true
# }

# #------------------IGW---------------------------------------------------------

# resource "aws_internet_gateway" "web-IGW" {
#   vpc_id = aws_vpc.simple-web-app.id
# }

# #------------------Route_table---------------------------------------------------------

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.simple-web-app.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.web-IGW.id
#   }
# }
