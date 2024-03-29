
#' All names in Norway
#'
#' @param border The year in which Norwegian geographical boundaries were designated (2020, 2024).
#' @returns
#' \describe{
#' \item{location_code}{Location code.}
#' \item{location_name}{Location name.}
#' \item{location_name_short}{3 letter location name for nation and county. A shorter location name for wardoslo and extrawardoslo. }
#' \item{location_name_description_nb}{Location name with additional description.}
#' \item{location_name_file_nb_utf}{Location name that should be used in file names, with Norwegian characters.}
#' \item{location_name_file_nb_ascii}{Location name that should be used in file names, without Norwegian characters.}
#' \item{location_order}{The preferred presentation order.}
#' \item{granularity_geo}{nation, county, municip, wardoslo, wardbergen, wardstavanger, wardtrondheim, baregion, lab.}
#' }
#' @source \url{https://no.wikipedia.org/wiki/Liste_over_norske_kommunenummer}
#' @examples
#' nor_locations_names()
#' @export
nor_locations_names <- function(border = csdata::config$border_nor){
  stopifnot(border %in% c(2020, 2024))
  if(border==2020){
    x <- get0("nor_locations_names_b2020", envir = asNamespace("csdata"))
  } else if(border==2024){
    x <- get0("nor_locations_names_b2024", envir = asNamespace("csdata"))
  }
  d <- copy(x)
  return(d)
}


