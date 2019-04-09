library(shiny)
shinyUI(fluidPage(
  # Application title
  titlePanel("TBD"),
  sidebarLayout(
    sidebarPanel(
      textInput("uw","UsernameWeb Services Username"),
      textInput("pw","Shared Secret"),
      actionButton("first","Authenticate"),
      actionButton("second","Fetch Settings"),
      uiOutput("rsid"),
      tags$br(),
      tags$br(),
      downloadLink('downloadData', 'Download')
    ),
  mainPanel(
    tags$div("center"),
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
