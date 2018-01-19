
fluidPage(
  
  titlePanel("Movies explorer"),

    comment <- renderPrint({ "On the left panel from the drop down menu titled “Which genre” you can select a movie genre (category) for instance “Action”" }),
     comment(),
     comment <- renderPrint({ "Then from the bottom drop down menu titled “Pick a movie”, you select a movie genre (category) for instance “Action”" }),
     comment(),
     comment <- renderPrint({ "The “Redraw graph” button, from the left panel, draws a curve under the “Budgets overtime” tab" }),
     comment(),
     comment <- renderPrint({ "The slider named “Year” on the left panel adjust the time range of the curve on the right panel" }),
     comment(),
     comment <- renderPrint({ "The “Movie picker” tab on right panel gives information about a specific movie." }),
     comment(),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("year", "Year", min = 1893, max = 2005,
                   value = c(1945, 2005), sep = ""),
       
       selectInput("genre", "Which genre?", 
                   c("Action", "Animation", "Comedy", "Drama", 
                     "Documentary", "Romance", "Short")),
       uiOutput("listMovies"),
       actionButton("actionButton", "Redraw graph")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Budgets over time", plotOutput("budgetYear")),
       
        tabPanel("Movie picker", tableOutput("moviePicker"))
      )
    )
  )
)
