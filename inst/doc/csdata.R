## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(csdata)
library(data.table)
library(magrittr)

## ----echo=FALSE, results='asis'-----------------------------------------------
d <- csdata::nor_locations_names()[, .(
  n = .N,
  location_code = location_code[1],
  location_name = location_name[1],
  location_name_description_nb = location_name_description_nb[1],
  location_name_file_nb_utf = location_name_file_nb_utf[1],
  location_name_file_nb_ascii = location_name_file_nb_ascii[1]
),
by = .(granularity_geo)
]

gt::gt(d) %>%
  gt::tab_options(
    table.width = "1500px"
  ) %>%
  gt::tab_header(title = "Valid locations and location types in the csverse format") %>%
  gt::cols_label(
    granularity_geo = "Geo (Granularity)",
    n = "N"
  ) %>%
  # gt::cols_width(
  #   granularity_time ~ "20%",
  #   class ~ "15%",
  #   fn ~ "20%",
  #   example ~ "55%"
  # ) %>%
  gt::tab_spanner(
    label = "Examples",
    columns = c(location_code, location_name, location_name_description_nb, location_name_file_nb_utf, location_name_file_nb_ascii)
  ) %>%
  gt::tab_footnote(
    footnote = gt::md("**location_code**: Used a) **inside datasets** and b) in data **file names** for transfer of data/results between analytic systems. All values are unique."),
    locations = gt::cells_column_labels(
      columns = location_code
    )
  ) %>%
  gt::tab_footnote(
    footnote = gt::md("**location_name**: Used (rarely) **inside results** (figures, tables, documents). Can be confusing as some names are duplicated. Its rare usage is demarcated by a line through the text."),
    locations = gt::cells_column_labels(
      columns = location_name
    )
  ) %>%
  gt::tab_style(
    style = list(
      gt::cell_text(decorate = "line-through")
    ),
    locations = gt::cells_body(
      columns = location_name,
      rows = gt::everything()
    )
  ) %>%
  gt::tab_footnote(
    footnote = gt::md("**location_name_description_nb**: Used (frequently) **inside results** (figures, tables, documents). All values are unique."),
    locations = gt::cells_column_labels(
      columns = location_name_description_nb
    )
  ) %>%
  gt::tab_footnote(
    footnote = gt::md("**location_name_file_nb_utf**: Used (frequently) in the **file names** for results (figures, tables, documents). All values are unique."),
    locations = gt::cells_column_labels(
      columns = location_name_file_nb_utf
    )
  ) %>%
  gt::tab_footnote(
    footnote = gt::md("**location_name_file_nb_ascii**: Used (rarely) in the **file names** for results (figures, tables, documents). Used if file systems have problems with the Norwegian letters æøå. All values are unique."),
    locations = gt::cells_column_labels(
      columns = location_name_file_nb_ascii
    )
  ) %>%
  gt::tab_footnote(
    footnote = "Bo- og arbeidsmarkedsregioner. Housing and labor market regions.",
    locations = gt::cells_body(
      columns = granularity_geo,
      rows = granularity_geo == "baregion"
    )
  ) %>%
  gt::tab_footnote(
    footnote = "Landsdeler/riskdeler. Geographical regions.",
    locations = gt::cells_body(
      columns = granularity_geo,
      rows = granularity_geo == "georegion"
    )
  ) %>%
  gt::tab_footnote(
    footnote = "Mattilsynet-regioner. Food authority regions.",
    locations = gt::cells_body(
      columns = granularity_geo,
      rows = granularity_geo == "mtregion"
    )
  )

## ----echo=FALSE, results='asis'-----------------------------------------------
d <- rbind(
  data.frame(
    value = "\"000\"",
    class = "character",
    definition = "One year age group (0 year olds)"
  ),
  data.frame(
    value = "\"079\"",
    class = "character",
    definition = "One year age group(79 year olds)"
  ),
  data.frame(
    value = "\"000_004\"",
    class = "character",
    definition = "Age span of 0-4 year olds"
  ),
  data.frame(
    value = "\"065p\"",
    class = "character",
    definition = "Age span of >=65 year olds"
  ),
  data.frame(
    value = "\"missing\"",
    class = "character",
    definition = "Missing/unknown"
  ),
  data.frame(
    value = "\"total\"",
    class = "character",
    definition = "Everyone"
  )
)

gt::gt(d) %>%
  gt::tab_header(title = "Valid ages in the csverse format") %>%
  gt::cols_label(
    value = "Value",
    definition = "Definition"
  )

## ----echo=FALSE, results='asis'-----------------------------------------------
d <- rbind(
  data.frame(
    value = "\"male\"",
    class = "character",
    definition = "Male"
  ),
  data.frame(
    value = "\"female\"",
    class = "character",
    definition = "Female"
  ),
  data.frame(
    value = "\"missing\"",
    class = "character",
    definition = "Missing/unknown"
  ),
  data.frame(
    value = "\"total\"",
    class = "character",
    definition = "Everyone"
  )
)

gt::gt(d) %>%
  gt::tab_header(title = "Valid sexes in the csverse format") %>%
  gt::cols_label(
    value = "Value",
    definition = "Definition"
  )

