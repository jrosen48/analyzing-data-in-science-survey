#irr

library(tidyverse)
library(readxl)

check_kappa <- function(d1, d2, number) {
  
  combined_data <- data.frame(pull(d1[, number]),
                              pull(d2[, number]))
  
  irr::kappa2(combined_data)
  
}

# q80

for_qual_coding_irr <- read_excel("for-qual-coding-irr.xlsx", sheet = 4) # for q80; 11-12 for q82

for_qual_coding_irr1 <- read_excel("for-qual-coding-irr.xlsx", sheet = 5)

for_qual_coding_irr <- for_qual_coding_irr %>% 
  janitor::clean_names() %>% 
  slice(1:40) %>% 
  mutate_if(is.numeric, replace_na, 0)

for_qual_coding_irr1 <- for_qual_coding_irr1 %>% 
  janitor::clean_names() %>% 
  slice(1:40) %>% 
  mutate_if(is.numeric, replace_na, 0)

3:9 %>% 
  map(check_kappa, 
      d1 = for_qual_coding_irr, 
      d2 = for_qual_coding_irr1)

# q82

for_qual_coding_irr <- read_excel("for-qual-coding-irr.xlsx", sheet = 11) # for q80; 11-12 for q82

for_qual_coding_irr1 <- read_excel("for-qual-coding-irr.xlsx", sheet = 12)

for_qual_coding_irr <- for_qual_coding_irr %>% 
  janitor::clean_names() %>% 
  slice(1:40) %>% 
  mutate_if(is.logical, as.numeric) %>% 
  mutate_if(is.numeric, replace_na, 0)

for_qual_coding_irr1 <- for_qual_coding_irr1 %>% 
  janitor::clean_names() %>% 
  slice(1:40) %>% 
  mutate_if(is.logical, as.numeric) %>% 
  mutate_if(is.numeric, replace_na, 0)

3:10 %>% 
  map(check_kappa, 
      d1 = for_qual_coding_irr, 
      d2 = for_qual_coding_irr1)
