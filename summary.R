library("dplyr")
library("stringr")

# Store the dataframes
wc_df <- read.csv("~/Desktop/Info-201/exploratory-analysis-sws0713/WorldCups.csv")
matches_df <- read.csv("~/Desktop/Info-201/exploratory-analysis-sws0713/WorldCupMatches.csv")

View(matches_df)
# What are the top 5 countries with the most World Cups won in order?
winners_table <- wc_df %>%
  group_by(Winner) %>%
  summarize(number_of_cups = n()) %>%
  arrange(desc(number_of_cups)) %>%
  head(5)

# What are the top 5 countries that have hosted the World Cup the most?
hosts_table <- wc_df %>%
  group_by(Country) %>%
  summarize(number_hosted = n()) %>%
  arrange(desc(number_hosted)) %>%
  head(5)

# What are the top 5 host countries with the highest attendance?
attendance_table <- wc_df %>%
  select(Year, Country, Attendance) %>%
  mutate(Attendance = as.numeric(gsub("\\.", "", Attendance))) %>%
  arrange(desc(Attendance)) %>%
  head(5)

# What are the top 5 countries with the highest number of goals scored?
goal_summary <- matches_df %>%
  group_by(Home.Team.Name) %>%
  summarize(total_goals = sum(Home.Team.Goals)) %>%
  rename(country = Home.Team.Name) %>%
  bind_rows(matches_df %>%
              group_by(Away.Team.Name) %>%
              summarize(total_goals = sum(Away.Team.Goals)) %>%
              rename(country = Away.Team.Name)) %>%
  group_by(country) %>%
  summarize(total_goals = sum(total_goals)) %>%
  arrange(desc(total_goals)) %>%
  head(5)