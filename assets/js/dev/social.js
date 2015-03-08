function Social(){}
Social.Twitter = function() {}
Social.VK = function() {}
Social.Facebook = function() {}
Social.Google = function() {}

Social.Twitter.SharePage = function(text, link) {
    if ( !link ) { link = location.href; }
    window.open("http://twitter.com/share?text=" + encodeURI(text) + "&url=" + encodeURI(link), "_blank", "fullscreen=0,width=700px,height=400px,status=0,toolbar=0,scrollbars=0,menubar=0,location=0,top=200,left=200");
}

Social.VK.SharePage = function(text, title, link) {
    if ( !link ) { link = location.href; }
    if ( !title ) { title = '';	}
    window.open("https://vkontakte.ru/share.php?description=" + encodeURI(text) + "&title=" + encodeURI(title) + "&url=" + encodeURI(link), "_blank", "fullscreen=0,width=500px,height=350px,status=0,toolbar=0,scrollbars=0,menubar=0,location=0,top=200,left=200");
}

Social.Facebook.SharePage = function(text, link) {
    if ( !text ) { text = ''; }
    if ( !link ) { link = location.href; }
    window.open("http://www.facebook.com/sharer.php?s=100&p[title]=" + encodeURI(link) + "&p[summary]=" + encodeURI(text) + "&p[url]=" + encodeURI(link), "_blank", "fullscreen=0,width=500px,height=350px,status=0,toolbar=0,scrollbars=0,menubar=0,location=0,top=200,left=200");
}

Social.Google.SharePage = function(link) {
    link = link || location.href;
    window.open("https://plus.google.com/share?url=" + encodeURI(link), "_blank", "fullscreen=0,width=500px,height=500px,status=0,toolbar=0,scrollbars=0,menubar=0,location=0,top=200,left=200");
}
