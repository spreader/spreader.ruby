$(document).ready(function() {

    $('#friend-email').watermark("Email Address");
    $('#friend-name').watermark("Full Name");
    $('#friend-message').watermark("Optional Message");
    $('#feedback-comment').watermark("Tell us what you think");

    function GetCurrentPage() {
        var url = window.location.href.split('/');
        return url[url.length - 1];
    }

    var $date_selector = $('#date_selector');
    if ($date_selector.length > 0) {
        $date_selector.daterangepicker(
            {
                arrows: true,
                doneButtonText: "cancel",
                dateFormat: "dd-M-yy",
                onClose: function() {
                    UpdateDate();
                }
            }
        );
    }

    // todo: remove this
    var $app_id = 125524087493943;
    $("#huaweidevice").click(function() {
        $app_id = 125524087493943;
        $.ajax({
            url: '/dashboard/chart_type',
            type: 'post',
            data: { app_id: $app_id, id: GetCurrentPage(), chart_type: $chart_type, date_range: $date_selector.val(), upload_data: $upload_data },
            dataType: 'json',
            complete: function(request) {
                $('.chart-body').html(request.responseText);
            }
        });
        return false;
    });

    $("#secrethk").click(function() {
        $app_id = 313457693212;
        $.ajax({
            url: '/dashboard/chart_type',
            type: 'post',
            data: { app_id: $app_id, id: GetCurrentPage(), chart_type: $chart_type, date_range: $date_selector.val(), upload_data: $upload_data },
            dataType: 'json',
            complete: function(request) {
                $('.chart-body').html(request.responseText);
            }
        });
        return false;
    });

    var $chart_type = "line";
    $('.chart_type').click(function() {
        $chart_type = this.id;
        $.ajax({
            url: '/dashboard/chart_type',
            type: 'post',
            data: { app_id: $app_id, id: GetCurrentPage(), chart_type: $chart_type, date_range: $date_selector.val(), upload_data: $upload_data },
            dataType: 'json',
            complete: function(request) {
                $('.chart-body').html(request.responseText);
                $.jGrowl('Changed Chart to ' + $chart_type +'!');
            }
        });
        return false;
    });

    function UpdateDate() {
        $.ajax({
            url: '/dashboard/chart_type',
            type: 'post',
            data: { app_id: $app_id, id: GetCurrentPage(), chart_type: $chart_type, date_range: $date_selector.val(), upload_data: $upload_data },
            dataType: 'json',
            complete: function(request) {
                //console.log(request.responseText);
                $('.chart-body').html(request.responseText);
                $.jGrowl('Updated Graph!');
                return false;
            }
        });
    }

    var $upload_data = false;
    $('#upload-data').click(function() {
        $.ajax({
            url: '/dashboard/chart_type',
            type: 'post',
            data: { app_id: $app_id, id: GetCurrentPage(), chart_type: $chart_type, date_range: $date_selector.val(), upload_data: true },
            dataType: 'json',
            complete: function(request) {
                $upload_data = true;
                $('.chart-body').html(request.responseText);
                $.jGrowl('Adding Data!');
            }
        });
        return false;
    });

    $("#sidetab").organicTabs({
        "speed": 200
    });

    $('#feedback-submit').click(function() {
        $.ajax({
            url: '/dashboard/feedback',
            type: 'post',
            data: { feedback_comment: $('#feedback-comment').val() },
            dataType: 'json',
            complete: function(request) {
                $.jGrowl('Feedback Submitted!');
                //$('#feedback-status').html("Feedback Submitted");
                // todo: Update Flash Notice
            }
        });
        return false;
    });

    $('#friend-invite-submit').submit(function() {
        $.ajax({
            url: '/dashboard/friend_invite',
            type: 'post',
            data: { friend_email: $('#friend-email').val(), friend_name: $('#friend-name').val(), friend_message: $('#friend-message').val() },
            dataType: 'json',
            complete: function(request) {

                $.jGrowl('Invite Sent to ' + $('#friend-name').val() + '!');
                //$('#friend-invite-status').html("Invite Sent");
                // todo: Update Flash Notice
            }
        });
        return false;
    });

    $('.settings-icon').click(function() {
        var $this = $(this);
        $this.parent().children('.graph-settings-popup').toggle();
        return false;
    });

    $('.button-drop').click(function() {
        var $this = $(this);
        $this.parent().children('.settings-list').toggle('slow');
        return false;
    });

    $('.close-settings').click(function() {
        var $this = $(this);
        $this.parent().parent().toggle();
        return false;
    });

});