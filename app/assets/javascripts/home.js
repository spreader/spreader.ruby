$(document).ready(function() {
    $("#slider").easySlider({
        auto: false,
        continuous: true
    });

    $("#accordion").accordion({
        icons: { header: "ui-icon-circle-plus", headerSelected: "ui-icon-circle-minus" },
        autoHeight: false
    });

    $('#survey').sortable({
        axis: 'y',
        dropOnEmpty:false,
        handle: '.handle',
        cursor: 'crosshair',
        items: 'li',
        opacity: 0.4,
        scroll: true
    });

    $('#submit_survey').click(function() {
        var ip = '<!--#echo var="REMOTE_ADDR"-->';
        $.ajax({
            type: 'post',
            data: $('#survey').sortable('serialize') + '&id=' + ip,
            dataType: 'script',
            complete: function(request) {
                $('#survey_status').html = "Successfully Submitted Survey!";
            },
            url: '/home#sort'});
    });

    $('#user_email').watermark("Email");
    $('#user_name').watermark("Full Name");
    $('#user_password').watermark("Password");
    $('#user_password_confirmation').watermark("Confirm Password");

});