var body = document.body,
    timer,
    hover_disabled = false;

window.addEventListener('scroll', function () {
    clearTimeout(timer);
    if (!hover_disabled && !body.classList.contains('disable-hover')) {
        body.classList.add('disable-hover');
        hover_disabled = true;
    }

    timer = setTimeout(function () {
        body.classList.remove('disable-hover');
        hover_disabled = false;
    }, 250);
}, false);


(function (d, w, c) {
    (w[c] = w[c] || []).push(function () {
        try {
            w.yaCounter28881795 = new Ya.Metrika({
                id: 28881795,
                webvisor: true,
                clickmap: true,
                trackLinks: true,
                accurateTrackBounce: true
            });
        } catch (e) {
        }
    });

    var n = d.getElementsByTagName('script')[0],
        s = d.createElement('script'),
        f = function () {
            n.parentNode.insertBefore(s, n);
        };
    s.type = 'text/javascript';
    s.async = true;
    s.src = (d.location.protocol == 'https:' ? 'https:' : 'http:') + '//mc.yandex.ru/metrika/watch.js';

    if (w.opera == '[object Opera]') {
        d.addEventListener('DOMContentLoaded', f, false);
    } else {
        f();
    }
})(document, window, 'yandex_metrika_callbacks');


$(function () {

    $('html').removeClass('no-js');
    scrollUp();
    slider();
    carousel();
    radio_tap();
    fancy();
    tabs();
    map();
    hyper();

    //zoom();
    ///  nav();
});

function confirmDelete(id, ask, url) {
    var temp = window.confirm(ask);
    if (temp) {
        window.location=url+id;
    }
}

function hyper() {


    var $comments = $('#comments');
    if ($comments.length) {



        (function () {
            if ('HC_LOAD_INIT' in window)return;
            HC_LOAD_INIT = true;
            var lang = (navigator.language || navigator.systemLanguage || navigator.userLanguage || 'en').substr(0, 2).toLowerCase();
            var hcc = document.createElement('script');
            hcc.type = 'text/javascript';
            hcc.async = true;
            hcc.src = ('https:' == document.location.protocol ? 'https' : 'http') + '://w.hypercomments.com/widget/hc/26904/' + lang + '/widget.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(hcc, s.nextSibling);
        })();


        $comments.addClass('include');
        _hcwp = window._hcwp || [];
        _hcwp.push({widget: 'Stream', widget_id: 26904, append: '#comments'});
    }


}


function map() {
    if ($('#map').length) {
        (function () {

            var js = document.createElement('script');
            js.type = 'text/javascript';
            js.async = true;
            js.src = ('https:' == document.location.protocol ? 'https' : 'http') + '://api-maps.yandex.ru/2.1/?lang=ru_RU&mode=release&onload=ymap';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(js, s.nextSibling);

        })();

    }
}
function ymap() {

    var yMap = new ymaps.Map('map', {
        center: [55.722616, 37.689024],
        zoom: 15,
        controls: ['smallMapDefaultSet']
    });


    var mark = new ymaps.Placemark(yMap.getCenter(), {
            balloonContentHeader: 'Мир моды : интернет-магазин',
            balloonContentBody: '<a href="http://modymir.ru/category_2.html">Пальто</a><br/><a href="http://modymir.ru/category_3.html">Куртки</a><br/><a href="http://modymir.ru/category_4.html">Плащи</a><br/><a href="http://modymir.ru/category_5.html">Аксессуары</a>',
            balloonContentFooter: '<em>Актуальные, Cтильные, Практичные модели<br/>Абсолютное качество по разумной цене</em>',
            hintContent: 'Мир моды'
        }, {
            preset: 'islands#violetDotIcon'
        }
    );

    yMap.geoObjects.add(mark);

}


function YaShareInit() {


    $('.social-line').each(function () {

        var lnk, tit, img, el;

        el = $(this).attr('id');


        if ($('#' + el).length) {

            lnk = $(this).data('url');
            tit = $(this).data('title');
            img = $(this).data('src');

            new Ya.share({
                element: el,
                l10n: 'ru',
                theme: 'counter',
                link: lnk,
                title: tit,
                image: img,
                elementStyle: {
                    quickServices: ['yaru', 'vkontakte', 'facebook', 'twitter', 'odnoklassniki', 'moimir', 'gplus']
                }
            });
        }
    });
}

//function nav() {
//
//
//
//    var $links = $('nav .wrap');
//
//    //cl($links);
//
//    //$links.hoverIntent();
//
//
//
//}

function tabs() {


    $('.tabs_nav').each(function () {

        var $nav = $(this);

        //cl($nav);


        var $active, $content, $links;


        $links = $nav.contents().children('a');


        $active = $($links.filter('[href="' + location.hash + '"]')[0] || $links[0]);
        $active.addClass('active');

        $content = $($active[0].hash);


        $links.not($active).each(function () {
            $(this.hash).hide();
        });


        $nav.on('click', 'a', function (e) {

            $active.removeClass('active');
            $content.hide();


            $active = $(this);
            $content = $(this.hash);


            $active.addClass('active');
            $content.show();

            e.preventDefault();
        });


    });
}


