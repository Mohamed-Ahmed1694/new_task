# new_task
               #     '**  Terraform Task  **'
                      
             '**   This task includes building complete infrastructure and deploy Nginx to EC2.  '** 
        
## Prerequisites
  Linux system
  Terraform
  AWS account ( free tier)
  
  
## Getting Started
  To use this project, you will need to clone the repository to your local machine using the following command:

  ``` git clone https://github.com/Mohamed-Ahmed1694/new_task.git
 
 ## Tools Used:
 Terraform infrastructure as a code to build the infrastructure, Terraform code includes

``` terraform components
(VPC - 1 public subnets - 1 public instance  - internet gateway -security group - route tables - nginx install on the instance ).
after machine created >> ( the instance make install to nginx >> to access from the internet ) >>
``` install nginx on ec2
      "sudo yum update -y ",
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx",
      "sudo chmod 777 /usr/share/nginx/html/index.html",
      "echo ' Hello ITWORX, Its Mohamed here ' > /usr/share/nginx/html/index.html",
      "sudo systemctl enable nginx"


##Then starting by creating infrastructure using terraform

 ``` 
 cd aws 
 ``` 
 terraform init
 ``` 
 terraform plan
 ```
 terrafrom apply
 
 
 ## after creatin the ec2 you take the copy from the public IP that aws give  and paste it to your browser ( remmber to delete http/https) only the link 

                                ##this is the infrastructure design
![Simple-web-ec2 (2)](https://user-images.githubusercontent.com/116628728/223680383-23fab061-25fb-453f-bff7-e52758efe124.png)
