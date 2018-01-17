
library(ggplot2movies)
library(tidyverse)
library(scales)
library(rlang)

function(input, output) {
  
  moviesSubset = reactive({
    
    movies %>% filter(year %in% seq(input$year[1], input$year[2]), 
                      UQ(sym(input$genre)) == 1)
    
  })
  
  rawDebounceTitle = reactive({
    
    input$debounceTitle
  })
  
  rawThrottleTitle = reactive({
    
    input$throttleTitle
  })
  
 
  
  output$budgetYear = renderPlot({
    
    withProgress(message = "Please wait",
                 detail = "Running...", {
                   Sys.sleep(1)
                   setProgress(1/3, detail = "Querying API")
                   
                   # take dependency on action button
                   
                   input$actionButton
                   
                   Sys.sleep(1)
                   incProgress(1/3, detail = "Building graph")
                   
                   budgetByYear = summarise(group_by(moviesSubset(), year), 
                                            m = mean(budget, na.rm = TRUE))
                   
                   Sys.sleep(1)
                   incProgress(1/3, detail = "Displaying")
                   
                   ggplot(budgetByYear[complete.cases(budgetByYear), ], 
                          aes(x = year, y = m)) + 
                     geom_line() + 
                     scale_y_continuous(labels = scales::comma) + 
                     geom_smooth(method = "loess")  
                

                 }
    )
  })
  
  output$debounceGraph = renderPlot({
    
    withProgress(message = "Please wait",
                 detail = "Fetching graph", value = 0, {
                   Sys.sleep(1)
                   incProgress(1/3, message = "Querying API")
                   
                   Sys.sleep(1)
                   incProgress(1/3, message = "Building graph")
                   
                   budgetByYear = summarise(group_by(moviesSubset(), year), 
                                            m = mean(budget, na.rm = TRUE))
                   
                   Sys.sleep(1)
                   incProgress(1/3, message = "Displaying")
                   
                   ggplot(budgetByYear[complete.cases(budgetByYear), ], 
                          aes(x = year, y = m)) + 
                     geom_line() + 
                     scale_y_continuous(labels = scales::comma) + 
                     geom_smooth(method = "loess")  
                     
                   
                 }
    )
  })

  output$listMovies = renderUI({
    
    selectInput("pickMovie", "Pick a movie", 
                choices = moviesSubset() %>% 
                  sample_n(10) %>%
                  select(title)
    )
  })
  
  output$moviePicker = renderTable({
    
    filter(moviesSubset(), title == input$pickMovie)
    
  })
  
}
