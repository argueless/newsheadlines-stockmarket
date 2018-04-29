library(xlsx)
library(tidyverse)
library(SentimentAnalysis)

data_1 <- read.xlsx("nyt_headlines.xlsx", sheetIndex = 1,stringsAsFactors=FALSE)
data_1$pub_date <- as.Date(data_1$pub_date)

subset_of_data_1 <- data_1[1:2,-1]

convert_to_score <- function(df) {
  sentiment <- analyzeSentiment(df,
                                rules=list("SentimentGI"=list(ruleSentiment, 
                                                              loadDictionaryGI())))
  sentiment$SentimentGI # I chose here Harvard General Inquirer lexicon but you can also choose other lexicons. There are I think 3 other ones including Loughran and McDonald lexicon
}

# this following operation takes about 20 seconds for my laptop. I feel like it takes little too long. 
subset_of_data_1[] <- lapply(subset_of_data_1, convert_to_score)
subset_of_data_1