<?php

// compare two configuration
function CompareConfiguration($variants1, $variants2)
{
    if (count($variants1) != count($variants2))
        return false;

    foreach ($variants1 as $variantID) {
        $count1 = 0;
        $count2 = 0;

        for ($i = 0; $i < count($variants1); $i++)
            if ((int)$variants1[$i] == (int)$variantID)
                $count1++;

        for ($i = 0; $i < count($variants1); $i++)
            if ((int)$variants2[$i] == (int)$variantID)
                $count2++;

        if ($count1 != $count2)
            return false;
    }
    return true;
}

// search configuration in session variable
function SearchConfigurationInSessionVariable($variants, $productID)
{
    foreach ($_SESSION['configurations'] as $key => $value) {
        if ((int)$_SESSION['gids'][$key] != (int)$productID)
            continue;
        if (CompareConfiguration($variants, $value))
            return $key;
    }
    return -1;
}

// search configuration in database
function SearchConfigurationInDataBase($variants, $productID)
{
    $q = db_query('select itemID from ' . SHOPPING_CARTS_TABLE .
        ' where customerID=' . (int)regGetIdByLogin($_SESSION['log']));
    while ($r = db_fetch_row($q)) {
        $q1 = db_query('select COUNT(*) from ' . SHOPPING_CART_ITEMS_TABLE .
            ' where productID=' . (int)$productID . ' AND itemID=' . (int)$r['itemID']);
        $r1 = db_fetch_row($q1);
        if ($r1[0] != 0) {
            $variants_from_db = GetConfigurationByItemId($r['itemID']);
            if (CompareConfiguration($variants, $variants_from_db))
                return $r['itemID'];
        }
    }
    return -1;
}

function GetConfigurationByItemId($itemID)
{
    $q = db_query('select variantID from ' .
        SHOPPING_CART_ITEMS_CONTENT_TABLE . ' where itemID=' . (int)$itemID);
    $variants = array();
    while ($r = db_fetch_row($q))
        $variants[] = $r['variantID'];
    return $variants;
}

function InsertNewItem($variants, $productID)
{

    $sql = '
        INSERT INTO ' . SHOPPING_CART_ITEMS_TABLE . '
        SET productID = ' . (int)$productID;

    db_query($sql);


    $itemID = db_insert_id();

    if (is_array($variants))
        foreach ($variants as $vars) {

            $sql = '
            INSERT INTO  ' . SHOPPING_CART_ITEMS_CONTENT_TABLE . '
            SET
            itemID = ' . (int)$itemID . ',
            variantID = ' . (int)$vars;

            db_query($sql);
        }

    return $itemID;
}

function InsertItemIntoCart($itemID)
{

    $sql = '
        INSERT INTO  ' . SHOPPING_CARTS_TABLE . '
        SET 
        customerID = ' . (int)regGetIdByLogin($_SESSION['log']) . ',
        itemID = ' . (int)$itemID . ',
        Quantity=1';

    db_query($sql);
}

function GetStrOptions($variants)
{
    $first_flag = true;
    $res = '';

    if (is_array($variants))
        foreach ($variants as $vars) {

            $sql = '
            SELECT
            option_value
            FROM ' . PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE . '
            WHERE variantID=' . (int)$vars;

            $q = db_query($sql);

            if ($r = db_fetch_row($q)) {

                if ($first_flag) {
                    $res .= $r['option_value'];
                    $first_flag = false;
                } else
                    $res .= ', ' . $r['option_value'];
            }
        }
    return $res;
}

function CodeItemInClient($variants, $productID)
{
    $array = array();
    $array[] = $productID;
    if (is_array($variants))
        foreach ($variants as $var) {
            $array[] = $var;
        }
    return implode('_', $array);
}

function DeCodeItemInClient($str)
{
    // $variants, $productID
    $array = explode('_', $str);
    $productID = $array[0];
    $variants = array();
    for ($i = 1; $i < count($array); $i++)
        $variants[] = $array[$i];
    $res = array();
    $res['productID'] = $productID;
    $res['variants'] = $variants;
    return $res;
}

