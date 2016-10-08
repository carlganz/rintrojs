context("Test server side introduction")
library(shinytest)

app <- shinytest::shinyapp$new("apps/app1")

test_that("introjs doesn't auto start on initialization",{
  expect_error(app$find_element(".introjs-tooltiptext"))
})

# set value in text box
intro <- "In Codd we trust"
app$find_element("#intro")$set_value(intro)

app$find_element("#btn")$click()

test_that("Server side introduction works", {
  expect_equal(app$find_element(".introjs-tooltiptext")$get_text(), intro)
})



app$stop()
