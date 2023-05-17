# Rancher Server Deployment and Configuration using Docker, Terraform, and Make

This repository contains files for deploying and configuring a Rancher server and a Kubernetes cluster using Docker, Terraform, and Make. Rancher is an open-source platform for running containers that provides a full set of infrastructure services for containers, including networking, storage services, host management, load balancing, and more.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation/Setup](#installationsetup)
- [Usage](#usage)
- [Terraform Deployment](#terraformdeployment)
- [Make Commands](#makecommands)
- [Contribution](#contribution)

## Prerequisites

To run this project, you'll need:

- Docker Engine and Docker Compose installed on your machine.
- Terraform installed on your machine.
- Make installed on your machine.
- A text editor to modify environment variables in the `docker-compose.yml` and `main.tf` files.

## Installation/Setup

1. Clone this repository to your local machine.
2. Navigate to the directory containing the `docker-compose.yml` file.
3. Open `docker-compose.yml` in a text editor and replace `<PASTE_PUBKEY_HERE>` with your public SSH key in the `CATTLE_BOOTSTRAP_ADMIN_SSHKEY` environment variable.
4. Save the changes and close the file.

## Usage

To start the Rancher server:

1. Run `make rancher-up` in the terminal from the root directory of the project.
2. Open a web browser and navigate to `https://localhost`.
3. Log in with the username `rumil` and the password `limur`.

**Note:** The Rancher server is running in a Docker network named `rumil_network`. If you have other services that you want to interact with the Rancher server, they need to be in the same network.

## Terraform Deployment

The `main.tf` file is used to create and configure a Rancher server and a Kubernetes cluster using Terraform.

To apply the Terraform configuration:

1. Open `main.tf` in a text editor.
2. Replace `<PASTE_ACCESS_KEY_HERE>` and `<PASTE_SECRET_KEY_HERE>` with your Rancher server's access key and secret key, respectively. Also replace `<RANCHER_USER_PRINCIPAL_ID>` with your Rancher user principal ID.
3. Save the changes and close the file.
4. Run `terraform init` to initialize your Terraform configuration.
5. Run `terraform apply` to create and configure your Rancher server and Kubernetes cluster.

After the `terraform apply` command finishes, it will output the `kubeconfig` for the created Kubernetes cluster. You can use this `kubeconfig` to interact with your cluster using `kubectl`.

## Make Commands

The `Makefile` contains several commands that simplify the management of the Rancher server:

- `make rancher-up`: Starts the Rancher server.
- `make rancher-down`: Stops the Rancher server.
- `make rancher-reup`: Restarts the Rancher server.
- `make rancher-ip`: Prints the IP address of the Rancher server.
- `make kube-create`: Creates a Kubernetes cluster using the Ansible playbook `rancher_local_cluster_creation.yml`.

## Contribution

Contributions are welcome! Please read the contribution guidelines first.
