# rmarkdown::render("1.feature-analysis.Rmd",
#                   output_dir = "knit_notebooks",
#                   output_format = "html_notebook")

# TODO: Factor out the bash scripts in 2.sample-images.Rmd and 3.thumbnails.Rmd
# and then update this script to call those notebooks and scripts

experiment_df <- 
  tribble(~Metadata_experiment_condition,
          ~Metadata_experiment_type,
          ~Metadata_cell_line,
          ~Metadata_timepoint,
          "Standard", "Compound", "U2OS", "24",
          "Standard", "Compound", "U2OS", "48",
          "Standard", "ORF", "U2OS", "48",
          "Standard", "CRISPR", "U2OS", "144"
  )

get_experiment_tag <- function(experiment_x) {
  
  experiment_x %>%
    unite("experiment_tag", everything()) %>%
    pull("experiment_tag") %>%
    sort() %>%
    paste(collapse = "_")
  
}

notebook_name <- "2.sample-images"

for (i in seq(nrow(experiment_df))) {
  
  experiment_i <- slice(experiment_df, i)
  
  experiment_tag <- get_experiment_tag(experiment_i)
  
  rmarkdown::render(
    glue("{notebook_name}.Rmd"),
    output_dir = "knit_notebooks",
    output_format = "html_notebook",
    output_file = glue("{notebook_name}_{experiment_tag}.Rmd"),
    params = list(experiment = as.list(experiment_i))
  )  
}

# NOTE: Before proceeding, run bash script in `2.sample-images.Rmd` for each of 
# the parametrizations

notebook_name <- "3.thumbnails"

for (i in seq(nrow(experiment_df))) {
  
  experiment_i <- slice(experiment_df, i)
  
  experiment_tag <- get_experiment_tag(experiment_i)
  
  rmarkdown::render(
    glue("{notebook_name}.Rmd"),
    output_dir = "knit_notebooks",
    output_format = "html_notebook",
    output_file = glue("{notebook_name}_{experiment_tag}.Rmd"),
    params = list(experiment = as.list(experiment_i))
  )  
}
