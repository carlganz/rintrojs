
[![JOSS
Status](https://joss.theoj.org/papers/10.21105/joss.00063/status.svg)](https://dx.doi.org/10.21105/joss.00063)[![Project
Status:
Active.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R-CMD-check](https://github.com/carlganz/rintrojs/workflows/R-CMD-check/badge.svg)](https://github.com/carlganz/rintrojs/actions)[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rintrojs)](https://cran.r-project.org/package=rintrojs)[![Licence](https://img.shields.io/badge/licence-AGPL--3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0.en.html)[![minimal
R
version](https://img.shields.io/badge/R%3E%3D-3.0.0-6666ff.svg)](https://cran.r-project.org/)

# rintrojs

[R](https://www.r-project.org/) was originally developed with the name S
in the 70’s as a glue language. Statisticians at Bell Labs needed an
interactive environment for working with their C and Fortran scripts.
Decades later, R is still a glue language, except instead of C and
Fortran, it brings together C++, and JavaScript. With the advent of the
[Shiny](https://shiny.posit.co/) package, R is now a popular platform
for developing data-driven web applications. As Shiny increases in
popularity so will the complexity of the Shiny apps built. In many
instances, new-users will require guidance when they first use a Shiny
application.

Luckily, there is already a well established JavaScript library for this
purpose. [Intro.js](https://introjs.com/), written by Afshin Mehrabani,
is a JavaScript library that helps integrate step-by-step introductions,
and clickable hints into websites. The `rintrojs` R package integrates
Intro.js into Shiny, so that users can easily add instructions to their
application without having to use HTML, CSS, or JavaScript.

## Install

`rintrojs` is available on CRAN:

``` r
install.packages("rintrojs")
```

To access the bleeding-edge version, use `devtools` to install
`rintrojs` from github:

``` r
devtools::install_github("carlganz/rintrojs")
```

## Usage

To use `rintrojs`, you need to call `introjsUI()` once in the UI.
`rintrojs` supports both static and programmatic introductions meaning
you can either wrap the elements you want to introduce with `introBox`,
or dynamically generate your introduction using the `steps` option (see
[the Intro.js
documentaion](https://github.com/usablica/intro.js/wiki/Documentation)).
You specify the order of the introduction with the data.step parameter,
and you specify the content of the introduction with the data.intro
parameter. You can initiate the introduction from the server by calling
`introjs(session)`. You can also specify options, and pass text as the
body of javascript events associated with `Intro.js`.

Here is an example with a static introduction, but with options, and
events used.

``` r
library(rintrojs)
library(shiny)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  introjsUI(),
  
  # Application title
  introBox(
    titlePanel("Old Faithful Geyser Data"),
    data.step = 1,
    data.intro = "This is the title panel"
  ),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(sidebarPanel(
    introBox(
      introBox(
        sliderInput(
          "bins",
          "Number of bins:",
          min = 1,
          max = 50,
          value = 30
        ),
        data.step = 3,
        data.intro = "This is a slider",
        data.hint = "You can slide me"
      ),
      introBox(
        actionButton("help", "Press for instructions"),
        data.step = 4,
        data.intro = "This is a button",
        data.hint = "You can press me"
      ),
      data.step = 2,
      data.intro = "This is the sidebar. Look how intro elements can nest"
    )
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    introBox(
      plotOutput("distPlot"),
      data.step = 5,
      data.intro = "This is the main plot"
    )
  ))
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, session) {
  # initiate hints on startup with custom button and event
  hintjs(session, options = list("hintButtonLabel"="Hope this hint was helpful"),
         events = list("onhintclose"=I('alert("Wasn\'t that hint helpful")')))
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x,
         breaks = bins,
         col = 'darkgray',
         border = 'white')
  })
  
  # start introjs when button is pressed with custom options and events
  observeEvent(input$help,
               introjs(session, options = list("nextLabel"="Onwards and Upwards",
                                               "prevLabel"="Did you forget something?",
                                               "skipLabel"="Don't be a quitter"),
                                events = list("oncomplete"=I('alert("Glad that is over")')))
  )
})

# Run the application
shinyApp(ui = ui, server = server)
```

You can also generate introductions dynamically.

``` r
library(shiny)
library(rintrojs)

ui <- shinyUI(fluidPage(
      introjsUI(),
      mainPanel(
        textInput("intro","Enter an introduction"),
         actionButton("btn","Press me")
      )
   )
)

server <- shinyServer(function(input, output, session) {
   
  steps <- reactive(data.frame(element = c(NA,"#btn"),
                               intro = c(input$intro,"This is a button")))
  
  observeEvent(input$btn,{
    introjs(session,options = list(steps=steps()))
    
  })
  
})

# Run the application 
shinyApp(ui = ui, server = server)
```

Click [here to view
example.](https://carlganz.shinyapps.io/rintrojsexample/)

## Contributing

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/carlganz/rintrojs/blob/master/CONDUCT.md).
By participating in this project you agree to abide by its terms.

If you find any problems or have any questions, please feel free to file
an issue.

## Contributors ✨

Thanks goes to these wonderful people ([emoji
key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
<tr>
<td align="center">
<a href="https://www.carlganz.com"><b>Carl Ganz</b></a><br />
</td>
<td align="center">
<a href="https://github.com/afshinm"><b>Afshin Mehrabani</b></a><br />
</td>
<td align="center">
<a href="https://github.com/etiennebacher"><b>Etienne
Bacher</b></a><br />
</td>
<td align="center">
<a href="https://github.com/mvanbommel"><b>Matthew van
Bommel</b></a><br />
</td>
<td align="center">
<a href="https://github.com/crew102"><b> Chris Baker</b></a><br />
</td>
</tr>
</table>
<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the
[all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!
