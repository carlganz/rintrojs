#' Initiate intro.js
#'
#' Iniates an introduction via the intro.js library
#' @import shiny
#' @param session the Shiny session object (from the server function of the Shiny app)
#' @note \code{introjsUI} must be present in UI for \code{introjs} to work.
#'  Also requires their to be \code{introBox} in UI.
#' @seealso \code{introBox}
#' @examples
#' \dontrun{
#' library(rintrojs)
#' library(shiny)
#' ui <- shinyUI(fluidPage(
#'   introjsUI(),
#'   mainPanel(
#'     introBox(
#'       tableOutput("mtcars"),
#'       data.step = 1,
#'       data.intro = "This is the table"
#'     ),
#'     introBox(
#'       actionButton("btn","Intro"),
#'       data.step = 2,
#'       data.intro = "This is the button"
#'     )
#'   )))
#' server <- shinyServer(function(input, output, session) {
#'   output$mtcars <- renderTable({
#'     head(mtcars)
#'   })
#'   observeEvent(input$btn,
#'                introjs(session))
#' })
#' # Run the application
#' shinyApp(ui = ui, server = server)
#' }
#' @export

introjs <- function(session) {
  session$sendCustomMessage(type = "introjs", message = list(NULL))

}

#' @rdname introjs
#' @export

introjsUI <- function() {
  shiny::tags$head(shiny::singleton(shiny::tagList(
    shiny::includeScript(
      system.file("javascript/introjs/intro.min.js", package = "rintrojs")
    ),
    shiny::includeCSS(
      system.file(
        "javascript/introjs/introjs.min.css",
        package = "rintrojs"
      )
    ),
    shiny::tags$script(
      shiny::HTML(
        "Shiny.addCustomMessageHandler('introjs',function(NULL) {
        introJs().start();
} )"
                )
    )
      )))
}

#' Generate intro elements in UI
#'
#' Wrap \code{introBox} around elements you want to include in introduction.
#' Use data.step to order the boxes and data.intro to specify the comment in the introduction
#'
#' @param ... Elements in introduction element
#' @param data.step a number indicating its spot in the order in the intro
#' @param data.intro text for introduction
#' @seealso \code{introjs}
#' @examples
#' \dontrun{
#' library(rintrojs)
#' library(shiny)
#' ui <- shinyUI(fluidPage(
#'   introjsUI(),
#'   mainPanel(
#'     introBox(
#'       tableOutput("mtcars"),
#'       data.step = 1,
#'       data.intro = "This is the table"
#'     ),
#'     introBox(
#'       actionButton("btn","Intro"),
#'       data.step = 2,
#'       data.intro = "This is the button"
#'     )
#'   )))
#' server <- shinyServer(function(input, output, session) {
#'   output$mtcars <- renderTable({
#'     head(mtcars)
#'   })
#'   observeEvent(input$btn,
#'                introjs(session))
#' })
#' # Run the application
#' shinyApp(ui = ui, server = server)
#' }
#' @export

introBox <- function(... , data.step, data.intro) {
  shiny::singleton(shiny::tags$div(..., `data-step` = data.step, `data-intro` =
                                     data.intro))
}


# DT::datatable(mtcars,options=list(rowCallback=JS(
#   'function(row,data,index) {
#   row.setAttribute("data-step",index);
#   row.setAttribute("data-intro", "This is row "+index)
#   }'
#   )))
