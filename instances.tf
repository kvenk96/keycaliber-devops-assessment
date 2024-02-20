resource "aws_instance" "aws_sample" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  user_data = <<-EOF
              curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
              chmod 700 get_helm.sh
              ./get_helm.sh

              helm repo add keycaliber https://charts.keycaliber.com/charts
              helm install my-release keycaliber/my-chart
              EOF

  tags = {
    Name = "SampleInstance"
  }
}
