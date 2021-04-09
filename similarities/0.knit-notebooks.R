library(magrittr)
library(tidyverse)

render_notebook <-
  function(notebook,
           data_level,
           similarity_method,
           Metadata_experiment_condition) {
    notebook_name <- tools::file_path_sans_ext(notebook)
    parameters <- list(
      data_level = data_level,
      similarity_method = similarity_method,
      experiment =
        data.frame(Metadata_experiment_condition = Metadata_experiment_condition)
    )
    
    parameters_tag <-
      glue::glue("{Metadata_experiment_condition}_{data_level}_sim_{similarity_method}")
    
    print(parameters)
    
    output_file <-
      glue::glue("knit_notebooks/{notebook_name}_{parameters_tag}.nb.html")
    
    rmarkdown::render(
      glue::glue("{notebook_name}.Rmd"),
      params = parameters,
      output_file = output_file,
      quiet = TRUE
    )
    
  }

render_notebook_sets <-
  function(notebooks, ...) {
    notebooks %>%
      walk(function(notebook) {
        render_notebook(notebook, ...)
        
      })
  }

notebooks <- c(
  "1.measure_similarities.Rmd",
  "2.collate_similarities.Rmd",
  "3.inspect_similarities.Rmd"
)

Metadata_experiment_condition <- "Standard"

sets <-
  tribble(
    ~data_level, ~similarity_method,
#    "normalized_feature_select_outlier_trimmed", "pearson",
    "normalized_feature_select_outlier_trimmed", "cosine",
    # "normalized_feature_select_outlier_trimmed_husked", "euclidean",
    "normalized_feature_select_outlier_trimmed_husked", "cosine"
  )

sets %>%
  pwalk(function(data_level,
                 similarity_method) {
    render_notebook_sets(
      notebooks = notebooks,
      data_level = data_level,
      similarity_method = similarity_method,
      Metadata_experiment_condition = Metadata_experiment_condition
    )
  })
