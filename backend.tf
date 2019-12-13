terraform {
  backend "remote" {
    hostname     = "tfe.teamcarbon.io"
    organization = "IQVIA"
    token        = "SUPPLY YOUR OWN TFE USER TOKEN HERE"

    workspaces {
      prefix = "tfe-refactor_eks_"
    }
  }
}
