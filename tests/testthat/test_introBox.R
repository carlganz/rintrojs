context("Test introBox")
library(rintrojs)
library(testthat)
library(shiny)

target <- tags$div(
    actionButton("one","one"),
    actionButton("two","two"),
    `data-step` = 1,
    `data-intro` = "This is step one")

attempt <- introBox(actionButton("one","one"),
                    actionButton("two","two"),
                    data.step = 1,
                    data.intro = "This is step one")

test_that("introBox takes two elements, a data-step, and a data-intro",{
  expect_identical(attempt, target)
})

target <- tags$div(
    actionButton("one","one"),
    actionButton("two","two"),
    `data-hint` = "This is a hint")

attempt <- introBox(actionButton("one","one"),
                    actionButton("two","two"),
                    data.hint = "This is a hint")

test_that("introBox takes two elements, and a data-hint",{
  expect_identical(attempt, target)
})

target <- tags$div(
    actionButton("one","one"),
    actionButton("two","two"),
    `data-step` = 1,
    `data-intro` = "This is step one",
    `data-hint` = "This is a hint")

attempt <- introBox(actionButton("one","one"),
                    actionButton("two","two"),
                    data.hint = "This is a hint",
                    data.step = 1,
                    data.intro = "This is step one")

test_that("introBox takes two elements, a data-step, a data-intro, and a data-hint",{
  expect_identical(attempt, target)
})


test_that("introBox errors correctly", {
  expect_error(introBox(actionButton("one","one"),data.step = 1))
  expect_error(introBox(actionButton("one","one"),data.intro = "Hope this errors"))
})

