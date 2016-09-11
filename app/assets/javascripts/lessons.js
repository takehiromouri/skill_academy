var add_active_to_nav = function(){
  var url = window.location;
  // Will only work if string in href matches with location
  $('ul.nav a[href="' + url + '"]').parent().addClass('active');

  // Will also work for relative and absolute hrefs
  $('ul.nav a').filter(function () {
      return this.href == url;
  }).parent().addClass('active').parent().parent().addClass('active');
}

$(document).on("turbolinks:load", function(){
  add_active_to_nav();
});