function fancy() {


    $('a[href$=".jpg"],a[href$=".png"],a[href$=".gif"],.fancybox').attr('data-fancybox-group', 'gallery').fancybox();

    //$('[data-zoom-image]').each(function () {
    //    var $zoom = $(this);
    //    $zoom.elevateZoom();
    //    //cl($zoom);
    //});

}

//function zoom() {
//
//
//    //$('[data-zoom-image]').each(function () {
//    //    var $zoom = $(this);
//    //    $zoom.elevateZoom();
//    //    //cl($zoom);
//    //});
//
//}

function radio_tap() {

    $('.radio_tap').each(function () {

        var $list = $(this);
        var $items = $list.find('dl');

        $items.click(function () {
            var $checked = $(this);
            $items.removeClass('checked');
            $checked.addClass('checked');
        });

    });

}


function slider() {


    var opt = {
        autoHeight: 0,
        fx: 'scrollHorz',
        //fx: 'fadeout',
        log: false,
        slides: '.slide',
        delay: '10000',
        speed: '500',
        timeout: '8000',
        pauseOnHover: true,
        swipe: true,
        pagerActiveClass: 'active',
        pagerTemplate: '<a class="lnk"/>'
    };


    $('.slider').each(function () {


        var $this = $(this);

        var id = $this.attr('id');

        if (id === undefined) {
            id = Math.random().toString(36).substr(2);
            $this.attr('id', id);
        }


        var pager = 'pg_' + id;
        var next = 'nxt_' + id;
        var prev = 'prv_' + id;

        opt.pager = '#' + pager;
        opt.next = '#' + next;
        opt.prev = '#' + prev;

        $this
            .before('<a id="' + next + '" class="next"/><a id="' + prev + '" class="prev"/>')
            // .before('<div class="w_pager"><div id="' + pager + '" class="pager"/></div>')
            .cycle(opt);
    });

}


function carousel() {

    $('.carousel').each(function () {


        var chank, starting = 0, size = 4;

        var $this = $(this);
        var id = $this.attr('id');

        var $lst = $this.find('.offer');

        if (id === undefined) {
            id = Math.random().toString(36).substr(2);
            $this.attr('id', id);
        }

        $this.data('next', id + '_next');
        $this.data('prev', id + '_prev');


        //var opt = {
        //    fx: 'scrollHorz',
        //    slides: '.slide',
        //    log: true,
        //
        //    //carouselVisible: 0,
        //    //carouselFluid: true,
        //    //carouselOffset: 0,
        //    //
        //    //updateView: -1,
        //    //autoHeight: 0,
        //
        //    allowWrap: true,
        //    speed: 500,
        //    timeout: 0,
        //    disabledClass: 'disabled'
        //};

        var opt = {
            autoHeight: 0,
            //fx: 'scrollHorz',
            fx: 'fadeOut',
            log: false,
            slides: '.slide',
            delay: 10000,
            speed: 300,
            timeout: 0,
            pauseOnHover: true,
            swipe: true,
            pagerActiveClass: 'active',
            pagerTemplate: '<a class="lnk"/>'
        };

        if ($lst.length > size) {

            $this.removeClass('offers');

            while ($lst.length > 0) {

                chank = $($lst.splice(0, size));
                chank.wrapAll('<div class="slide" />');

                var parent = chank.parent();

                if (chank.hasClass('active')) {
                    parent.index();
                }

                //if (chank.length < size) {
                //    for (var i = 0; i < (size - chank.length); i++) {
                //        parent.append('<div class="offer"><b class="pic _empty"/></li>');
                //    }
                //}
            }


            var next = 'nxt_' + id;
            var prev = 'prv_' + id;

            opt.next = '#' + next;
            opt.prev = '#' + prev;


            $this
                .before('<a id="' + next + '" class="next"/><a id="' + prev + '" class="prev"/>')
                .cycle(opt);

        }

    });
}

function scrollUp() {

    var scrollTitle = 'Наверх';
    var easingType = 'linear';

    var scrollSpeed = 250;
    var animationSpeed = 250;
    var scrollDistance = 250;


    var $self =
        $('<a/>', {
            id: 'scrollUp',
            href: '#top',
            title: scrollTitle
        }).appendTo('body');

    $self.click(function (e) {
        e.preventDefault();
        $('html, body').stop(true).animate({scrollTop: 0}, scrollSpeed, easingType);
    });


    function tgl(tgl) {

        $self.stop(true, true);

        switch (tgl) {
            case 'show':
                $self
                    .addClass('is_enabled')
                    .css({'display': 'block'})
                    .fadeTo(0, 0)
                    .animate({
                        opacity: .3
                        //bottom: '+=1em'
                    }, animationSpeed);
                break;
            case 'hide':
                $self
                    .removeClass('is_enabled')
                    .animate({
                        opacity: 0
                        //bottom: '-=1em'
                    }, animationSpeed, function () {
                        $self.hide();
                    })
                break;
        }
    }

    $(window).scroll(function () {
        var scl = $(window).scrollTop();

        if (scl > scrollDistance && !$self.hasClass('is_enabled')) {
            tgl('show');
        }

        if (scl < scrollDistance && $self.hasClass('is_enabled')) {
            tgl('hide');
        }
    });
}
