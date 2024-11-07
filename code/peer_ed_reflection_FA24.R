# peer_ed_reflection_FA24.R
# Timothy Skolds
# Created 10/18/2024
# Edited 10/18/2024
# Analysis of reflection responses from FA24 cycling peer-ed session (nutrition
# talk from Kristen Arnold)

library(tidyverse)
library(tidytext)
library(wordcloud2)

# Import data
reflection_responses <- read_csv(file = "../data/reflection_responses.csv")

# Break up
word_data <- reflection_responses %>%
  unnest_tokens(word, response) %>%
  anti_join(stop_words) %>%
  filter(!word %in% c("learned", "hour", "bad", "lot") & !str_detect(word, "^\\d+$") & !str_detect(word, "’"))

# count
word_count <- word_data %>%
  count(word, sort = TRUE)

# Word cloud
wordcloud2(word_count,
           size = 0.5,
           color = 'random-dark',
           fontFamily = "Arial")
