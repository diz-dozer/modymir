<?php


function getRefer(){

    //ToDo Reffer
    $refer = $_SERVER['HTTP_REFERER'];
    $url = parse_url($refer);

//   fb($url['host']);

  return false;

//    return $refer;
}


function checkActive($id)
{
    global $pageID;

    switch ($pageID) {
        case 'home':
            $etalon = 'home';
            break;
        case 'show_aux_page':
            $etalon = 'ap_' . (int)$_REQUEST['show_aux_page'];
            break;
    }

    $result = ($id == $etalon) ? true : false;

    return $result;
}

function getOffers($offers)
{

    if (!empty($offers)) {


        $sql = '
    SELECT
    DISTINCT
    s.productID,
    s.enabled,
    s.name,
    s.product_code,
    s.Price,
    s.list_price,
    t.filename AS picture
    FROM ' . PRODUCTS_TABLE . ' AS s
    LEFT JOIN ' . PRODUCT_PICTURES . ' AS t ON (s.default_picture=t.photoID AND s.productID=t.productID)
    WHERE s.enabled=1 AND s.Price > 0 AND s.productID IN (' . implode(',', $offers) . ')';

        $q = db_query($sql);

        while ($row = db_fetch_assoc($q)) {

            $row['PriceWithUnit'] = show_price($row['Price']);
            $row['list_priceWithUnit'] = show_price($row['list_price']);
            $result[] = $row;
        }


        return $result;
    }
}


function fb($var)
{

    # load class
    if (class_exists('FirePHP', false) === false) {
        require 'core/classes/class.firephp.php';
    }
    # instantiate
    $firephp = FirePHP::getInstance(true);
    $firephp->log($var);
}


function fbd($var)
{

    echo '<pre>';
    print_r($var);
    echo '<pre>';
}


function ftrace()
{

    # load class
    if (class_exists('FirePHP', false) === false) {
        require 'core/classes/class.firephp.php';
    }
    # instantiate
    $firephp = FirePHP::getInstance(true);
    $firephp->log(debug_backtrace());
}

function imgCheckSrc($path)
{

    $src = CONF_NOPHOTO_SRC;

    $a = getimagesize($path);
    $image_type = $a[2];

    if (in_array($image_type, array(IMAGETYPE_GIF, IMAGETYPE_JPEG, IMAGETYPE_PNG, IMAGETYPE_BMP)))
        $src = $path;

    return $src;
}

function buildTree($tree, $parentId = 1)
{
    $branch = array();
    foreach ($tree as $element) {
        if ($element['parent'] == $parentId) {
            $children = buildTree($tree, $element['categoryID']);
            if ($children) {
                $element['children'] = $children;
            }
            $branch[] = $element;
        }
    }
    return $branch;
}

function getBranch($tree, $parentId = 1)
{
    $branch = array();
    foreach ($tree as $element) {
        if ($element['parent'] == $parentId) {
            $children = buildTree($tree, $element['categoryID']);
            if (!empty($children)) {
                foreach ($children as $k => $v) {
                    $branch[] = $v['categoryID'];
                }
            }
            $branch[] = $element['categoryID'];
        }
    }
    return $branch;
}

function dizGetParent($categoryID)
{

    global $cats;

    if (!empty($cats))
        foreach ($cats as $k => $v) {
            if ((int)$v['categoryID'] === (int)$categoryID) {
                $parent = $v;
            }
        }

    return $parent;
}

function catGetCatLvl($categoryID)
{

    global $cats;

    if ($cats) {
        foreach ($cats as $k => $v)
            if ($v['categoryID'] == $categoryID)
                $lvl = (int)$v['level'];
    }

    return $lvl;
}

function dizGetCatID($name)
{

    global $cats;

    if ($cats) {
        foreach ($cats as $k => $v)
            if ($v['name'] == $name)
                $id = (int)$v['categoryID'];
    }

    return $id;
}

function flatten_array($array, $preserve_keys = 0, &$out = array())
{
    # Flatten a multidimensional array to one dimension, optionally preserving keys.
    #
    # $array - the array to flatten
    # $preserve_keys - 0 (default) to not preserve keys, 1 to preserve string keys only, 2 to preserve all keys
    # $out - internal use argument for recursion
    foreach ($array as $key => $child)
        if (is_array($child))
            $out = flatten_array($child, $preserve_keys, $out);
        elseif ($preserve_keys + is_string($key) > 1)
            $out[$key] = $child;
        else
            $out[] = $child;
    return $out;
}

function dizIconv($data, $sInCharset = 'utf-8', $sOutCharset = 'cp1251')
{
    if (is_array($data)) {
        $sElement = array();
        foreach ($data as $keyElement => $valueElement) {
            $sElement[dizIconv($keyElement)] = dizIconv($valueElement);
        }
        $resultData = $sElement;
    } elseif (is_object($data)) {
        $oData = get_object_vars($data);
        foreach ($oData as $keyField => $valueField) {
            $data->$keyField = dizIconv($valueField);
        }
        $resultData = $data;
    } elseif (is_string($data)) {
        $resultData = iconv($sInCharset, $sOutCharset, $data);
    } elseif (is_numeric($data)) {
        $resultData = $data;
    }
    return $resultData;
}

