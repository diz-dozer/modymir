<?php

if (!empty($productID)) {


    $product = GetProduct($productID);

    if (!$product || $product['enabled'] == 0) {

        header('HTTP/1.0 404 Not Found');
        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        die(ERROR_404_HTML);

    } else {

        IncrementProductViewedTimes($productID);


        //    $smarty->assign('related', getOffers(getRelated($productID)));

        $smarty->assign('product', $product);
        $smarty->assign('selected_category', getSelCat($product['categoryID']));
        $smarty->assign('main_content_template', 'product_detailed.tpl');


//        fb($product);


    }
}


?>