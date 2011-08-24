role "rnet-node"
run_list(
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[rnet-admin]"
)
