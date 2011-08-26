name "rnet-node"
run_list(
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[nginx]",
  "recipe[rnet-admin]"
)