function GetProductInStockCount($productID)
{

    $sql = '
        SELECT
        in_stock
        FROM ' . PRODUCTS_TABLE . '
        WHERE productID=' . (int)$productID;


    $q = db_query($sql);
    $is = db_fetch_row($q);
    return $is['in_stock'];
}

function GetPriceProductWithOption($variants, $productID)
{


    $sql = '
        SELECT
        Price
        FROM ' . PRODUCTS_TABLE . '
        WHERE productID=' . (int)$productID;


    $q = db_query($sql);

    $r = db_fetch_row($q);
    $base_price = (float)$r['Price'];
    $full_price = (float)$base_price;

    if (is_array($variants))
        foreach ($variants as $vars) {

            $sql = '
            SELECT
            price_surplus
            FROM ' . PRODUCTS_OPTIONS_SET_TABLE . '
            WHERE productID=' . (int)$productID . ' AND variantID=' . (int)$vars;

            $q1 = db_query($sql);

            $r1 = db_fetch_row($q1);
            $full_price += $r1['price_surplus'];
        }
    return $full_price;
}

function GetProductIdByItemId($itemID)
{


    $sql = '
        SELECT
        productID
        FROM ' . SHOPPING_CART_ITEMS_TABLE . '
        WHERE itemID=' . (int)$itemID;

    $q = db_query($sql);
    $r = db_fetch_row($q);
    return $r['productID'];
}

function cartMoveContentFromShoppingCartsToOrderedCarts($orderID, $shippingMethodID, $paymentMethodID, $shippingAddressID, $billingAddressID, $shippingModuleFiles, $paymentModulesFiles, &$smarty_mail)
{


    $sql = '
        SELECT
        statusID
        FROM ' . ORDERS_TABLE . '
        WHERE orderID=' . (int)$orderID;

    $q = db_query($sql);

    $order = db_fetch_row($q);
    $statusID = $order['statusID'];

    // select all items from SHOPPING_CARTS_TABLE


    $sql = '
        SELECT
        itemID,
        Quantity
        FROM ' . SHOPPING_CARTS_TABLE . '
        WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']);


    $q_items = db_query($sql);

    while ($item = db_fetch_row($q_items)) {
        $productID = GetProductIdByItemId($item['itemID']);
        if ($productID == null || trim($productID) == '')
            continue;

        // get product by ID


        $sql = '
            SELECT
            name,
            product_code
            FROM ' . PRODUCTS_TABLE . '
            WHERE productID=' . (int)$productID;

        $q_product = db_query($sql);
        $product = db_fetch_row($q_product);

        // get full product name ( complex product name - $productComplexName ) -
        // name with configurator options
        $variants = GetConfigurationByItemId($item['itemID']);
        $options = GetStrOptions($variants);

        if ($options != '')
            $productComplexName = $product['name'] . '(' . $options . ')';
        else
            $productComplexName = $product['name'];

        if (strlen($product['product_code']) > 0)
            $productComplexName = '[' . $product['product_code'] . '] ' . $productComplexName;

        //
        $price = GetPriceProductWithOption($variants, $productID);
        $tax = taxCalculateTax($productID, $shippingAddressID, $billingAddressID);


        $sql = '
            INSERT INTO ' . ORDERED_CARTS_TABLE . '
            SET
            itemID = ' . (int)$item['itemID'] . ',
            orderID=' . (int)$orderID . ',
            name = "' . xEscSQL($productComplexName) . '",
            Price = "' . xEscSQL($price) . '",
            Quantity = ' . (int)$item['Quantity'] . ',
            tax="' . xEscSQL($tax) . '"';

        db_query($sql);


        if ($statusID != ostGetCanceledStatusId() && CONF_CHECKSTOCK) {


            $sql = '
                UPDATE ' . PRODUCTS_TABLE . '
                SET in_stock = in_stock - ' . (int)$item['Quantity'] . '
                WHERE productID=' . (int)$productID;

            db_query($sql);

            $sql = '
                SELECT
                name,
                in_stock
                FROM ' . PRODUCTS_TABLE . '
                WHERE productID=' . (int)$productID;

            $q = db_query($sql);


            $productsta = db_fetch_row($q);
            if ($productsta['in_stock'] == 0) {
                if (CONF_AUTOOFF_STOCKADMIN) {

                    $sql = '
                        UPDATE ' . PRODUCTS_TABLE . '
                        SET enabled=0
                        WHERE productID=' . (int)$productID;

                    db_query($sql);
                }

                if (CONF_NOTIFY_STOCKADMIN) {
                    $smarty_mail->assign('productstaname', $productsta['name']);
                    $smarty_mail->assign('productstid', $productID);
                    $stockadmin = $smarty_mail->fetch('notify_stockadmin.tpl');
                    $ressta = xMailTxtHTMLDATA(CONF_ORDERS_EMAIL, CUSTOMER_ACTIVATE_99, $stockadmin);
                }
            }
        }
    }

    db_query('DELETE FROM ' . SHOPPING_CARTS_TABLE . ' WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']));
}

