library(shiny)
library(pracma)
options(scipen=999)
ui = fluidPage(
        fluidRow(
                  column(12,htmlOutput("header")),
                  column(12,plotOutput("plot")),
                  column(4,downloadButton("save_data", "Save Data")),
                  column(4,fileInput("old_filename", label = h3("File input"))),
                  column(4,numericInput("cutoff", label = h3("Peak Cutoff"),value=1)),
                  column(12,plotOutput("old_plot")),
                  column(12,verbatimTextOutput("statistics"))
                  #column(12,mainPanel(verbatimTextOutput("old_text")))

                )
              )
      
server = function(input, output, session) 
{
  
    output$header=renderText("<H1 class='text-success'>HPLC Graph viewer</H1>")
    
    # mydata is a function
    mydata <- reactiveFileReader(1000, session, '/tmp/data.csv', read.csv)
    
    #function defined within a function
    save_function= function(file) {
      data=mydata()
      write.csv(data, file)
    }
    
    filename_function=function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    }
    
    
    statistics_function=function()
    {
      old_data=read.csv(file=input$old_filename$datapath,sep=",")
      #old_data
      aa_equation=smooth.spline(old_data$time,old_data$value,spar=0)
      peaks=findpeaks(aa_equation$y)
      print(paste("Peaks Data"))
      #peaks
      peaks[peaks[,1]>input$cutoff,]

    }
    
    #data <- read.csv("/tmp/data.csv")
    output$plot <- renderPlot(
                                {
                                  data=mydata()
                                  plot(data$time,data$value,type="l")
                                }
                              )
    output$save_data <- downloadHandler(filename=filename_function,content=save_function) 
   
   
    output$old_plot <- renderPlot(
                                {
                                  old_data=read.csv(file=input$old_filename$datapath,sep=",")
                                  #old_data=read.csv("/tmp/data.csv")
                                  plot(old_data$time,old_data$value,type="l")
                                }
                              )


    output$statistics=renderPrint(statistics_function())
                              
    #output$old_text <- renderPrint({
    #str(input$old_filename$datapath)
    #str(input$old_filename)
    #old_data=read.csv(file=input$old_filename['datapath'],sep=",")
    #old_data
    #})                           
}

shinyApp(ui = ui, server = server)
