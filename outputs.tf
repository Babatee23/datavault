output "public_ip" {
  value = aws_instance.k3s_server.public_ip
}

output "ecr_url" {
  value = aws_ecr_repository.app_repo.repository_url
}