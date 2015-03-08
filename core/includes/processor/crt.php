<?php

if (isset($_GET["do"]) && $_GET["do"] === 'crt') {


    $id = (int)$_GET['id'];
    $qty = (int)$_GET['qty'];


    if (!empty($id)) {

        if (empty($qty))
            $qty = 1;

        for ($i = 0; $i < $qty; $i++) {
            cartAddToCart($id, array());
        }


        $cart = cartGetCartContent();

        if (!empty($cart['cart_content'])) {

            $qty = 0;
            foreach ($cart['cart_content'] as $k => $v) {
                (int)$qty += $v['quantity'];
            }

            $_SESSION['special_set']['cart'][] = $id;
        }


        $response = array(
            'sc_qty' => $qty,
            'sc_val' => show_price($cart['total_price'], 1),
            'sc_hint' => declination($qty)
        );

        echo json_encode($response);

//        echo json_encode(iconv_deep('windows-1251', 'utf-8', $response));
    }
    exit();
}
?>