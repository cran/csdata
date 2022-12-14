## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(csdata)
library(data.table)
library(magrittr)
library(ggplot2)

## ---- results='asis'----------------------------------------------------------
pd <- csdata::nor_population_by_age_cats()[granularity_geo %in% "nation" & calyear>=1990]

q <- ggplot(pd, aes(x=calyear, y = pop_jan1_n))
q <- q + geom_line()
q <- q + geom_point(mapping = aes(color = imputed))
q <- q + scale_x_continuous("Calendar year (calyear)")
q <- q + scale_y_continuous("Population as of Jan 1 (pop_jan1_n)")
q <- q + scale_color_discrete("Imputed")
q <- q + labs(title = "Norway (nation_nor)")
q

## ----echo=FALSE, results='asis'-----------------------------------------------
d <- csdata::nor_population_by_age_cats()[csdata::nor_locations_names(),on="location_code"][granularity_geo %in% c("nation","county") & calyear>=1990]
setorder(d,location_order,calyear)
d <- d[,.(
  location_name_description_nb, 
  calyear,
  pop_jan1_n = formatC(pop_jan1_n, big.mark=".", decimal.mark=",", format="f", digits=0)
)]

d[, min_year := min(calyear), by=.(location_name_description_nb)]
d[, max_year := max(calyear), by=.(location_name_description_nb)]

ids <- list()
for(i in 1:nrow(d)){
  if(d[i]$calyear==d[i]$min_year){
    ids[[length(ids)+1]] <- list(
      label = d[i]$location_name_description_nb,
      start_row = i
    )
  } else if(d[i]$calyear==d[i]$max_year){
    ids[[length(ids)]]$stop_row <- i
  }
}

d[, location_name_description_nb := NULL]
d[, min_year := NULL]
d[, max_year := NULL]

to_print <- gt::gt(d) %>%
  gt::tab_options(
    table.width = "300px"
  )
for(i in length(ids):1){
  to_print %<>% 
    gt::tab_row_group(
      label = ids[[i]]$label,
      rows = ids[[i]]$start_row:ids[[i]]$stop_row
    )
}
to_print %>%
  gt::tab_header(title = "Reference table of calyear and pop_jan1_n")

