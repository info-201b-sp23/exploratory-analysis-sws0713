library(ggplot2)

#load csv file
winners <- read.csv('WorldCups.csv', stringsAsFactors = FALSE)

#create a table that contains the countries that have won the world cup and how many times they have won
Worldcup_wins_country <- winners %>% 
  group_by(Winner) %>%
  summarize(Wins = n()) %>%
  arrange(desc(Wins))

#plot the graph
ggplot(data = Worldcup_wins_country) + 
  geom_col(aes(x = Winner,
               y = Wins,
               fill = Winner)) + 
  labs(title = "World Cup Winners",
       x = "Country",
       y = "Number of Wins",
       fill = "Country")