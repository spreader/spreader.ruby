$(document).ready(function() {

    $('.network').click(function() {
        $('#first_step').slideUp();
        $('#second_step').slideDown();
    });

    $('.second_submit').click(function() {
        $('#second_step').slideUp();
        $('#third_step').slideDown();
    });

    $('.third_submit').click(function() {
        $('#third_step').slideUp();
        $('#fourth_step').slideDown();
    });

    $('.forth_submit').click(function() {
        $('#fourth_step').slideUp();
        $('#first_step').slideDown();
    });
});