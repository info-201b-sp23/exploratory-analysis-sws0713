library(dplyr)
library(knitr)


winners <- read.csv('WorldCups.csv')

worldcup <- read.csv('WorldCupMatches.csv')

aggregate_table <- worldcup %>%
  group_by(Country = `Home.Team.Name`) %>%
  summarise(
    TotalMatches = n(),
    TotalWins = sum(`Home.Team.Goals` > `Away.Team.Goals`),
    AverageGoalsScored = mean(`Home.Team.Goals`),
    AverageGoalsConceded = mean(`Away.Team.Goals`),
    Home.Team.Goals = sum(`Home.Team.Goals`),
    Away.Team.Goals = sum(`Away.Team.Goals`)
  ) %>%
  arrange(desc(TotalWins))

aggregate_table <- aggregate_table %>%
  left_join(winners, by = c("Country" = "Country"))

aggregate_table <- aggregate_table %>%
  group_by(Country) %>%
  mutate(WorldCupWins = sum(!is.na(Winner))) %>%
  ungroup()

aggregate_table <- aggregate_table %>% distinct(Country, .keep_all = TRUE)

