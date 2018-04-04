function switchTabs(targetElement) {
  // get nodelist of tab panes 
  var tabpanes = document.querySelectorAll("div.tab-pane");
  // iterate over the list of tab panes and click their corresponding link
  // element if the node contains the upcoming target element 
  for (i = 0; i < tabpanes.length; i++) {
    if (tabpanes[i].contains(targetElement)) {
      var selector = "a[href = \"#" + tabpanes[i].id + "\"]";
      document.querySelector(selector).click();
    }
  }
}
