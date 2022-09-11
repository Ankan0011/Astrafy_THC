terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.34.0"
    }
  }
}

provider "google" {
  #Adding the credentials, skip the service account resource
  region      = var.region
  zone        = var.zone
}

resource "google_project" "project" {
  name       = "Astrafy Demo"
  project_id = "astrafydemo2"
  billing_account = var.billing_account
}

resource "google_service_account" "bqowner" {
  account_id = "astrafy"
}

resource "google_project_service" "service" {
  for_each = toset([
    "compute.googleapis.com",
    "bigquery.googleapis.com",
    "notebooks.googleapis.com"

  ])

  service = each.key

  project            = google_project.project.project_id
  disable_on_destroy = false
}