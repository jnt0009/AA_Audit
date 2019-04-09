library(shiny)
shinyUI(fluidPage(
  # Application title
  titlePanel("AA_Audit"),
  sidebarLayout(
    sidebarPanel(
      textInput("uw","Web Services Username"),
      textInput("pw","Shared Secret"),
      actionButton("first","Authenticate"),
      actionButton("second","Fetch Settings"),
      uiOutput("rsid"),
      tags$br(),
      tags$br(),
      downloadLink('downloadData', 'Download')
    ),
  mainPanel(
    tabsetPanel(
      tabPanel("Instructions",uiOutput("inst")),
      tabPanel("props",dataTableOutput("prop")),
      tabPanel("eVars",dataTableOutput("evar")),
      tabPanel("events",dataTableOutput("event")),
      tabPanel("metric",dataTableOutput("metric")),
      tabPanel("elements",dataTableOutput("element"))
    )
    
    
  )
  )

  
))
