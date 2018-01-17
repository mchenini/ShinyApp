
fluidPage(
  
  titlePanel("Movies explorer"),
  
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