function cartClearCartContet()
{

    if (isset($_SESSION['log'])) {

        db_query('DELETE FROM ' . SHOPPING_CARTS_TABLE . ' WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']));
    } else {
        unset($_SESSION['gids']);
        unset($_SESSION['counts']);
        unset($_SESSION['configurations']);

        session_unregister('gids'); //calling session_unregister() is required since unset() may not work on some systems
        session_unregister('counts');
        session_unregister('configurations');
    }


    unset($_SESSION['special_set']);
}

function cartGetCartContent()
{


    $cart_content = array();
    $total_price = 0;
    $freight_cost = 0;


    if (isset($_SESSION['log'])) { //get cart content from the database
        $sql = '
            SELECT
            itemID,
            Quantity
            FROM ' . SHOPPING_CARTS_TABLE . '
            WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']);

        $q = db_query($sql);

        while ($cart_item = db_fetch_row($q)) {

            // get variants
            $variants = GetConfigurationByItemId($cart_item['itemID']);


            // shopping cart item
            $sql = '
               SELECT
               productID
               FROM ' . SHOPPING_CART_ITEMS_TABLE . '
               WHERE itemID=' . (int)$cart_item['itemID'];

            $q_shopping_cart_item = db_query($sql);

            $shopping_cart_item = db_fetch_row($q_shopping_cart_item);

            $sql = '
                SELECT
                p.name,
                p.Price,
                p.productID,
                p.min_order_amount,
                p.shipping_freight,
                p.free_shipping,
                p.product_code,
                p.categoryID,
                t.filename AS picture
                FROM ' . PRODUCTS_TABLE . ' AS p
                LEFT JOIN ' . PRODUCT_PICTURES . ' AS t ON (p.default_picture=t.photoID AND p.productID=t.productID)
                WHERE p.productID=' . (int)$shopping_cart_item['productID'];


            $q_products = db_query($sql);


            if ($product = db_fetch_row($q_products)) {

                $costUC = GetPriceProductWithOption($variants, $shopping_cart_item['productID']);


                $tmp = array(
                    'picture' => $product['picture'],
                    'productID' => $product['productID'],
                    'categoryID' => $product['categoryID'],
                    'id' => $cart_item['itemID'],
                    'name' => $product['name'],
                    'quantity' => $cart_item['Quantity'],
                    'free_shipping' => $product['free_shipping'],
                    'price' => show_price($costUC),
                    'costUC' => $costUC,
                    'cost' => show_price($cart_item['Quantity'] * GetPriceProductWithOption($variants, $shopping_cart_item['productID'])),
                    'product_code' => $product['product_code']);


                $freight_cost += $cart_item['Quantity'] * $product['shipping_freight'];

                $strOptions = GetStrOptions(
                    GetConfigurationByItemId($tmp['id']));

                if (trim($strOptions) != '') {
                    $tmp['name'] .= '  (' . $strOptions . ')';
                }


                if ($product['min_order_amount'] > $cart_item['Quantity'])
                    $tmp['min_order_amount'] = $product['min_order_amount'];


                $cart_content[] = $tmp;
                $total_price += $cart_item['Quantity'] * GetPriceProductWithOption($variants, $shopping_cart_item['productID']);
            }
        }
    } else { //unauthorized user - get cart from session vars
        $total_price = 0; //total cart value
        $cart_content = array();


        //shopping cart items count
        if (isset($_SESSION['gids']))
            for ($j = 0; $j < count($_SESSION['gids']); $j++) {


                $id = (int)$_SESSION['gids'][$j];


                if (!empty($id)) {


                    $session_items[] = CodeItemInClient($_SESSION['configurations'][$j], $id);


                    $sql = '
                        SELECT
                        p.productID,
                        p.name,
                        p.Price,
                        p.shipping_freight,
                        p.free_shipping,
                        p.product_code,
                        p.categoryID,
                        t.filename AS picture
                        FROM ' . PRODUCTS_TABLE . ' AS p
                        LEFT JOIN ' . PRODUCT_PICTURES . ' AS t ON (p.default_picture=t.photoID AND p.productID=t.productID)
                        WHERE p.productID=' . $id;


                    $q = db_query($sql);

                    if ($r = db_fetch_row($q)) {

                        /* $_SESSION['counts'][$j] */

                        $costUC = GetPriceProductWithOption($_SESSION['configurations'][$j], $id);

                        if (count($_SESSION['configurations'][$j]) > 0) {
                            for ($tmp1 = 0; $tmp1 < count($_SESSION['configurations'][$j]); $tmp1++) {
                                $id .= '_' . (int)$_SESSION['configurations'][$j][$tmp1];
                            }
                        }

                        $tmp = array(
                            'picture' => $r['picture'],
                            'productID' => $r['productID'],
                            'categoryID' => $r['categoryID'],
                            'id' => $id,
                            'name' => $r['name'],
                            'quantity' => $_SESSION['counts'][$j],
                            'free_shipping' => $r['free_shipping'],
                            'costUC' => $costUC,
                            'price' =>  show_price($costUC),
                            'cost' => show_price($costUC * $_SESSION['counts'][$j]),
                            'product_code' => $r['product_code']);

                        $strOptions = GetStrOptions($_SESSION['configurations'][$j]);


                        if (trim($strOptions) != '') {
                            $tmp['name'] .= '  (' . $strOptions . ')';
                        }


                        $sql = '
                            SELECT
                            min_order_amount,
                            shipping_freight,
                            categoryID
                            FROM ' . PRODUCTS_TABLE . '
                            WHERE productID=' . (int)$id;

                        $q_product = db_query($sql);

                        $product = db_fetch_row($q_product);

                        if ($product['min_order_amount'] > $_SESSION['counts'][$j]) {
                            $tmp['min_order_amount'] = $product['min_order_amount'];
                        }


                        $freight_cost += $_SESSION['counts'][$j] * $product['shipping_freight'];

                        $cart_content[] = $tmp;

                        $total_price += GetPriceProductWithOption($_SESSION['configurations'][$j], $id) * $_SESSION['counts'][$j];
                    }
                }
            }
    }

    return array(
        'cart_content' => $cart_content,
        'total_price' => $total_price,
        'freight_cost' => $freight_cost);
}

