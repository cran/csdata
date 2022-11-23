## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(csdata)
library(data.table)
library(magrittr)

## ----echo=FALSE, results='asis'-----------------------------------------------
d <- csdata::nor_locations_names()[, .(
  location_order = paste0("#", location_order),
  location_code,
  location_name_description_nb
)]

gt::gt(d) %>%
  gt::tab_options(
    table.width = "750px"
  ) %>%
  gt::tab_header(title = "Reference table of location_code and location_name_description_nb") %>%
  gt::cols_label(
    location_order = "#"
  )

