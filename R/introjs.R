### rintrojs package
### written by Carl Ganz
### wrapper for the introjs javascript library written by Afshin Mehrabani

#' Initiate intro.js
#'
#' Iniates an introduction via the intro.js library
#' @import shiny
#' @param session the Shiny session object (from the server function of the Shiny app)
#' @param options List of options to be passed to introJs. See \url{https://github.com/usablica/intro.js/wiki/Documentation}
#' @param events List of text that are evaluated as javascript in the body of introJs events.
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

introjs <- function(session, options = list(), events = list()) {
  options <- list(options = options, events = events)
  session$sendCustomMessage(type = "introjs", message = options)
  
}

#' @rdname introjs
#' @export

hintjs <- function(session, options= list(), events = list()) {
  options <- list(options = options, events = events)
  session$sendCustomMessage(type = "hintjs", message = options)
  
}

#' @rdname introjs
#' @param includeOnly Only include introjs files. For users who will write their own javascript
#' @export

introjsUI <- function(includeOnly = FALSE) {
  
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
    if (!includeOnly) {
      shiny::includeScript(
        system.file(
          "javascript/rintro.js", package = "rintrojs"
        )
      )
    }
  )
  )
  )
}

#' Generate intro elements in UI
#'
#' Wrap \code{introBox} around elements you want to include in introduction.
#' Use data.step to order the boxes and data.intro to specify the comment in the introduction
#'
#' @param ... Elements in introduction element
#' @param data.step a number indicating its spot in the order in the intro
#' @param data.intro text for introduction
#' @param data.hint text for clickable hints
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

introBox <- function(... ,data.step, data.intro, data.hint) {
  stopifnot(!((!missing(data.step) & missing(data.intro)) | (missing(data.step) & !missing(data.intro))))
  data <- match.call(expand.dots = TRUE)
  n <- length(list(...)) + 1
  names(data)[-seq_len(n)] <- gsub("\\.", "-", names(data)[-seq_len(n)])
  data[[1]] <- quote(shiny::tags$div)
  
  shiny::singleton(eval(data))
  
}


