library(dplyr)
library(ggplot2)
# calculate the home team stat
home_team_stats <- WorldCupMatches %>%
  group_by(`Home.Team.Name`) %>%
  summarize(
    Total_Goals_Home = sum(`Home.Team.Goals`),
    Total_Losses_Home = sum(`Away.Team.Goals`)
  )

# calculate the away team stat
away_team_stats <- WorldCupMatches %>%
  group_by(`Away.Team.Name`) %>%
  summarize(
    Total_Goals_Away = sum(`Away.Team.Goals`),
    Total_Losses_Away = sum(Home.Team.Goals)
  )

# combine
team_stats <- full_join(home_team_stats, away_team_stats, by = c("Home.Team.Name" = "Away.Team.Name"))

# calculate total team stat
team_stats$Total_Goals <- team_stats$Total_Goals_Home + team_stats$Total_Goals_Away
team_stats$Total_Losses <- team_stats$Total_Losses_Home + team_stats$Total_Losses_Away

# Chart 
ggplot(team_stats, aes(x = Total_Goals, y = Total_Losses, label = `Home.Team.Name`)) +
  geom_point() +
  geom_text(hjust = 1, vjust = -0.5, size = 3) +
  labs(x = "Goal", y = "Loss", title = "Goals scored and goals conceded of World Cup Matches")
