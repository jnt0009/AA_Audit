library(shiny)
library(RSiteCatalyst)
library(googlesheets)
library(dplyr)
library(xlsx)
shinyServer(function(input, output,session) {
  
  auth <- eventReactive(input$first,{
    
    SCAuth(input$uw, input$pw)
    GetReportSuites()
  })
  props <- eventReactive(input$second,{
    req(auth())
    #print(auth())
    opt <- auth()
    selected <- match(input$reportSuite,opt$site_title)
    pr <- GetProps(opt[selected,1]) %>% as.data.frame()
    pr
  })
  eVars <- eventReactive(input$second,{
    req(auth())
    #print(auth())
    opt <- auth()
    selected <- match(input$reportSuite,opt$site_title)
    pr <- GetEvars(opt[selected,1]) %>% as.data.frame()
    pr[,-9]
  })
  events <- eventReactive(input$second,{
    req(auth())
    #print(auth())
    opt <- auth()
    selected <- match(input$reportSuite,opt$site_title)
    pr <- GetSuccessEvents(opt[selected,1]) %>% as.data.frame()
    pr
  })
  metrics <- eventReactive(input$second,{
    req(auth())
    #print(auth())
    opt <- auth()
    selected <- match(input$reportSuite,opt$site_title)
    pr <- GetMetrics(opt[selected,1]) %>% as.data.frame()
    pr
  })
  elements <- eventReactive(input$second,{
    req(auth())
    #print(auth())
    opt <- auth()
    selected <- match(input$reportSuite,opt$site_title)
    pr <- GetElements(opt[selected,1]) %>% as.data.frame()
    pr
  })
 
  output$rsid <- renderUI({
    req(auth())
    tagList(
      selectInput('reportSuite','Choose Report Suite',
                  choices = auth()[2],
                  ##list('Viewer','Multi Download','Audit') one day all of these will work
                  selected = NULL
      )) ## ouputs a dropdown for accounts
  })
  
  output$inst <- renderUI({
    tagList(
      tags$p("This tool allows you to view and download an Adobe Analytics instance"),
      tags$p("If you don't have your Web Services Username and shared secret head over to Adobe Analytics > Admin > Webservices"),
      tags$p("This is site is built using the RSiteCatalyst and maintained by Jamarius Taylor"),
      tags$a(href = "https://randyzwitch.com/rsitecatalyst/","RSiteCatalyst"),
      tags$a(href = "https://github.com/jnt0009/AA_Audit/", "Github")
    )
  })
  
  output$prop <- renderDataTable({
    req(auth)
    props()
  })
  output$evar <- renderDataTable({
    req(auth)
    eVars()
  })
  output$event <- renderDataTable({
    req(auth)
    events()
  })
  output$metric <- renderDataTable({
    req(auth)
    metrics()
  })
  output$element <- renderDataTable({
    req(auth)
    elements()
  })
  
  ## Download Functions ##
  output$downloadData <- downloadHandler(
    filename = "AA_Audit.xlsx",
    content = function(file) {
      write.xlsx(props(), file,sheetName = "props")
      write.xlsx(eVars(), file,sheetName = "eVars",append = TRUE)
      write.xlsx(events(), file, sheetName = "events",append = TRUE)
      write.xlsx(metrics(), file, sheetName = "metrics",append = TRUE)
      write.xlsx(elements(), file, sheetName = "elements",append = TRUE)
    }
  )
  
})


#rsconnect::deployApp("C:/Users/Jamarius Taylor/Desktop/Rshiny apps/AA_Audit",appTitle="AA_Audit")
