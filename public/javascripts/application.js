// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



$('.submittable').live('change', function() {
  $(this).parents('form:first').submit();
  //$(this).append("<%= escape_javascript(render(:partial => 'currencies/check_country')) %>");  
});


