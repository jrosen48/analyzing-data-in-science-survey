library(targets)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(summary) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.

# summ <- function(dataset) {
#   summarize(dataset, mean_x = mean(x))
# }

# Set target-specific options such as packages.
tar_option_set(packages = c("tidyverse", "here", "janitor"))

# End this file with a list of target objects.
list(
  tar_target(data_mailing_list, read_csv(here("data", "Analyzing+Data+in+Science_February+14,+2021_10.51.csv"))),
  tar_target(data_mailing_list_cleaned_names, janitor::clean_names(data_mailing_list)),
  tar_target(data_mailing_list_sliced, slice(data_mailing_list_cleaned_names, -c(1, 2))),
  tar_target(data_mailing_list_processed, mutate(data_mailing_list_sliced, collection = "mailing-list")),
  
  tar_target(data_social_media, read_csv(here("data", "Analyzing+Data+in+Science+-+Copy+for+Mailing+List+Posts_February+14,+2021_10.50.csv"))),
  tar_target(data_social_media_cleaned_names, janitor::clean_names(data_social_media)),
  tar_target(data_social_media_sliced, slice(data_social_media_cleaned_names, -c(1, 2))),
  tar_target(data_social_media_processed, mutate(data_social_media_sliced, collection = "mailing-list")),
  
  tar_target(data_combined, bind_rows(data_mailing_list_processed, data_social_media_processed)),
  
  tar_target(progress_density, data_combined %>% mutate(progress = as.integer(progress)) %>% ggplot(aes(x = progress)) + geom_histogram()),
  
  # may want to change this to ~40-60%
  tar_target(data_combined_filtered, data_combined %>% mutate(progress = as.integer(progress)) %>% filter(progress > 100))
  
)
