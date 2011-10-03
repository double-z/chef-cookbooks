name "rnet-wordpress"
run_list(
  "recipe['php']",
  "recipe['mysql::server']",
  "recipe['rnet-wordpress']"
)
