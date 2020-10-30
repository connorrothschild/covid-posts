library(shiny)
library(dplyr)
library(purrr)
library(readr)
library(stringr)
library(magrittr)
library(reactable)

df <- readr::read_csv(here::here('data/oct29PostsData.csv')) %>%
    mutate(
        Date = lubridate::as_date(Date),
        GeoSpecific = ifelse(is.na(GeoSpecific), Geo, GeoSpecific),
        Country = ifelse(Country == 'United States of America', 'USA', Country),
        Author = str_replace(Author, ", NA", ""),
        Author = sub("(\\w+),\\s(\\w+)", "\\2 \\1", Author),
        Author = ifelse(Author == 'NA', NA, Author),
        CoreRole = ifelse(CoreRole == "NotForProfit", "Nonprofit", CoreRole),
        Role = str_replace(
            Role,
            'Actuary|Architect|Government|MacroStrategist|PhD Student|Public Health|Lawyer|Educator',
            'Other'
        ),
        Role = str_replace(Role,
                           'Post Grad',
                           'Post-Grad'),
        Topic = str_replace(Topic,
                            'CompSci',
                            'Computer Science'),
        Topic = str_replace(Topic,
                            'DataViz',
                            'Data Visualization')
    )

ui <- shinyUI(fluidPage(
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
 
    titlePanel(title = 'COVID-19 Blog Post Directory',
               windowTitle = 'COVID-19 Blog Post Directory'),
    
    fluidRow(
        column(
            3,
            div(h4(
                'A collection of posts by the #rstats community'
            )),
            br(),
            tabsetPanel(
                type = "tabs",
                tabPanel(
                    "Author Info",
                    br(),
                    selectInput(
                        inputId = 'Role',
                        label = 'Filter by Job Role',
                        choices = c("All", sort(df$Role[!is.na(df$Role)])),
                        selected = "All"
                    ),
                    selectInput(
                        inputId = 'CoreRole',
                        label = 'Filter by Place of Employment',
                        choices = c("All", sort(df$CoreRole[!is.na(df$CoreRole)])),
                        selected = "All"
                    )
                    ),
                tabPanel(
                    "Post Info",
                    br(),
                    selectInput(
                        inputId = 'Topic',
                        label = 'Filter by Topic',
                        choices = c("All", sort(df$Topic[!is.na(df$Topic)])),
                        selected = "All"
                    ),
                    selectInput(
                        inputId = 'GeoSpecific',
                        label = 'Filter by Country of Focus',
                        choices = c("All", sort(df$GeoSpecific[!is.na(df$GeoSpecific)])),
                        selected = "All"
                    )
                )
                ),
            dateRangeInput(
                "dateRange",
                "Filter by Date",
                start = min(df$Date) - 1,
                end   = max(df$Date) + 1,
                min   = min(df$Date) - 1,
                max   = max(df$Date) + 1
            ),
            
            htmlOutput('matchText'),
            br(),
            actionButton("resetInputs", "Remove all filters")
            
        ),
        column(
            9,
            p(
                HTML(
                paste0("You can further filter those ", 
                       textOutput("nrow", inline = TRUE), 
                       " posts below:")
                )
              ),
            conditionalPanel(condition = 'output.nrow != "0"',
                             reactableOutput("table")),
        )
    ),
    br(),
    hr(),
    fluidRow(
    column(12, 
    HTML(paste0(
    "<strong>Note:</strong> Although the #rstats community is intelligent, driven, and knowledgable,
                  not every member of the community is an expert when it comes to COVID-19.",
                br(),
                  "Engaging with these blog posts should be an opportunity to learn more and give feedback,
                  but we advise against using the content of blog posts to inform your approach to or
                  understanding of COVID-19.",
                  br(),
                  "For the most up-to-date and accurate information related to the Coronavirus, visit ",
                  tags$a(href = 'https://www.cdc.gov/', target = "_blank", 'cdc.gov'), "."
    ))))
))

