# Loading the necessary packages
library(XML)
library(httr)

# This code pull the table with id games into R as a dataframe called games
theurl <- "https://www.hockey-reference.com/leagues/NHL_2018_games.html"
doc <- htmlParse(GET(theurl, user_agent("Mozilla")))
games <- xpathSApply(doc, "//*/table[@id='games']")
games <- readHTMLTable(games[[1]],stringsAsFactors = FALSE)
rm(doc)
colnames(games)[5] <- "G2"

# This code subsets the game results where one team scored 0 goals and counts the number of times
# each team appears
shutouts <- subset(games, subset = (games$G == "0" | games$G2 == "0"))
SOTeams <- c(shutouts[which(shutouts$G == "0"), "Visitor"], shutouts[which(shutouts$G2 == "0"), "Home"])
table(SOTeams)

# This defines each teams fullname with its associated acronym 
teamdf <- data.frame("FullName" =  c("Anaheim Ducks","Arizona Coyotes","Boston Bruins",
                                     "Buffalo Sabres","Calgary Flames","Carolina Hurricanes",
                                     "Chicago Blackhawks","Colorado Avalanche","Columbus Blue Jackets",
                                     "Dallas Stars","Detroit Red Wings","Edmonton Oilers",
                                     "Florida Panthers","Los Angeles Kings","Minnesota Wild",
                                     "Montreal Canadiens","Nashville Predators","New Jersey Devils",
                                     "New York Islanders","New York Rangers","Ottawa Senators",
                                     "Philadelphia Flyers","Pittsburgh Penguins","San Jose Sharks",
                                     "St. Louis Blues","Tampa Bay Lightning","Toronto Maple Leafs",
                                     "Vancouver Canucks","Vegas Golden Knights","Washington Capitals",
                                     "Winnipeg Jets"), 
                     "Acronym" = c("ANA","ARI","BOS","BUF","CGY","CAR","CHI","COL","CBJ","DAL","DET","EDM",
                                   "FLA","LAK","MIN","MTL","NSH","NJD","NYI","NYR","OTT","PHI","PIT","SJS",
                                   "STL","TBL","TOR","VAN","VEG","WSH","WPG"))

# Adding columns for the starting home and away goalies
games$HomeGoalie <- rep("", times = nrow(games))
games$AwayGoalie <- rep("", times = nrow(games))

# This code scraps the starting goalies for the home and away team for each game
for (i in 1:nrow(games)){
  gamesUrl <- paste0("https://www.hockey-reference.com/boxscores/", gsub("-", "", games[i,"Date"]), "0", teamdf[teamdf$FullName == games[i,"Home"], "Acronym"], ".html")
  doc <- htmlParse(GET(gamesUrl, user_agent("Mozilla")))
  homeGoalie <- xpathSApply(doc, paste0("//*/table[@id='",teamdf[teamdf$FullName == games[i,"Visitor"], "Acronym"],"_goalies']"))
  homeGoalie <- readHTMLTable(homeGoalie[[1]],stringsAsFactors = FALSE)$Player
  games$HomeGoalie[i] <- homeGoalie
  awayGoalie <- xpathSApply(doc, paste0("//*/table[@id='",teamdf[teamdf$FullName == games[i,"Home"], "Acronym"],"_goalies']"))
  awayGoalie <- readHTMLTable(awayGoalie[[1]],stringsAsFactors = FALSE)$Player
  games$AwayGoalie[i] <- awayGoalie
  rm(doc)
}


