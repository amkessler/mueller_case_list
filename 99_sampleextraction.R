library(tidyverse)
library(readxl)
library(janitor)
library(lubridate)

rawdata <- read_excel("sampleformat_ak.xlsx")

data <- rawdata %>% 
  clean_names() 




             