function playVideo(iframe) {
    iframe[0].contentWindow.postMessage('{"event":"command","func":"' + 'playVideo' + '","args":""}', '*');
}

function pauseVideo(iframe) {
    iframe[0].contentWindow.postMessage('{"event":"command","func":"' + 'pauseVideo' + '","args":""}', '*');
}

function playButton() {
    $('.vid-overlay-container:first').fadeOut(400, function(){
        $(this).hide()
    });
    var iframeContainer = document.getElementsByClassName("vid-iframe-container")[0].lastElementChild;
    iframeContainer.style.filter = "none";

    playVideo($("iframe"));
}

$(document).ready(function() {
    $(".vid-button").click(function() {
        playButton();
        switch (this.id) {
            case 'red':
                // do something
                Rails.ajax({
                    url: $(this).data("url"),
                    type: "PATCH",
                    data: "color=red&type=in"
                });
                break;
            case 'blue':
                // do something
                Rails.ajax({
                    url: $(this).data("url"),
                    type: "PATCH",
                    data: "color=blue&type=in"
                })
                break;
            case 'green':
                // do something
                Rails.ajax({
                    url: $(this).data("url"),
                    type: "PATCH",
                    data: "color=green&type=in"
                })
                break;
        }
    });
});