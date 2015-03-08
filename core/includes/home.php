<?php


$smarty->assign('refer', getRefer());

$url = array(

    'home' =>
        array(
            'url' => '/',
            'lbl' => 'Главная',
            'cls' => checkActive('home')
        ),

    'about' =>
        array(
            'url' => '/page_1.html',
            'lbl' => 'О компании',
            'cls' => checkActive('ap_1')
        ),
    'delivery' =>
        array(
            'url' => '/page_2.html',
            'lbl' => 'Доставка',
            'cls' => checkActive('ap_2')
        ),
    'pickup' =>
        array(
            'url' => '/page_7.html',
            'lbl' => 'Самовывоз',
            'cls' => checkActive('ap_7')
        ),
    'payment' =>
        array(
            'url' => '/page_3.html',
            'lbl' => 'Оплата',
            'cls' => checkActive('ap_3')
        ),
    'how' =>
        array(
            'url' => '/page_5.html',
            'lbl' => 'Как заказать?',
            'cls' => checkActive('ap_5')
        ),
    'return' =>
        array(
            'url' => '/page_6.html',
            'lbl' => 'Возврат и Обмен',
            'cls' => checkActive('ap_6')
        ),
    'contacts' =>
        array(
            'url' => '/feedback.html',
            'lbl' => 'Контакты',
//            'cls' => checkActive('ap_4')
        ),
    'news' =>
        array(
            'url' => '/news.html',
            'lbl' => 'Новости',
//            'cls' => checkActive('ap_4')
        ),

    'user_details' =>
        array(
            'lbl' => 'Кабинет',
            'url' => '/index.php?user_details=yes',
        ),

    'login' =>
        array(
            'lbl' => 'Вход',
            'url' => '/index.php?register_authorization',
        ),
    'logout' =>
        array(
            'lbl' => 'Выход',
            'url' => '/index.php?logout=yes',
        ),
    'admin' =>
        array(
            'url' => '/admin.php',
            'lbl' => ADMINISTRATE_LINK,
        ),
    'cabinet_contacts' =>
        array(
            'url' => '/index.php?contact_info=yes',
            'lbl' => STRING_CONTACT_INFORMATION_DOWN_CASE,
        ),
    'cabinet_address' =>
        array(
            'lbl' => STRING_ADDRESS_BOOK,
            'url' => '/index.php?address_book=yes',
        ),
    'cabinet_orders' =>
        array(
            'lbl' => STRING_ORDER_HISTORY,
            'url' => '/index.php?order_history=yes',
        ),
    'cabinet_visits' =>
        array(
            'lbl' => STRING_VISIT_HISTORY,
            'url' => '/index.php?visit_history=yes"',
        ),
    'cabinet_affiliate' =>
        array(
            'lbl' => STRING_AFFILIATE_PROGRAM,
            'url' => '/index.php?affiliate=yes&amp;sub=balance',
        ),


    'affiliate_balance' =>
        array(
            'lbl' => AFFP_USER_BALANCE,
            'url' => '/index.php?affiliate=yes&amp;sub=balance',
        ),
    'affiliate_history' =>
        array(
            'lbl' => AFFP_PAYMENTS_HISTORY,
            'url' => '/index.php?affiliate=yes&amp;sub=payments_history',
        ),
    'affiliate_guide' =>
        array(
            'lbl' => AFFP_ATTRACT_GUIDE,
            'url' => '/index.php?affiliate=yes&amp;sub=attract_guide',
        ),
    'affiliate_settings' =>
        array(
            'lbl' => STRING_MODULE_SETTING,
            'url' => '/index.php?affiliate=yes&amp;sub=settings',
        ),


//
//    'sale' =>
//        array(
//            'url' => '/',
//            'lbl' => 'Акции',
//            'cls' => checkActive('ap_8')
//        ),

);

$smarty->assign('url', $url);


$menu['company'] = array(
    $url['about'],
    $url['news'],
    $url['contacts']
);


$menu['client'] = array(
    $url['how'],
    $url['payment'],
    $url['delivery'],
    $url['pickup'],
    $url['return']
);

$menu['cabinet'] = array(
    $url['cabinet_orders'],
    $url['cabinet_contacts'],
    $url['cabinet_address'],
    $url['cabinet_visits']
);


$menu['affiliate'] = array(
    $url['affiliate_balance'],
    $url['affiliate_history'],
    $url['affiliate_guide']
);


if (CONF_AFFILIATE_PROGRAM_ENABLED) {

    $menu['cabinet']['cabinet_affiliate'] = $url['cabinet_affiliate'];

    if (CONF_AFFILIATE_EMAIL_NEW_COMMISSION || CONF_AFFILIATE_EMAIL_NEW_PAYMENT) {
        $menu['affiliate']['affiliate_settings'] = $url['affiliate_settings'];
    }

}


$smarty->assign('menu', $menu);


$site = array(
    'name' => 'Мир моды',
    'slogan' => 'Абсолютное качество по разумной цене',
    'phone' => '<span>8/921/</span>102-13-43',
    'phone2' => '<span>8/905/</span>966-25-52',
    'phone_num' => '+79211021343',
    'phone_num2' => '+79059662552',
    'email' => 'info@modymir.ru',
    'skype' => 'modymir',
    'isq' => ''
);


$smarty->assign('site', $site);


//'feedback',

$has_aside = array(
    'show_aux_page',
    'news',
    'fullnews'
);

//'order_history',
//    'contact_info',
//    'visit_history',
//    'address_book',
//    'user_details',
//    'affiliate',
//    'add_new_address',
//    'address_editor',
//    'order_detailed',


$smarty->assign('pageID', $pageID);
$smarty->assign('has_aside', $has_aside);


//fb($pageID);

$follow = array(
    array(
        'lbl' => 'Вконтакте',
        'url' => '/',
        'cls' => '_vk'
    ),
    array(
        'lbl' => 'Facebook',
        'url' => '/',
        'cls' => '_fb'
    ),
    array(
        'lbl' => 'Twitter',
        'url' => '/',
        'cls' => '_tw'
    )
);

$smarty->assign('follow', $follow);



if ($pageID == 'home') {

// novelty
//$smarty->assign('n_offers', getProducts('categoryID!=1 AND enabled=1','date_added DESC',8));


    $specID = getSpecProductsID();

    if (!empty($specID)) {
        $s_offers = getProducts('productID IN (' . implode(',', $specID) . ') AND categoryID!=1 AND enabled=1', 'FIELD(productID,'.implode(',', $specID).')', 12);
        $smarty->assign('s_offers', $s_offers);
    }


//    $v_offers = getProducts('productID NOT IN (' . implode(',', $specID) . ') AND categoryID!=1 AND enabled=1 AND (((list_price - price) / list_price) * 100) > 30', 'Price  ASC', 16);
//    $smarty->assign('v_offers', $v_offers);


    $allow_cats = array(241, 46, 53);

    $p_offers = getProducts('productID NOT IN (' . implode(',', $specID) . ') AND categoryID IN (' . implode(',', $allow_cats) . ') AND enabled=1', 'RAND()', 12);
    $smarty->assign('p_offers', $p_offers);


    $allow_cats = array(24328, 98, 449, 35, 1048, 36, 62, 48, 619, 63, 372, 49);
    $n_offers = getProducts('productID NOT IN (' . implode(',', $specID) . ') AND categoryID IN (' . implode(',', $allow_cats) . ') AND enabled=1', 'RAND()', 12);
    $smarty->assign('n_offers', $n_offers);


}
?>