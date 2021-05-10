rmarkdown::render(
  "1.feature-analysis.Rmd",
  output_dir = "knit_notebooks",
  output_format = "html_notebook"
)

# TODO: Factor out the bash scripts in 2.sample-images.Rmd and 3.thumbnails.Rmd
# and then update this script to call those notebooks and scripts