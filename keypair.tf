# Generate a TLS private key
resource "tls_private_key" "deployer" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.deployer.public_key_openssh
}

# Save the private key locally for SSH access
resource "local_file" "deployer_private_key" {
  content  = tls_private_key.deployer.private_key_pem
  filename = "${path.module}/deployer-key.pem"

  provisioner "local-exec" {
    command = "powershell.exe -Command \"& {Set-ItemProperty -Path '${path.module}/deployer-key.pem' -Name IsReadOnly -Value $true; (Get-Item '${path.module}/deployer-key.pem').Attributes = 'ReadOnly'}\""
  }
}