library(dplyr)
library(knitr)

setwd("~/Desktop/WorldCup")
winners <- read.csv('WorldCups.csv', stringsAsFactors = FALSE)
worldcup <- read.csv('WorldCupMatches.csv', stringsAsFactors = FALSE)

aggregate_table <- worldcup %>%
  group_by(`Home.Team.Name`) %>%
  summarise(
    TotalMatches = n(),
    TotalWins = sum(`Home.Team.Goals` > `Away.Team.Goals`),
    AverageGoalsScored = round(mean(`Home.Team.Goals`), 2),
    AverageGoalsConceded = round(mean(`Away.Team.Goals`), 2),
    Home.Team.Goals = sum(`Home.Team.Goals`),
    Away.Team.Goals = sum(`Away.Team.Goals`),
    Home.Team.Name = first(`Home.Team.Name`),
    Away.Team.Name = first(`Away.Team.Name`)
  ) %>%
  arrange(desc(TotalWins))

aggregate_table <- left_join(aggregate_table, winners, by = c("Home.Team.Name" = "Winner")) %>%
  mutate(WorldCupWins = sum(!is.na(Year)))

aggregate_table <- aggregate_table %>%
  mutate(WorldCupWins = sum(`Home.Team.Name` %in% worldcup$Home.Team.Name[worldcup$Stage == "Final"]))

