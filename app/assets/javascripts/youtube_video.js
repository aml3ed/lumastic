function containerFadeOut() {
    $('.vid-overlay-container:first').fadeOut(400, function(){
        $(this).hide()
    });
    $('.vid-iframe-container')[0].lastElementChild.style.filter = "none";
}

function playButton() {
    containerFadeOut();
    player.play();

    $('.vid-button').each(function() {
        console.log('got here');
       $(this).attr('data-type', 'out');
    });
    $('.vid-text-overlay').html('How confident do you feel now?');
}

var outClicked = false;
function bringBackButtons() {
    if(player.get_duration() - player.get_current_time() > 20 || outClicked)
        return;
    $('.vid-overlay-container:first').fadeIn(400, function(){
        $(this).show()
        outClicked = true;
    });
}

$(document).ready(function() {
    var inDone = false;
    $(".vid-button").click(function() {
        var type = "";
        if(inDone) {
            type = 'out';
            containerFadeOut();
        } else {
            type = 'in';
            inDone = true;
            playButton();
        }
        switch (this.id) {
            case 'red':
                // do something
                Rails.ajax({
                    url: $(this).data("url"),
                    type: "PATCH",
                    data: "color=red&type="+type
                });
                break;
            case 'blue':
                // do something
                Rails.ajax({
                    url: $(this).data("url"),
                    type: "PATCH",
                    data: "color=blue&type="+type
                })
                break;
            case 'green':
                // do something
                Rails.ajax({
                    url: $(this).data("url"),
                    type: "PATCH",
                    data: "color=green&type="+type
                })
                break;
        }
    });
});
