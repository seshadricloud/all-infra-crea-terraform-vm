# All Infra Crea Terraform VM

This project automates the creation and management of virtual machines (VMs) using Terraform, designed for an infrastructure-as-code (IaC) approach.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Outputs](#outputs)
- [Cleanup](#cleanup)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Terraform**: Installed and configured on your local machine. [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **Cloud Provider Credentials**: Ensure you have the necessary credentials to access your cloud provider.
- **VM Templates**: Make sure your VM templates or images are ready and accessible.

## Installation

1. Clone this repository:
    ```sh
    git clone https://github.com/yourusername/all-infra-crea-terraform-vm.git
    cd all-infra-crea-terraform-vm
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

## Usage

### Step 1: Customize the Variables

Edit the `variables.tf` file to set the desired values for your deployment, such as VM size, region, and network configurations.

### Step 2: Deploy the Infrastructure

1. Plan the Terraform execution:
    ```sh
    terraform plan
    ```

2. Apply the changes:
    ```sh
    terraform apply
    ```

### Step 3: Access the VMs

Once the deployment is complete, Terraform will output the details of the VMs created, including IP addresses and login credentials.

## Configuration

### Example `variables.tf`

```hcl
variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "my-vm"
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "region" {
  description = "Cloud region to deploy"
  type        = string
  default     = "eastus"
}

# Add other variables as necessary
```

### Example `main.tf`

```hcl
provider "azurerm" {
  features = {}
}

resource "azurerm_virtual_machine" "my_vm" {
  name                  = var.vm_name
  location              = var.region
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

  # Additional configuration...
}
```

## Outputs

The following outputs will be available after the successful execution of the Terraform plan:

- `vm_public_ip`: The public IP address of the VM.
- `vm_id`: The ID of the VM.

## Cleanup

To destroy the resources created by this Terraform configuration, use the following command:

```sh
terraform destroy
```

## Contributing

If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are welcome.

1. Fork it!
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
