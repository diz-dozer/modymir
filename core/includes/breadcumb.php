<?php

function dizBreadcrumb()
{

    global $pageID, $fc, $categoryID, $page_name;


    $breadcramb[] = array(
        name => 'Главная',
        url => "/"
    );

    function _set_last($name, &$breadcramb)
    {
        array_push($breadcramb, array('name' => $name));
        return $breadcramb;
    }

    if (!empty($categoryID)) {
        $path = dizBreadcrumbPath($fc, $categoryID);
        unset($path[0]);
        $breadcramb = array_merge($breadcramb, $path);
    }

    switch ($pageID) {

        case 'productID':
            _set_last($page_name, $breadcramb);
            break;

//        case 'selection':
//            _set_last('Отбор по параметрам', $breadcramb);
//            break;

        case 'show_aux_page':
            $aux_page = auxpgGetAuxPage($_REQUEST['show_aux_page']);
            _set_last($aux_page['aux_page_name'], $breadcramb);
            break;

        case 'news':
            $breadcramb = array_merge($breadcramb, dizBreadcrumbNewsPath());
            break;

        case 'fullnews':
            $breadcramb = array_merge($breadcramb, dizBreadcrumbNewsPath());
            break;

        case 'feedback':
            _set_last('Контакты', $breadcramb);
            break;


//        case 'shopping_cart':
//            _set_last('Ваша корзина', $breadcramb);
//            break;
//        case 'order2_shipping':
//        case 'order2_shipping_quick':
//            _set_last('Способ доставки', $breadcramb);
//            break;
//        case 'order3_billing':
//        case 'order3_billing_quick':
//            _set_last('Способ оплаты', $breadcramb);
//            break;
//        case 'order4_confirmation':
//        case 'order4_confirmation_quick':
//            _set_last('Подтверждение заказа', $breadcramb);
//            break;

//
//        case 'user_details':
//            _set_last(STRING_ACC_USER, $breadcramb);
//            break;
//
//        case 'order_history':
//            _set_last(STRING_SHOPPING_HISTORY, $breadcramb);
//            break;
//        case 'contact_info':
//            _set_last(STRING_USER_DATA_ALL, $breadcramb);
//            break;
//        case 'address_book':
//            _set_last(STRING_ADDRESS_BOOK, $breadcramb);
//            break;
//        case 'visit_history':
//            _set_last(STRING_VISIT_LOG, $breadcramb);
//            break;
//        case 'affiliate':
//            _set_last(STRING_AFFILIATE_PROGRAM, $breadcramb);
//            break;
//        case 'order_detailed':
//            _set_last(STRING_ORDERING_INFO, $breadcramb);
//            break;
//        case 'add_new_address':
//            _set_last(STRING_AFFILIATE_PROGRAM, $breadcramb);
//            break;

    }

    if (count($breadcramb) > 1)
        return $breadcramb;
}


function dizBreadcrumbCartPath($pageID)
{


//
//    $breadcrumb = array(
//
//        'shopping_cart' => array(
//
//            'name' => $category['name'],
//            'categoryID' => $category['categoryID'],
//            'url' => '/cart.html'
//        ),
//        'order2_shipping' => array(
//
//            'name' => $category['name'],
//            'categoryID' => $category['categoryID'],
//            'url' => $url
//        ),
//        'order4_confirmation' 'name' => $category['name'],
//            'categoryID' => $category['categoryID'],
//            'url' => $url
//        )
//
//
//    );
//
//
//    return $breadcrumb;

}


function dizBreadcrumbNewsPath()
{

    $newsID = (int)$_GET['fullnews'];

    if (CONF_MOD_REWRITE) {
        $news_url = $url = 'news.html';
        $fullnews_url = 'show_news_' . $newsID . '.html';
    } else {

        $news_url = $url = 'index.php?news=yes';
        $fullnews_url = 'index.php?fullnews=' . $newsID;
    }


    $path[] = array(
        'name' => 'Новости',
        'url' => $news_url
    );

    if (!empty($newsID)) {
        $sql = '
            SELECT DISTINCT
            title
            FROM ' . NEWS_TABLE . '
            WHERE NID=' . $newsID;

        $q = db_query($sql);
        while ($row = db_fetch_row($q)) {
            $path[] = array(
                'name' => $row['title'],
                'url' => $fullnews_url
            );
        }
    }

    return $path;
}

function dizBreadcrumbPath($array, $parentId, $reset = true)
{

    static $breadcrumb;

    if ($reset == true) {
        $breadcrumb = array();
    }

    foreach ($array as $category) {

        if ($parentId == $category['categoryID']) {

            if (CONF_MOD_REWRITE) {
                $alias = $category['alias'];
                if (!empty($alias)) {
                    $url = '/' . $alias . '/';
                } else {
                    $url = 'category_' . $category['categoryID'] . '.html';
                }
            } else {

                $url = 'index.php?categoryID=' . $category['categoryID'];
            }
            $breadcrumb[] = array(
                'name' => $category['name'],
                'categoryID' => $category['categoryID'],
                'url' => $url
            );

            if ($category['parent'] > 0) {
                dizBreadcrumbPath($array, $category['parent'], false);
            }
        }
    }

    return array_reverse($breadcrumb);
}

$smarty->assign("breadcrumb", dizBreadcrumb());
?>