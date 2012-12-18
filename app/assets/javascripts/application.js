// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require template

//= require rich/base
//= require plugins/jquery.metadata
//= require plugins/jquery.serializeJSON
//= require plugins/jquery.calchooser
//= require plugins/jquery.tagit
//= require plugins/jquery.chosen

//= require rails.validations
//= require rails.validations.simple_form

// Put your application scripts here
$(function() {

//$("[type=submit]").live('click', function(e) {
//    $(this).button('loading')
//})

// avoid double-click: disable and clear error message
$("form").live('ajax:before', function(e) {
    var element = $(this);
    element.find('.form-field-error').remove()
    element.find('.error').removeClass('error')

    element.find("[type=submit]").button('loading')
})

// avoid double-click: enable again
$("form").live('ajax:complete', function(e) {
    var element = $(this);
    element.find("[type=submit]").button('reset')
})

// enable popover
$('[rel="popover"]').popover({trigger: 'hover'})

//使得select 元素的placeholder成为默认选项
// http://stackoverflow.com/questions/5805059/select-placeholder
$('form select[placeholder]').each(function() {
    var select = $(this)
    var placeholder = select.attr('placeholder')
    $('<option value="" disabled="disabled" style="">' + placeholder + '</option>').prependTo(select);
})

//日期选择控件
$('input.calchooser').calchooser();

$('select.chosen').chosen()

// Use the modernizr.load() function to run polyfills for older browsers.
Modernizr.load([{
    test: Modernizr.input.placeholder,
    nope: [
        '/javascripts/polyfills/jquery.placeholder.js'
    ],
    callback: {
        "jquery.placeholder.js": function () {
            $('input[placeholder],textarea[placeholder]').placeholder({
                useNative: false,
                hideOnFocus: false,
                style: {
                    textShadow: 'none'
                }
            });
        }
    }
}]);

}); //END-OF-JQUERY-READY


