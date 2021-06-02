terraform {
  source = "../../../../../../components/kms"
}

include {
  path = find_in_parent_folders()
}
