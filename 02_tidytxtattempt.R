library(tidyverse)
library(pdftools)
library(ggpage)
library(tidytext)

# ingest file
mueller_list_txt <- pdf_text("muellerlist_ak1.pdf")

# create dataframe with each line on a row, with page and row number
mueller_list <- tibble(
  page = 1:length(mueller_list_txt),
  text = mueller_list_txt
  ) %>% 
  separate_rows(text, sep = "\n") %>% 
  group_by(page) %>% 
  mutate(line = row_number()) %>% 
  ungroup() %>% 
  select(page, line, text)


#save to file
write_csv(mueller_list, "mueller_list1.csv")

# remove lines containing title 
mueller_list2 <- mueller_list[-c(1:5),] 

#remove header rows on each page
mueller_list2 <- mueller_list2 %>% 
  filter(!str_detect(text, "Case 1:19-mc-00058-BAH"))

#mark when a new case begins
mueller_list2 <- mueller_list2 %>% 
  mutate(
    newcase_mark = if_else(str_detect(text, "1:17-mj"), "New Case", "")
    ) %>% 
  select(
    page,
    line,
    newcase_mark,
    text
  ) %>% 
  write_csv("mueller_list2.csv") 


mueller_list3 <- mueller_list2 %>% 
  mutate(
    text = str_squish(text)
  ) %>% 
  write_csv("mueller_list3.csv")  



# # tidy text format
# tidy_mueller_list <- mueller_list %>%
#   unnest_tokens(word, text)




