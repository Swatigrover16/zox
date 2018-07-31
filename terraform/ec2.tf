data "template_file" "user_data" {
  template = "${file("userdata.tpl")}"
}

resource "aws_instance" "base" {
  ami = "${var.ami_id}"
  instance_type = "${var.ec2_type}"
  count = "${var.ec2_count}"
  vpc_security_group_ids =  [ "${aws_security_group.ssh.id}" ]
  subnet_id = "${element(aws_subnet.subnet-a.*.id,count.index)}" 
  associate_public_ip_address = true
  key_name = "docker"
  tags {
    Name = "Instance-${count.index + 1}"
  }
  provisioner "file" {
    connection {
      user = "ubuntu"
      host = "${aws_instance.base.public_ip}"
      agent = false
      private_key = "${file("/Users/swatigrover/Downloads/docker.pem")}"
    }
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
    connection {
      user = "ubuntu"
      host = "${aws_instance.base.public_ip}"
      agent = false
      private_key = "${file("/Users/swatigrover/Downloads/docker.pem")}"
    }
  }
}
