terraform {
  source = "../../../../../../components/vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_config = {
    cidr_block = "10.0.0.0/23",
    newbits = "3"
  }
}