# Checks for environment variable
check_env_var <- function(x)
{
  tmp <- if (is.null(x))
    Sys.getenv("EKL_IP", "")
  else x
  if (tmp == "")
    stop("Please ensure you have set the environment variable EKL_IP",
         " with the IP address of you Elgato Key Light or supply the",
         " `keylight_ip` parameter")
  else tmp
}

# Builds out the full API URL from the supplied IP address
construct_api_url <- function(keylight_ip=NULL){
  paste0("http://", check_env_var(keylight_ip), ":9123/elgato/lights")
}

# Pretty prints ekl::get_state()
print.ekl <- function(x){
  cat("Current Key Light settings:\n")
  cat(sprintf("  on/off: %9s\n", x$lights[[1]]$on))
  cat(sprintf("  brightness: %5s\n", x$lights[[1]]$brightness))
  cat(sprintf("  temperature: %4s\n", x$lights[[1]]$temperature))
}
