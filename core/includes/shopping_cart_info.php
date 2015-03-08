<?php


//$smarty->assign('shopping_cart_value', $k);
//$smarty->assign('shopping_cart_value_shown', show_price($k));
//$smarty->assign('shopping_cart_items', $cnt);





$smarty->assign('sc',GetCartInfo());




if (isset($_REQUEST['add2cart'])) {


    $qty = (int)$_REQUEST['qty'];
    $offerID = (int)$_REQUEST['offerID'];
    $variants = array();

    if ($qty > 0 && !empty($offerID)) {


        foreach ($_REQUEST as $key => $val) {
            if (strstr($key, 'opt_'))
                $variants[] = $val;
        }

        unset($_SESSION['variants']);

        $_SESSION['variants'] = $variants;

        for ($i = 0; $i < $qty; $i++) {
            cartAddToCart($offerID, $variants);
        }


    }

    if ($_REQUEST['ajx']) {
        echo json_encode(GetCartInfo());
        exit();
    } else {
        redirect('cart.html');
    }


}

?>