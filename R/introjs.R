# Copyright (C) 2016 Carl Ganz
#
# This file is part of rintrojs.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#' Initiate intro.js
#'
#' Initiates an introduction via the intro.js library
#' @import shiny
#' @importFrom jsonlite toJSON
#' @param session the Shiny session object (from the server function of the Shiny app)
#' @param options List of options to be passed to intro.js
#' @param events List of text that are the body of a Javascript function. Must wrap in [I()]
#' @note For documentation on intro.js options and events, see \url{https://github.com/usablica/intro.js/wiki/Documentation}.
#' @seealso [introjsUI()] [introBox()]
#' @examples
#' \dontrun{
#' library(rintrojs)
#' library(shiny)
#' ui <- shinyUI(fluidPage(
#'   introjsUI(), # must include in UI
#'   mainPanel(
#'     introBox(
#'       tableOutput("mtcars"),
#'       data.step = 1,
#'       data.intro = "This is the table"
#'     ),
#'     introBox(
#'       actionButton("btn","Intro"),
#'       data.step = 2,
#'       data.intro = "This is the button",
#'       data.hint = "Here is clue"
#'     )
#'   )))
#' server <- shinyServer(function(input, output, session) {
#' 
#'  hintjs(session, options = list("hintButtonLabel"="That was a hint"))
#' 
#'   output$mtcars <- renderTable({
#'     head(mtcars)
#'   })
#'   observeEvent(input$btn,
#'                introjs(session, options = list("nextLabel"="Onwards and Upwards"),
#'                                 events = list("oncomplete"='alert("It is over")')))
#' })
#' # Run the application
#' shinyApp(ui = ui, server = server)
#' }
#' @export

introjs <- function(session, options = list(), events = list()) {
  options <- list(options = options, events = events)
  session$sendCustomMessage(type = "introjs", 
                            message = jsonlite::toJSON(options, 
                                                       auto_unbox = TRUE))
  
}

#' @rdname introjs
#' @export

hintjs <- function(session, options= list(), events = list()) {
  options <- list(options = options, events = events)
  session$sendCustomMessage(type = "hintjs", message = jsonlite::toJSON(options))
  
}

#' Set up Shiny app to use intro.js
#' 
#' This function must be called from a Shiny app's UI in order
#' to use the package.
#' 
#' @param includeOnly Only include intro.js files. For users who will write their own javascript
#' @param cdn Indicate whether to include intro.js files from CDN
#' @export
#' @examples 
#' \dontrun{
#' library(rintrojs)
#' library(shiny)
#' 
#' shinyApp(
#' ui = fluidPage(
#'   introjsUI(), # must include in UI
#'   actionButton("btn", "Click me")
#' ),
#' server = function(input, output, session) {
#'   observeEvent(input$btn, {
#'     intro <- data.frame(element="#btn",
#'                         intro="In Codd we trust")
#'     introjs(session, options = list(steps= intro))
#'   })
#' }
#' )
#' }

introjsUI <- function(includeOnly = FALSE, cdn = FALSE) {
  
  shiny::tags$head(shiny::singleton(shiny::tagList(
    shiny::includeScript(
      if (cdn) {
        "https://cdn.jsdelivr.net/intro.js/2.5.0/intro.min.js"
      } else {
        system.file("javascript/introjs/intro.min.js", package = "rintrojs")
      }
    ),
    shiny::includeCSS(
      if (cdn) {
        "https://cdn.jsdelivr.net/intro.js/2.5.0/intro.min.css"
      } else {
        system.file(
          "javascript/introjs/introjs.min.css",
          package = "rintrojs"
        )
      }
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
#' Wrap `introBox` around elements you want to include in introduction.
#' Use data.step to order the boxes and data.intro to specify the comment in the introduction
#'
#' @param ... Elements in introduction element
#' @param data.step a number indicating its spot in the order in the intro
#' @param data.intro text for introduction
#' @param data.hint text for clickable hints
#' @seealso [introjsUI()] [introjs()]
#' @examples
#' \dontrun{
#' library(rintrojs)
#' library(shiny)
#' ui <- shinyUI(fluidPage(
#'   introjsUI(), # must include in UI
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
  # http://stackoverflow.com/a/40180906/4564432
  shiny::singleton(eval.parent(data))
  
}


