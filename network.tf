#------------------VPC-------------------------------------------

resource "aws_vpc" "simple-web-app" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "simple-web-app"
  }
}

#------------------Subnets---------------------------------------------------------

resource "aws_subnet" "webserver-subnet" {
  vpc_id = aws_vpc.simple-web-app.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "webserver-subnet"
  }
}

#------------------Security_group---------------------------------------------------------

resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  vpc_id      = aws_vpc.simple-web-app.id
  description = "Allow HTTP traffic from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "Webserver-EIP" {
  vpc      = true
  instance = aws_instance.Webserver.id
}



#------------------EC2---------------------------------------------------------

resource "aws_instance" "Webserver" {
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t3a.micro"
  key_name               = "ITWORX"
  subnet_id              = aws_subnet.webserver-subnet.id
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]

  tags = {
    Name = "Webserver"
  }
  availability_zone = "us-east-1a"

  # Associate an Elastic IP address with the instance
  associate_public_ip_address = true


  connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/mohamed/ITWIRKS_TASK/aws/ITWORX.pem")
      host        = aws_instance.Webserver.public_ip
    }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y ",
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx",
      "sudo chmod 777 /usr/share/nginx/html/index.html",
      "echo ' Hello ITWORX, Its Mohamed here ' > /usr/share/nginx/html/index.html",
      "sudo systemctl enable nginx"
    ]
  
  }
}

#------------------IGW---------------------------------------------------------

resource "aws_internet_gateway" "web-IGW" {
  vpc_id = aws_vpc.simple-web-app.id
}

#------------------Route_table---------------------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.simple-web-app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web-IGW.id
  }
}

#------------------Subnet Association---------------------------------------------------------

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.webserver-subnet.id
  route_table_id = aws_route_table.public.id
}
