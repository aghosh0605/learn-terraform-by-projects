#Outputs the Elastic IP that was assigned to the specified EC2 instance
output "public_ip" {
  value = aws_eip.web_server_eip.public_ip
  description = "The elastic IP that was assigned to the specified EC2 instance"
}