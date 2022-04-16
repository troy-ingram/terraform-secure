#Create database
resource "aws_db_instance" "default" {
  allocated_storage      = var.rds_instance.allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = var.rds_instance.engine
  engine_version         = var.rds_instance.engine_version
  instance_class         = var.rds_instance.instance_class
  multi_az               = var.rds_instance.multi_az
  name                   = var.rds_instance.name
  username               = var.user_information.username
  password               = var.user_information.password
  skip_final_snapshot    = var.rds_instance.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.database-subnet[0].id, aws_subnet.database-subnet[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}