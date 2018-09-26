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