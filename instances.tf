locals {
  subnets = "${aws_subnet.terraform-blue-green.*.id}"

  user_data = <<EOF
    #cloud-config
    runcmd:
    - docker run -d -p 80:80 nginx:latest
  EOF
}

resource "aws_instance" "terraform-blue-green" {
  count                  = 1 //3
  ami                    = "ami-03f14363e371d3d61"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.terraform-blue-green.id}"]
  key_name               = "${aws_key_pair.terraform-blue-green.key_name}"

  subnet_id              = "${element(local.subnets, count.index)}"
                        
  user_data = "${local.user_data}"

  tags = {
    Name                  = "Terraform Blue/Green ${count.index + 1} (v${var.infrastructure_version})"
    InfrastructureVersion = "${var.infrastructure_version}"
  }
}

output "instance_public_ips" {
  value = "${aws_instance.terraform-blue-green.*.public_ip}"
}