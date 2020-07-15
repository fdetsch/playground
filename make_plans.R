library(drake)

## dynamically create plans
for (customer in c("customer_a", "customer_b")) {
  plan = paste("plan", customer, sep = "_")
  
  source("R/plan_template.R")
  
  path = file.path(".drake", customer)
  if (!dir.exists(path)) {
    jnk = drake::new_cache(path)
  }
  
  make(
    eval(parse(text = plan))
    , cache = drake::drake_cache(path)
    , lock_envir = FALSE
  )
  
  cat("outcome is '", readd(outcome, path = path), "'\n", sep = "")
}

# ## same in lapply, requires source()-ing from local environment
# lapply(
#   c("customer_a", "customer_b")
#   , function(customer) {
#     plan = paste("plan", customer, sep = "_")
#     
#     source("R/plan_template.R", local = TRUE)
#     
#     path = file.path(".drake", customer)
#     if (!dir.exists(path)) {
#       jnk = drake::new_cache(path)
#     }
#     
#     make(
#       eval(parse(text = plan))
#       , cache = drake::drake_cache(path)
#       , lock_envir = FALSE
#     )
#     
#     readd(outcome, path = path)
#   }
# )
