process_notebook_params <- function(params) {
  # ------------------------------------------------------------------------------
  
  experiment <<- as.data.frame(params$experiment)
  
  if (!is.null(experiment)) {
    experiment_tag <<-
      as.data.frame(params$experiment) %>%
      unite("experiment_tag", everything()) %>%
      pull("experiment_tag") %>%
      sort() %>%
      paste(collapse = "_")
  } else {
    experiment_tag <<- "all"
  }
  
  # ------------------------------------------------------------------------------
  
  strata <<- params$strata
  
  if (!is.null(params$strata)) {
    strata_tag <<-
      params$strata %>%
      str_remove_all("Metadata_") %>%
      sort() %>%
      paste(collapse = "-")
  } else {
    strata_tag <<- "none"
  }
  
  strata_tag <- paste0("same_", strata_tag)
  
  comparision_tag <<- paste(experiment_tag, strata_tag, sep = "_")
  
  # ------------------------------------------------------------------------------
  
  if (params$normalization == "whole_plate") {
    norm_suffix <<- ""
  } else if (params$normalization == "negcon") {
    norm_suffix <<- "_negcon"
  }
  
  # ------------------------------------------------------------------------------
  
  batch <<- params$batch
  
  # ------------------------------------------------------------------------------
  
  data_level <<- params$data_level
  
  data_level_tag <<-
    case_when(
      params$data_level == "normalized_feature_select_outlier_trimmed" ~ "4b",
      params$data_level == "normalized_feature_select_outlier_trimmed_husked" ~ "4c",
      TRUE ~ NA_character_
    )
  
  if (is.na(data_level_tag)) {
    futile.logger::flog.warn("There is no tag define for data level {data_level}.")
  }
  
  # ------------------------------------------------------------------------------
  
  similarity_method <<- params$similarity_method
  
  # ------------------------------------------------------------------------------
  
  normalization <<- params$normalization
  
  # ------------------------------------------------------------------------------
  
  filename_prefix <<-
    glue("{batch}_{comparision_tag}_{data_level}{norm_suffix}")
  
  # ------------------------------------------------------------------------------
}

layout_no_timestamp <- function(level,
                                msg,
                                namespace = NA_character_,
                                .logcall = sys.call(),
                                .topcall = sys.call(-1),
                                .topenv = parent.frame())
{
  paste0(attr(level, "level"), " [] ", msg)
}