library("dplyr")
library("stringr")

# Store the dataframes
wc_df <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-sws0713/main/WorldCups.csv")
matches_df <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-sws0713/main/WorldCupMatches.csv")

# What is the country with the most World Cups won?
winners_table <- wc_df %>%
  group_by(Winner) %>%
  summarize(number_of_cups = n()) %>%
  arrange(desc(number_of_cups)) %>%
  head(1)

# What is the country that has hosted the World Cup the most?
hosts_table <- wc_df %>%
  group_by(Country) %>%
  summarize(number_hosted = n()) %>%
  arrange(desc(number_hosted)) 

# What is the host country with the highest attendance?
attendance_table <- wc_df %>%
  select(Year, Country, Attendance) %>%
  mutate(Attendance = as.numeric(gsub("\\.", "", Attendance))) %>%
  arrange(desc(Attendance)) %>%
  head(5)

# What is the country with the highest number of goals scored?
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
  head(1)