###############################################################################
# EC2 - Elastic Compute Cloud
###############################################################################

# https://www.terraform.io/docs/providers/template/index.html

#resource "template_file" "concourse" {
  
  #template = file("concourse.sh")
  
#}

# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "aws_instance" "concourse" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.concourse-sg.id]

  #user_data = template_file.concourse.rendered
  #user_data = templatefile("concourse.sh", {})

  tags = {
    Name        = "Concourse"
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Concourse"
  }

}