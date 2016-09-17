// rintrojs package
// written by Carl Ganz
// wrapper for the introjs javascript library written by Afshin Mehrabani

Shiny.addCustomMessageHandler('introjs',function(options) {
  introJs().setOptions(options.options).oncomplete(function() {
    options.events.hasOwnProperty("oncomplete") && eval(options.events.oncomplete[0]);
    }).onexit(function() {
      options.events.hasOwnProperty("onexit") && eval(options.events.onexit[0]);
      }).onchange(function(targetElement) {
        options.events.hasOwnProperty("onchange") && eval(options.events.onchange[0]);
        }).onbeforechange(function(targetElement) {
          options.events.hasOwnProperty("onbeforechange") && eval(options.events.onbeforechange[0]);
          }).onafterchange(function(targetElement) {
            options.events.hasOwnProperty("onafterchange") && eval(options.events.onafterchange[0]);
            }).start();
});

Shiny.addCustomMessageHandler('hintjs',function(options) {
  introJs().setOptions(options.options).onhintclick(function() {
    options.events.hasOwnProperty("onhintclick") && eval(options.events.onhintclick[0]);
    }).onhintsadded(function() {
      options.events.hasOwnProperty("onhintsadded") && eval(options.events.onhintsadded[0]);
      }).onhintclose(function() {
        options.events.hasOwnProperty("onhintclose") && eval(options.events.onhintclose[0]);
        }).addHints();
});