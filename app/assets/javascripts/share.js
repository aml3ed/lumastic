function shareFunction(clicked) {
    var network = $(clicked).attr('data-network');
    var title = encodeURI("Check out this thing on Lumastic!");
    var description = encodeURI("Share your interests, grow your talents, and find people who love what you love! ");
    var link = encodeURIComponent(window.location);

    switch(network) {
        case 'email':
            popup("mailto:?Subject="+ title +"&body=" + description + link);
            break;
        case 'facebook':
            popup('https://www.facebook.com/dialog/share?app_id=358606851550752&href='+link);
            break;
        case 'linkedin':
            popup("https://www.linkedin.com/shareArticle?url="+link);
            break;
        case 'twitter':
            popup("https://twitter.com/intent/tweet?text="+title+"%20"+link);
            break;
    }
    function popup(href) {
        var options = 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,width=600,height=400';
        window.open(href, "Share with others", options);
    }
}