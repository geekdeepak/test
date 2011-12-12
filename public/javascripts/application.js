// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.observe(window, 'load', function(event) {
  var d = $('optional');
  d.hide();
  Event.observe('options_toggle', 'click', function(event) {
    d.toggle();
  });
});
