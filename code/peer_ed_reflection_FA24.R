# peer_ed_reflection_FA24.R
# Timothy Skolds
# Created 10/18/2024
# Edited 11/6/2024
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

# Graphical representation
common_words <- word_count %>%
  slice_max(n = 25, order_by = n)

common_word_plot <- ggplot(common_words,
                           aes(x = word,
                               y = n)) +
  geom_bar(stat = "identity",
           fill = "forestgreen") +
  theme_gray() +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  labs(x = "Word",
       y = "Count",
       title = "Common Words",
       subtitle = "The top 25 most common words from reflection responses.
(Includes ties)")
print(common_word_plot)
