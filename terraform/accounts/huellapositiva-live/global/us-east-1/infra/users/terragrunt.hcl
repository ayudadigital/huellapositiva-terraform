terraform {
  source = "../../../../../../components/users"
}

include {
  path = find_in_parent_folders()
}
