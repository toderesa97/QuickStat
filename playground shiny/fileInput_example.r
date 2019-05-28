library(shiny)

ui <- fluidPage(
  fileInput("csv_input", "Choose a CSV", accept = c(
    "text/csv",
    "text/comma-separated-values,text/plain",
    ".csv")
  ),
  tags$hr(),
  checkboxInput("header", "Header", TRUE),
	mainPanel(
	  tableOutput("csv_content")
	)
)

server <- function(input, output) {
  output$csv_content <- renderTable(
    {
      inFile <- input$csv_input
      
      if (is.null(inFile))
        return(NULL)
      
      read.csv(inFile$datapath, header=input$header)
    }
  )
}

shinyApp(ui = ui, server = server)