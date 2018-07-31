variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "vpc_name" {
  type = "string"
  default = ""
}
variable "zones" {
  type = "list"
  default = []
}
variable "ami_id" {
  type ="string"
  default = "ami-759bc50a"
}
variable "ec2_type" {
  type = "string"
  default = "t2.micro"
}
variable "ec2_count" {
  type = "string"
  default = "1"
}
variable "cidr_block" {
  type = "string"
  default = "10.0.0.0/16"
}
variable "region" {
  type = "string"
  default = "us-east-1"
}
