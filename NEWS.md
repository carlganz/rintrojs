# rintrojs 0.3.4

* Use `potools` to add Spanish translations for error and warning messages

# rintrojs 0.3.3

* Add ORCID to DESCRIPTION

* Update personal URL in readme

* Misc CRAN fixes

# rintrojs 0.3.2

* Fix improper use of `shiny::singleton` fixes #54 (Thanks @gregleleu @zagrebmukerjee)

# rintrojs 0.3.1

* Use different html attribute to identify tabPanels in jQuery, which fixes issue in #38 (Thanks @vaelliot @jsinnett)

* Use Github Actions for CI

* Update jQuery selector to require data-value attribute in case users use tab-pane class in unexpected ways

# rintrojs 0.3.0

* Added support of MathJax in tour steps ([#39](https://github.com/carlganz/rintrojs/issues/39), [#50](https://github.com/carlganz/rintrojs/pull/50)) (Thanks @etiennebacher)

* Updated intro.js to 3.2.1

* Fix a bunch of URLs (Thanks https://github.com/eddelbuettel/littler/blob/master/inst/examples/urlUpdate.r)

# rintrojs 0.2.2

* Updated intro.js to 2.9.3

# rintrojs 0.2.1

* Add predefined JS callback that makes dealing with mutli-tab introjs much easier (Thanks @crew102 and @thercast [#30](https://github.com/carlganz/rintrojs/pull/30))

# rintrojs 0.2.0

* Fix issue with boolean introjs options (Thanks @leonawicz [#16](https://github.com/carlganz/rintrojs/issues/16))

* Upgrade to Intro.js 2.6.0

* Add option to include Intro.js from CDN

* Add data.position parameter to `introBox`

## BREAKING CHANGES

* Javascript code for events must now be wrapped by `I()`.

# rintrojs 0.1.2

* Fix modules issue (Thanks @thercast and @klmr [#15](https://github.com/carlganz/rintrojs/issues/15))

# rintrojs 0.1.1

* Fix events bug ([#7](https://github.com/carlganz/rintrojs/issues/7))

* Upgrade to Intro.js 2.3.0

* Use AGPL-3 license (Thanks @graingert [#8](https://github.com/carlganz/rintrojs/issues/8))

* Meet [Journal of Open Source Software requirements](https://joss.theoj.org/papers/10.21105/joss.00063)