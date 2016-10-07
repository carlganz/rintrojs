library(shiny)
library(rintrojs)

shinyUI(fluidPage(
  introjsUI(),
  mainPanel(
    textInput("intro","Enter an introduction"),
    actionButton("btn","Press me")
  )
)
)