resource "aws_instance" "MyFirstInstance" {
    ami = "ami-0d8a1d765eb5dfc39"
    instance_type = "t2.micro"    
}