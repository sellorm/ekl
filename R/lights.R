#' Fine grained control of the light state
#'
#' @param state One of "on" or "off"
#' @param brightness int from 1-100. If not supplied the current setting is retained.
#' @param temp int corresponding to the desired colour temperature (143-344)
#'    If not supplied the current setting is retained.
#' @param keylight_ip optional IP address of your Keylight. Setting the EKL_IP
#'   env var is preferred
#'
#' @export
set_state <- function(state, brightness=NA, temp=NA, keylight_ip=NULL){
  api_url <- construct_api_url(keylight_ip)
  if (!(state %in% c("on", "off"))){
    stop("state must be one of either 'on' or 'off'")
  }
  response <- httr::GET(api_url)
  json <- httr::content(response)

  # on/off
  if (state == "on"){
    light_state <- 1
  } else {
    light_state <- 0
  }

  if (json$lights[[1]]$on != light_state){
    json$lights[[1]]$on <- light_state
  }

  # temp
  if (! is.na(temp)){
    json$lights[[1]]$temperature <- temp
  }

  # brightness
  if (! is.na(brightness)){
    json$lights[[1]]$brightness <- brightness
  }

  # Send payload to the API
  put_response <- httr::PUT(api_url,
                            body = json,
                            encode = "json")
}


#' Get's the current state of your Elgato Key Light
#'
#' @param keylight_ip optional IP address of your Keylight. Setting the EKL_IP
#'   env var is preferred
#'
#' @export
get_state <- function(keylight_ip=NULL){
  api_url <- construct_api_url(keylight_ip)
  response <- httr::GET(api_url)
  json <- httr::content(response)
  class(json) <- c("ekl", "list")
  json
}


#' Toggles the light on/off
#'
#' @param keylight_ip optional IP address of your Keylight. Setting the EKL_IP
#'   env var is preferred
#'
#' @export
toggle <- function(keylight_ip=NULL){
  api_url <- construct_api_url(keylight_ip)
  response <- httr::GET(api_url)
  json <- httr::content(response)

  # toggle
  if (json$lights[[1]]$on == 0){
    json$lights[[1]]$on <- 1
  } else {
    json$lights[[1]]$on <- 0
  }

  # Send payload to the API
  put_response <- httr::PUT(api_url,
                            body = json,
                            encode = "json")
}
