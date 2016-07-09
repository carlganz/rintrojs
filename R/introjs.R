#' Initiate intro.js
#'
#' Iniates an introduction via the intro.js library
#'
#' @import shiny
#' @param session session
#' @note \code{introjsUI} must be present in UI for \code{introjs} to work.
#'  Also requires their to be \code{introBox} in UI.
#' @seealso \code{introBox}
#' @export

introjs <- function(session) {
  session$sendCustomMessage(type = "introjs", message = list(NULL))

}

#' @rdname introjs
#' @export

introjsUI <- function() {
  tags$head(singleton(tagList(
    includeScript(
      system.file("javascript/introjs/intro.min.js", package = "rintrojs")
    ),
    includeCSS(
      system.file(
        "javascript/introjs/introjs.min.css",
        package = "rintrojs"
      )
    ),
    tags$script(
      HTML(
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
#'
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
