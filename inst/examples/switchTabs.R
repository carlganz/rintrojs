library(shiny)
library(rintrojs)

# Example adapted from https://shiny.rstudio.com/articles/tabsets.html
ui <- fluidPage(
  introjsUI(),
  titlePanel("Tabsets"),
  sidebarLayout(
    sidebarPanel(
      introBox(
        radioButtons(
          "dist", "Distribution type:",
          c(
            "Normal" = "norm",
            "Uniform" = "unif",
            "Log-normal" = "lnorm",
            "Exponential" = "exp"
          )
        ),
        data.step = 1,
        data.intro = "This is an input"
      ),
      br(),
      introBox(
        sliderInput(
          "n",
          "Number of observations:",
          value = 500,
          min = 1,
          max = 1000
        ),
        data.step = 2,
        data.intro = "And so is this"
      )
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel(
          "Histogram",
          introBox(
            plotOutput("histogram"),
            data.step = 3,
            data.intro = "Took a look at this histogram"
          )
        ),
        tabPanel(
          "Boxplot", 
          introBox(
            plotOutput("boxplot"),
            data.step = 4,
            data.intro = "And this handsome boxplot.<br><br>See how the active tab
            switched from 'Histogram' to 'Boxplot' before moving to this step?"
          )
        ),
        tabPanel(
          "Summary",
          tags$br(),
          tabsetPanel(
            tabPanel("Summary sub-tab 1", HTML("<br>Pretty boring tab, right?")),
            tabPanel(
              "Summary sub-tab 2",
              introBox(
                verbatimTextOutput("summary"),
                data.step = 5,
                data.intro = "There it goes again..."
              )
            )
          )
        )
      )
    )
  )
)

server <- shinyServer(function(input, output, session) {
  
  d <- reactive({
    dist <- switch(input$dist,
      norm = rnorm,
      unif = runif,
      lnorm = rlnorm,
      exp = rexp,
      rnorm
    )
    dist(input$n)
  })

  output$histogram <- renderPlot({
    dist <- input$dist
    n <- input$n

    hist(
      d(),
      main = paste("r", dist, "(", n, ")", sep = ""),
      col = "#75AADB", border = "white"
    )
  })
  
  output$boxplot <- renderPlot({
    dist <- input$dist
    n <- input$n

    boxplot(
      d(),
      main = paste("r", dist, "(", n, ")", sep = ""),
      col = "#75AADB", border = "white"
    )
  })
  
  output$summary <- renderPrint({
    summary(d())
  })
  
  introjs(session, events = list(onbeforechange = readCallback("switchTabs")))
})

shinyApp(ui, server)