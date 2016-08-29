// rintrojs package
// written by Carl Ganz
// wrapper for the introjs javascript library written by Afshin Mehrabani

Shiny.addCustomMessageHandler('introjs',function(options) {
  introJs().setOptions(options.options).oncomplete(function() {
    options.events.hasOwnProperty("oncomplete") && eval(options.events.oncomplete);
    }).onexit(function() {
      options.events.hasOwnProperty("onexit") && eval(options.events.onexit);
      }).onchange(function(targetElement) {
        options.events.hasOwnProperty("onchange") && eval(options.events.ononchange);
        }).onbeforechange(function(targetElement) {
          options.events.hasOwnProperty("onbeforechange") && eval(options.events.onbeforechange);
          }).onafterchange(function(targetElement) {
            options.events.hasOwnProperty("onafterchange") && eval(options.events.onafterchange);
            }).start();
});

Shiny.addCustomMessageHandler('hintjs',function(options) {
  introJs().setOptions(options.options).onhintclick(function() {
    options.events.hasOwnProperty("onhintclick") && eval(options.events.onhintclick);
    }).onhintsadded(function() {
      options.events.hasOwnProperty("onhintsadded") && eval(options.events.onhintsadded);
      }).onhintclose(function() {
        options.events.hasOwnProperty("onhintclose") && eval(options.events.onhintclose);
        }).addHints();
});