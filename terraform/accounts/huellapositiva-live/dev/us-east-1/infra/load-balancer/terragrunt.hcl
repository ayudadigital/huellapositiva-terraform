terraform {
  source = "../../../../../../components/load-balancer"
}

include {
  path = find_in_parent_folders()
}