function cartCheckMinOrderAmount()
{


    $cart_content = cartGetCartContent();
    $cart_content = $cart_content['cart_content'];

    foreach ($cart_content as $cart_item)
        if (isset($cart_item['min_order_amount']))
            return false;
    return true;
}

function cartCheckMinTotalOrderAmount()
{

    $res = cartGetCartContent();

    $d = oaGetDiscountPercent($res, '');
    $order['order_amount'] = $res['total_price'] - ($res['total_price'] / 100) * $d;


    if ($order['order_amount'] < CONF_MINIMAL_ORDER_AMOUNT) {
        return false;
    } else {
        return true;
    }
}

function cartAddToCart($productID, $variants)
{

    $is = GetProductInStockCount($productID);


    $sql = '
        SELECT
        min_order_amount as min
        FROM ' . PRODUCTS_TABLE . '
        WHERE productID=' . (int)$productID;


    $q = db_query($sql);


    $min_order_amount = db_fetch_assoc($q);
    $min_order_amount = $min_order_amount['min'];

    $count_to_order = 1;


    if (!isset($_SESSION['log'])) { //save shopping cart in the session variables
        //$_SESSION['gids'] contains product IDs
        //$_SESSION['counts'] contains product quantities
        //                        ($_SESSION['counts'][$i] corresponds to $_SESSION['gids'][$i])
        //$_SESSION['configurations'] contains variants
        //$_SESSION[gids][$i] == 0 means $i-element is 'empty'


        if (!isset($_SESSION['gids'])) {
            $_SESSION['gids'] = array();
            $_SESSION['counts'] = array();
            $_SESSION['configurations'] = array();
        }

        //check for current item in the current shopping cart content
        $item_index = SearchConfigurationInSessionVariable($variants, $productID);

        if ($item_index == -1)
            $count_to_order = $min_order_amount;

        if ($item_index != -1) { //increase current product's quantity
            if (CONF_CHECKSTOCK == 0 || $_SESSION['counts'][$item_index] + $count_to_order <= $is)
                $_SESSION['counts'][$item_index] += $count_to_order;
            else {
                return false;
            }
        } else if (CONF_CHECKSTOCK == 0 || $is >= $count_to_order) { //no item - add it to $gids array
            $_SESSION['gids'][] = $productID;
            $_SESSION['counts'][] = $count_to_order;
            $_SESSION['configurations'][] = $variants;
        } else {
            return false;
        }


    } else { //authorized customer - get cart from database
        $itemID = SearchConfigurationInDataBase($variants, $productID);

        if ($itemID != -1) { // if this configuration exists in database
            $sql = '
                SELECT
                Quantity
                FROM ' . SHOPPING_CARTS_TABLE . '
                WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']) . ' AND itemID=' . (int)$itemID;


            $q = db_query($sql);

            $row = db_fetch_row($q);
            $quantity = $row['Quantity'];
            if (CONF_CHECKSTOCK == 0 || $quantity + $count_to_order <= $is) {

                $sql = '
                    UPDATE ' . SHOPPING_CARTS_TABLE . '
                    SET Quantity=' . (int)($row[0] + $count_to_order) . '
                    WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']) . ' AND itemID=' . (int)$itemID;

                db_query($sql);
            } else {
                return false;
            }
        } else { //insert new item
            $count_to_order = $min_order_amount;

            if (CONF_CHECKSTOCK == 0 || $is >= $count_to_order) {


                $itemID = InsertNewItem($variants, $productID);
                InsertItemIntoCart($itemID);

                $sql = '
                    UPDATE ' . SHOPPING_CARTS_TABLE . '
                    SET Quantity=' . (int)$count_to_order . '
                    WHERE customerID=' . (int)regGetIdByLogin($_SESSION['log']) . ' AND itemID=' . (int)$itemID;

                db_query($sql);
            } else
                return false;
        }
    }


    return true;
}

function cartCartIsEmpty($log)
{
    $customerID = regGetIdByLogin($log);
    if ((int)$customerID > 0) {
        $customerID = (int)$customerID;

        $sql = '
            SELECT count(*)
            FROM ' . SHOPPING_CARTS_TABLE . '
            WHERE customerID=' . (int)$customerID;

        $q_count = db_query($sql);

        $count = db_fetch_row($q_count);
        $count = $count[0];

        return ($count == 0);
    } else
        return true;
}

?>
