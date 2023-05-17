terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 1.21.0"
    }
  }
}

provider "rancher2" {
  api_url    = "https://localhost/v3"
  access_key = "<PASTE_ACCESS_KET_HERE>"
  secret_key = "<PASTE_SECRET_KEY_HERE>"
  insecure   = true
}




resource "rancher2_cluster_template" "ellebam" {
  name        = "sample-cluster-template"
  description = "sample Cluster Template"

  members {
    access_type       = "owner"
    user_principal_id = "<RANCHER_USER_PRINCIPAL_ID>"
  }
}

resource "rancher2_cluster_template_revision" "sample" {
  name                = "v1"
  cluster_template_id = rancher2_cluster_template.ellebam.id

  cluster_config {
    docker_root_dir           = "/var/lib/docker"
    enable_cluster_monitoring = true
    enable_network_policy     = true
  }
}

resource "rancher2_cluster" "sample" {
  name                         = "sample"
  cluster_template_revision_id = rancher2_cluster_template_revision.ellebam.id
  # Node pool configuration
  default_node_pool {
    name             = "default"
    hostname_prefix  = "worker"
    node_template_id = rancher2_node_template.docker.id
    quantity         = 3
  }
}


resource "rancher2_node_pool" "ellebam_node_pool" {
  cluster_id       = rancher2_cluster.ellebam.id
  name             = "sample-node-pool"
  hostname_prefix  = "node"
  node_template_id = rancher2_node_template.docker.id
  quantity         = 3
  control_plane    = true
  etcd             = true
  worker           = true
}

resource "rancher2_node_template" "docker" {
  # Adjust the values according to your requirements
  name        = "docker"
  description = "Docker node template"
  driver      = "docker-machine-driver"
  # Add required configuration for the Docker driver
}

output "kubeconfig" {
  value     = rancher2_cluster.ellebam.kube_config
  sensitive = true
}