server <- function(input, output, session) {
    
    inputIds <- c('CoreRole', 'Role', 'Topic', 'GeoSpecific')
    observeEvent(input$resetInputs, {
        for (id in inputIds) {
            updateSelectInput(session = session,
                              inputId = id,
                              selected = 'All'
                              )
            updateDateRangeInput(session = session,
                                 inputId = 'dateRange',
                                 start = min(df$Date) - 1,
                                 end   = max(df$Date) + 1)
        }
    })
    
    chosen_dataset <- reactive({
        if (input$Role != "All") {
            df <- df %>%
                filter(Role == input$Role)
        }
        if (input$CoreRole != "All") {
            df <- df %>%
                filter(CoreRole == input$CoreRole)
        }
        if (input$GeoSpecific != "All") {
            df <- df %>%
                filter(GeoSpecific == input$GeoSpecific)
        }
        if (input$Topic != "All") {
            df <- df %>%
                filter(Topic == input$Topic)
        }
        
        df <- df %>%
            filter(Date > format(input$dateRange[1]) &
                       Date < format(input$dateRange[2]))
        
        df <- df %>%
            select(-c(
                LastName,
                Week,
                WeekYear,
                Geo,
            )) %>%
            select(Title, Author, Date, everything())
        return(df)
    })
    
    url_title_lookup <- df %>%
        select(URL, Title)
    
    sticky_style <-
        list(
            position = "sticky",
            left = 0,
            background = "#f5f5f5",
            zIndex = 1,
            borderRight = '1px solid white'
        )
    sticky_style_header <-
        list(
            position = "sticky",
            left = 0,
            background = "white",
            zIndex = 1,
            fontSize = '14px',
            borderRight = '1px solid white'
        )
    
    output$table <- renderReactable({
        reactable(
            chosen_dataset(),
            defaultSorted = 'Date',
            defaultSortOrder = 'desc',
            bordered = TRUE,
            pagination = FALSE,
            height = 500,
            searchable = TRUE,
            showSortIcon = FALSE,
            highlight = TRUE,
            compact = FALSE,
            theme = reactableTheme(
                backgroundColor = '#f5f5f5'
            ),
            language = reactableLang(
                searchPlaceholder = "Search for a post, author, or topic",
                noData = "No entries found",
                pageInfo = "{rowStart} to {rowEnd} of {rows} entries",
                pagePrevious = "\u276e",
                pageNext = "\u276f",
                
                # Accessible labels for assistive technologies such as screen readers.
                # These are already set by default, but don't forget to update them when
                # changing visible text.
                pagePreviousLabel = "Previous page",
                pageNextLabel = "Next page"
            ),
            defaultColDef = colDef(headerClass = "header",
                                   na = "–"),
            columns = list(
                URL = colDef(show = FALSE),
                Email = colDef(show = FALSE),
                Country = colDef(show = FALSE),
                GeoSpecific = colDef(name = 'Country'),
                Date = colDef(format = colFormat(date = TRUE)),
                Topic = colDef(minWidth = 110),
                Data = colDef(name = "Data?", width = 60),
                Code = colDef(name = "Code?", width = 60),
                Math = colDef(name = "Math?", width = 60),
                Author = colDef(minWidth = 150),
                Role = colDef(name = 'Job Role'),
                CoreRole = colDef(name = "Employment", minWidth = 120),
                Title = colDef(
                    name = "Post Title",
                    style = sticky_style,
                    headerStyle = sticky_style_header,
                    minWidth = 250,
                    cell = function(value, index) {
                        htmltools::tags$a(href = url_title_lookup[url_title_lookup$Title == value,]$URL,
                                          target = "_blank",
                                          value)
                    }
                )
            )
        )
    })
    
    # numMatch <- nrow(chosen_dataset())
    output$nrow <- renderText({nrow(chosen_dataset())})
    output$matchText <- renderUI({
        HTML(paste0("There are <strong>",
               nrow(chosen_dataset()),
               " posts</strong> that match your criteria."))
    })
}


shinyApp(ui, server)
