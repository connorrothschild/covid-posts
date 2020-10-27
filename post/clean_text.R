# textDF.Data$data <- stringr::str_trim(string = textDF.Data$data, side = "both")
textDF.Data$data <- str_squish(string = textDF.Data$data)

textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "ACAPS$", replacement = "Assessment Capacities Project (ACAPS)")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "Apple Mobility Data", replacement = "Apple Mobility")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Apple.*$", replacement = "Apple Mobility")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Assessment.*$", replacement = "Assessment Capacities Project (ACAPS)")
textDF.Data$data <-
  ifelse(
    str_detect(textDF.Data$data, pattern = "Labor Statistics"),
    "U.S. Bureau of Labor Statistics",
    textDF.Data$data
  )
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "corona virus package", replacement = "coronavirus package")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Covid Tracking.*$", replacement = "COVID Tracking Project")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "covidtracking.com", replacement = "COVID Tracking Project")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "COVID Tracking project", replacement = "COVID Tracking Project")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "COVID-19 package",
              replacement = "COVID-19 package")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "COVID-19R",
              replacement = "COVID-19 package")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "Centers",
              replacement = "Centre")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "data.gouv.fr/fr/datasets/
",
              replacement = "data.gouv.fr")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "gouv.fr",
              replacement = "data.gouv.fr")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^European Centre.*$", replacement = "European Centre for Disease Control (ECDC)")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "European Center for Disease Control", replacement = "European Centre for Disease Control (ECDC)")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^ECDC.*$", replacement = "European Centre for Disease Control (ECDC)")
textDF.Data$data <- str_replace(
  textDF.Data$data,
  pattern = "
European Centre for Disease Control (ECDC) (ECDC)",
  replacement = "European Centre for Disease Control (ECDC)"
)
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "french site data.data.gouv.fr",
              replacement = "data.gouv.fr")
textDF.Data$data <-
  str_remove(textDF.Data$data, pattern = "Geocodes from ")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Google Mob.*$", replacement = "Google Mobility")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "Google mobility", replacement = "Google Mobility")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = 'Google \\"COVID-19 Community Mobility Reports\\"', replacement = "Google Mobility")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Hopkins.*$", replacement = "Johns Hopkins Univ.")
textDF.Data$data <-
  str_remove(string = textDF.Data$data, pattern = "https\\:")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Human Mortality.*$", replacement = "Human Mortality Database")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "I n stituto", replacement = "Instituto")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Japan National.*$", replacement = "Japan National Land Numeric Information")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "Johns Hopkins$", replacement = "Johns Hopkins Univ.")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "microsimulation", replacement = "Simulation")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^Mobility Trends.*$", replacement = "Apple Mobility")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^New York T.*$", replacement = "New York Times")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "Not sourced", replacement = "No data")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "Opentable",
              replacement = "OpenTable")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "our world in data",
              replacement = "Our World in Data")
textDF.Data$data <-
  str_remove(string = textDF.Data$data, pattern = "regression, log-linear")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "^The Guard.*$", replacement = "The Guardian (Australia)")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "the united states project",
              replacement = "United States Project")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "simulation", replacement = "Simulation")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "S imulation", replacement = "Simulation")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "T ennessee", replacement = "Tennessee")
textDF.Data$data <-
  str_replace(textDF.Data$data, pattern = "U nited S tates P roject", replacement = "United States Project")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "US Census",
              replacement = "U.S. Census Bureau")
textDF.Data$data <-
  ifelse(
    str_detect(textDF.Data$data, pattern = "Census"),
    "U.S. Census Bureau",
    textDF.Data$data
  )
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "Wikipedia: Case statistics\\)",
              replacement = "Wikipedia")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "Wikipeida",
              replacement = "Wikipedia")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "W ikipeida",
              replacement = "Wikipedia")
textDF.Data$data <-
  ifelse(str_detect(textDF.Data$data, pattern = "Wikipedia"),
         "Wikipedia",
         textDF.Data$data)
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "W ikipedia",
              replacement = "Wikipedia")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "US Census Bureau",
              replacement = "U.S. Census Bureau")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "Worldbank",
              replacement = "World Bank")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "WorldBank",
              replacement = "World Bank")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "World o meters",
              replacement = "Worldometers")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "W orldometers",
              replacement = "Worldometers")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "^World Pop.*$",
              replacement = "World Population Review (WPR)")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "WorldPop",
              replacement = "World Population Review (WPR)")
textDF.Data$data <-
  str_replace(string = textDF.Data$data,
              pattern = "www.insee.fr",
              replacement = "INSEE")
textDF.Data$data <-
  str_remove(string = textDF.Data$data, pattern = "www\\.")
