<?php


if (isset($_REQUEST['do']) && isset($_REQUEST['id']) && $_REQUEST['do'] == 'look') {


    require 'core/smarty/smarty.class.php';
    $smarty = new Smarty;
    $smarty->force_compile = CONF_SMARTY_FORCE_COMPILE;
    $smarty->template_dir = "core/tpl/user/" . CONF_DEFAULT_TEMPLATE;


    $productID = (int)$_REQUEST['id'];

    if (!empty($productID)) {

        //# of selected currency
        $current_currency = isset($_SESSION["current_currency"]) ? $_SESSION["current_currency"] : CONF_DEFAULT_CURRENCY;

        $sql = '
        SELECT DISTINCT
        code,
        currency_value,
        where2show,
        currency_iso_3,
        Name,
        roundval
        FROM ' . CURRENCY_TYPES_TABLE . '
        WHERE CID=' . (int)$current_currency . '
        LIMIT 1';

        $q = db_query($sql);


        if ($row = db_fetch_row($q)) {

            $selected_currency_details = $row; //for show_price() function\

        } else { //no currency found. In this case check is there any currency type in the database


            $sql = '
            SELECT
            code,
            currency_value,
            where2show,
            roundval
            FROM ' . CURRENCY_TYPES_TABLE;

            $q = db_query($sql);


            if ($row = db_fetch_row($q)) {
                $selected_currency_details = $row; //for show_price() function
            }
        }


        $product = GetProduct($productID);

        unset($product['thumbs']);

    }


    if (!$product || $product['enabled'] == 0) {

        header('HTTP/1.0 404 Not Found');
        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        die(ERROR_404_HTML);

    } else {

        $smarty->assign('product', $product);
    }

    $smarty->display('product_look.tpl');

} else {
    header("HTTP/1.0 404 Not Found");
    header("HTTP/1.1 404 Not Found");
    header("Status: 404 Not Found");
    die(ERROR_404_HTML);
    exit();
}



?>