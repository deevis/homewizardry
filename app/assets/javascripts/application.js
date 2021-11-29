//= require jquery
//= require jquery_ujs

function setColor(form_id, rgb) {
  $(form_id + " #color_rgb").val(rgb);
  $(form_id).submit();
}