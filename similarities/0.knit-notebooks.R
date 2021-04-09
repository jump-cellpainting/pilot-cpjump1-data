library(magrittr)
library(tidyverse)

render_notebook <-
  function(notebook,
           data_level,
           similarity_method,
           Metadata_cell_line,
           Metadata_experiment_condition) {
    notebook_name <- tools::file_path_sans_ext(notebook)
    parameters <- list(
      data_level = data_level,
      similarity_method = similarity_method,
      experiment =
        data.frame(
          Metadata_cell_line = Metadata_cell_line,
          Metadata_experiment_condition = Metadata_experiment_condition
        )
    )
    
    parameters_tag <-
      glue::glue(
        "{Metadata_cell_line}_{Metadata_experiment_condition}_{data_level}_sim_{similarity_method}"
      )
    
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


render_all_notebooks <-
  function(notebooks, ...) {
    notebooks %>%
      walk(function(notebook) {
        render_notebook(notebook, ...)
        
      })
  }


Metadata_cell_line <- "U2OS"
Metadata_experiment_condition <- "Standard"

notebooks <- c(
  "1.measure_similarities.Rmd",
  "2.collate_similarities.Rmd",
  "3.inspect_similarities.Rmd"
)


# Whole-plate z-scored


data_level <- "normalized_feature_select_outlier_trimmed"


## Pearson


similarity_method <- "pearson"

render_all_notebooks(
  notebooks,
  data_level = data_level,
  similarity_method = similarity_method,
  Metadata_cell_line = Metadata_cell_line,
  Metadata_experiment_condition = Metadata_experiment_condition
)

## Cosine

similarity_method <- "cosine"

render_all_notebooks(
  notebooks,
  data_level = data_level,
  similarity_method = similarity_method,
  Metadata_cell_line = Metadata_cell_line,
  Metadata_experiment_condition = Metadata_experiment_condition
)

# Husked

data_level <- "normalized_feature_select_outlier_trimmed_husked"

## Euclidean

similarity_method <- "euclidean"

render_all_notebooks(
  notebooks,
  data_level = data_level,
  similarity_method = similarity_method,
  Metadata_cell_line = Metadata_cell_line,
  Metadata_experiment_condition = Metadata_experiment_condition
)

## Cosine

similarity_method <- "cosine"

render_all_notebooks(
  notebooks,
  data_level = data_level,
  similarity_method = similarity_method,
  Metadata_cell_line = Metadata_cell_line,
  Metadata_experiment_condition = Metadata_experiment_condition
)
