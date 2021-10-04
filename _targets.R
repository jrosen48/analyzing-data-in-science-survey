library(targets)

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
  tar_target(for_email_addresses, data_combined %>% mutate(progress = as.integer(progress)) %>% filter(!is.na(email_b))),
  tar_target(write_email_addresses, for_email_addresses %>% select(end_date, email_b, collection, progress) %>% write_csv("emails-to-message.csv")),
  tar_target(data_combined_filtered, data_combined %>% mutate(progress = as.integer(progress)) %>% filter(progress >= 40))
  
)
