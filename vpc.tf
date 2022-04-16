# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Demo VPC"
  }
}

# Create Web Public Subnet
resource "aws_subnet" "web-subnet" {
  count                   = var.item_count
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.web_subnet_cidr[count.index]
  availability_zone       = var.availability_zone_names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Web-${count.index}"
  }
}

# Create Application Public Subnet
resource "aws_subnet" "application-subnet" {
  count                   = var.item_count
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.application_subnet_cidr[count.index]
  availability_zone       = var.availability_zone_names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "Application-${count.index}"
  }
}

# Create Database Private Subnet
resource "aws_subnet" "database-subnet" {
  count             = var.item_count
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = var.availability_zone_names[count.index]

  tags = {
    Name = "Database-${count.index}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "Demo IGW"
  }
}