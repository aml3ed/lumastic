function containerFadeOut() {
    $('.vid-overlay-container:first').fadeOut(400, function() {
        $(this).css({opacity: 0, display: 'flex'});
        $(this).remove();
    });
    $('.vid-iframe-container')[0].lastElementChild.style.filter = "none";
}

function playButton() {
    containerFadeOut();
    player.play();
}

function vidbuttonOnClick() {
    $("#play-btn").click(function() {
        playButton();
    });
}
