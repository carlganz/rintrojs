Shiny.addCustomMessageHandler('introjs',function(options) {
  introJs().setOptions(options).start();
});

Shiny.addCustomMessageHandler('hintjs',function(options) {
  introJs().setOptions(options).addHints();
});