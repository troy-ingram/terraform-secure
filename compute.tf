#Create EC2 Instance
resource "aws_instance" "webserver" {
  count                  = var.item_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone_names[count.index]
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.web-subnet[count.index].id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "Web Server${count.index}"
  }

}