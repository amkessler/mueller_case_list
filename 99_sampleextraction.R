library(tidyverse)
library(readxl)
library(janitor)
library(lubridate)

rawdata <- read_excel("sampleformat_ak.xlsx")

#some initial cleaning
data <- rawdata %>% 
  clean_names() %>% 
  mutate(
    case_number_title = str_to_upper(str_squish(case_number_title)),
    dates = str_to_upper(str_squish(dates)),
    category_event = str_to_upper(str_squish(category_event)),
    additional_description = str_to_upper(str_squish(additional_description))
  )

head(data)


#begin extracting elements into new fields using string functions/regex
test <- data %>% 
  mutate(
    date_entered = str_trim(gsub(".*ENTERED:\\s*|FILED.*", "", dates)),
    date_filed = str_trim(gsub(".*FILED:\\s*", "", dates)),
    category = str_trim(gsub(".*CATEGORY:\\s*|EVENT.*", "", category_event)),
    event = str_trim(gsub(".*EVENT:\\s*|DOCUMENT.*", "", category_event)),
    document = str_trim(gsub(".*DOCUMENT:\\s*", "", category_event))
  )


# 
# df <- tibble(
#   document_name = myfile,
#   # ad_id = str_trim(gsub(".*Ad ID\\s*|Ad Text.*", "", text)),
#   ad_id = str_trim(str_remove(str_extract(text, "Ad ID.*"), "Ad ID")),
#   ad_text = if_else(
#     str_detect(text, "Ad Text"),
#     str_trim(gsub(".*Ad Text\\s*|Ad Landing.*", "", text)),
#     ""),
#   ad_landing_page = str_trim(gsub(".*Ad Landing Page\\s*|Ad Targeting.*", "", text)),
#   ad_impressions = if_else(
#     str_detect(text, "Ad Impressions"),
#     str_trim(gsub(".*Ad Impressions\\s*|Ad Clicks.*", "", text)),
#     ""),
#   ad_clicks = if_else(
#     str_detect(text, "Ad Clicks"),
#     str_trim(gsub(".*Ad Clicks\\s*|Ad Spend.*", "", text)),
#     ""),
#   ad_spend = if_else(
#     str_detect(text, "Ad Spend"),
#     str_trim(gsub(".*Ad Spend\\s*|Ad Creation.*", "", text)),
# 
#              