function dizSpecialSet($id)
{

    $set = false;

//    debug($id);

    $special_set = $_SESSION['special_set'];

//    debug($special_set);

    if (!empty($special_set))
        foreach ($special_set as $k => $v)
            if (is_array($v) && in_array($id, $v))
                switch ($k) {
                    case 'cart':
                        $set['cart'] = true;
                        break;
                }

    return $set;
}

function declination($num, $words = null)
{

//$num - количество
//$words = array($a, $b, $c);
//$a - множественное число (родительный падеж)
//$b - единственное число (именительный падеж)
//$c - множественное число (именительный падеж)


    if (!$words)
        $words = array('товаров', 'товар', 'товара');

    $i = $num % 100;

    if ($i >= 11 && $i <= 14) {
        $i = 0;
    } else {
        $i = ($i %= 10) < 5 ? ($i > 2 ? 2 : $i) : 0;
    }

    return ($words[$i]);
}

function iconv_deep($e1, $e2, $value)
{
    if (is_array($value)) {
        $item = null;
        foreach ($value as &$item) {
            $item = iconv_deep($e1, $e2, $item);
        }
        unset($item);
    } else {
        if (is_string($value))
            $value = mb_convert_encoding($value, $e2, $e1);
    }
    return $value;
}


function getRelated($productID)
{


    $result = array();

    $sql = '
            SELECT productID
            FROM ' . RELATED_PRODUCTS_TABLE . '
            WHERE Owner=' . $productID;

    $q = db_query($sql);

    while ($row = db_fetch_row($q)) {
        $result[] = $row['productID'];
    }


    return $result;
}

function getGallOffers($productID, $default_picture = 0)
{


    //offer gallery
    $sql = '
            SELECT
            photoID,
            filename
            FROM ' . PRODUCT_PICTURES . '
            WHERE productID=' . $productID . ' AND  photoID != ' . $default_picture;


    $pictures = db_query($sql);

    $result = array();

    while ($picture = db_fetch_row($pictures)) {
        if (!empty($picture['filename'])) {
            $result[] = $picture;
        }
    }

    return $result;
}

function getSelCat($categoryID)
{

    $sql = '
            SELECT DISTINCT
            categoryID,
            name,
            description,
            picture,
            allow_products_comparison
            FROM ' . CATEGORIES_TABLE . '
            WHERE categoryID=' . (int)$categoryID;

    $q = db_query($sql);

    $result = db_fetch_row($q);

    return $result;
}

function GetXValByName($extra, $name)
{

    if (!empty($extra) && !empty($name)) {
        foreach ($extra as $k => $v) {

            if ($v['name'] == $name && !empty($v['values_to_select'])) {
                $result = array();
                foreach ($v['values_to_select'] as $key => $val) {
                    $result[] = $val['option_value'];
                }
            }
        }
    }
    return $result;
}


function GetCartInfo()
{

// shopping cart brief info
//calculate shopping cart value
    $k = 0;
    $cnt = 0;


//taking products from database
    if (isset($_SESSION['log'])) {

        $sql = '
        SELECT
        itemID,
        Quantity
        FROM ' . SHOPPING_CARTS_TABLE . '
        WHERE customerID= ' . regGetIdByLogin($_SESSION['log']);

        $q = db_query($sql);


      //  unset($_SESSION['special_set']['cart']);


        while ($row = db_fetch_row($q)) {

            $sql = '
            SELECT DISTINCT
            productID
            FROM ' . SHOPPING_CART_ITEMS_TABLE . '
            WHERE itemID=' . $row['itemID'] .' LIMIT 1';

            $q1 = db_query($sql);

            $r1 = db_fetch_row($q1);

            if ($r1['productID']) {

              //  $_SESSION['special_set']['cart'][] = $r1['productID'];

                $variants = GetConfigurationByItemId($row['itemID']);
                $k += GetPriceProductWithOption($variants, $r1['productID']) * $row['Quantity'];
                $cnt += $row['Quantity'];
            }
        }
    } else {


        //...session vars
        if (isset($_SESSION['gids'])) {


           // $_SESSION['special_set']['cart'] = array_unique($_SESSION['gids']);

            for ($i = 0; $i < count($_SESSION['gids']); $i++) {


                if ($_SESSION['gids'][$i]) {


                    $sql = '
                    SELECT DISTINCT
                    Price
                    FROM ' . PRODUCTS_TABLE . '
                    WHERE productID=' . (int)$_SESSION['gids'][$i].' LIMIT 1';

                    $t = db_query($sql);

                    $rr = db_fetch_row($t);

                    $sum = $rr['Price'];


                    if (is_array($_SESSION['configurations'][$i]))
                        foreach ($_SESSION['configurations'][$i] as $vars) {


                            $sql = '
                        SELECT
                        price_surplus
                        FROM ' . PRODUCTS_OPTIONS_SET_TABLE . '
                        WHERE variantID=' . (int)$vars . ' AND productID=' . (int)$_SESSION['gids'][$i];


                            $q1 = db_query($sql);


                            $r1 = db_fetch_row($q1);
                            $sum += $r1['price_surplus'];
                        }


                    $k += $_SESSION['counts'][$i] * $sum;
                    $cnt += $_SESSION['counts'][$i];
                }
            }
        }
    }

    $title =($cnt > 1)?'Корзина':'Ваша корзина пуста';



    $result = array(
        'val' => $k,
        'shown' => show_price($k),
        'qty' => $cnt,
        'hint' => declination($cnt),
        'title' => $title
    );


    return $result;
}


?>