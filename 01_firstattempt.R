library(pdftools)
library(tidyverse)
library(janitor)
library(lubridate)

myfile <- "muellerlist_ak1.pdf"


text <- pdf_text(myfile)[1]
text
cat(text)


# All textboxes on page 1 
textboxes <- pdf_data(myfile)[[1]]
View(textboxes)


##extract between two words using gsub and regex ####

df <- tibble(
  ad_landing_page = str_squish(gsub(".*1:17-\\s*|1:17-.*", "", text)),
  ad_id = str_extract(text, "1:17-.*")
)
  

df

df %>% 
  write_csv("df.csv")
  
  