provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

#Create a vpc
resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
  tags {
    Name = "${var.vpc_name}"
  }
}

#Create internet-gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc_name}-igw"
  }
}

#Create routing-table
resource "aws_route_table" "route-table" {
  vpc_id = "${aws_vpc.vpc.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "${var.vpc_name}-rt"
  }
}

#create subnets (atleast two for high availability)
resource "aws_subnet" "subnet-a" {
  vpc_id = "${aws_vpc.vpc.id}"
  count = "${length(var.zones)}"
  availability_zone = "us-east-1${element(var.zones, count.index)}"
  cidr_block = "10.0.${count.index + 1}.0/24"
}

#route table association
resource "aws_route_table_association" "route_table_assc" {
  count = "${length(var.zones)}"
  subnet_id     = "${element(aws_subnet.subnet-a.*.id,count.index)}"
  route_table_id = "${aws_route_table.route-table.id}"
}


