<?php


// Helper for Robokassa
// Result Url - index.php?robokassa=result (POST method)
// Success Url - index.php?robokassa=success&transaction_result=success (POST method)
// Fail Url - index.php?transaction_result=failure (POST method)

if (isset($_REQUEST["robokassa"]) && isset($_REQUEST["SignatureValue"])) {
    $result = '';
    $orderID = (int)$_REQUEST["InvId"];
    $q = db_query("select paymethod  from " . ORDERS_TABLE . " where orderID=" . $orderID);
    $order = db_fetch_row($q);
    if ($order) {
        $paymentMethod = payGetPaymentMethodById($order["paymethod"]);
        $currentPaymentModule = modGetModuleObj($paymentMethod["module_id"], PAYMENT_MODULE);
        if ($currentPaymentModule != null) $result = $currentPaymentModule->after_payment_php($orderID, $_REQUEST["OutSum"], $_REQUEST["SignatureValue"], $_REQUEST["robokassa"]);

        if ($result != '' && $_REQUEST["robokassa"] == "result") die($result);
    }
}


// Helper for Webmoney (preresult)
// Result Url - index.php?webmoney=yes (POST method)
// Success Url - index.php?transaction_result=success (POST method)
// Fail Url - index.php?transaction_result=failure (POST method)
// Передавать параметры в предварительном запросе
// Не высылать Secret Key, если Result URL обеспечивает безопасность
// Не позволять использовать URL, передаваемые в форме
// Метод формирования контрольной подписи MD5

if (isset($_REQUEST["webmoney"]) && isset($_REQUEST["LMI_PREREQUEST"])) {
    $result = '';
    $orderID = (int)$_REQUEST["LMI_PAYMENT_NO"];
    $q = db_query("select paymethod  from " . ORDERS_TABLE . " where orderID=" . $orderID);
    $order = db_fetch_row($q);
    if ($order) {
        $paymentMethod = payGetPaymentMethodById($order["paymethod"]);
        $currentPaymentModule = modGetModuleObj($paymentMethod["module_id"], PAYMENT_MODULE);
        if ($currentPaymentModule != null) $result = $currentPaymentModule->before_payment_php($orderID, $_REQUEST["LMI_PAYMENT_AMOUNT"], $_REQUEST["LMI_PAYEE_PURSE"]);

        if ($result != '') die($result);
    }
}

// Helper for Webmoney (result)
// Result Url - index.php?webmoney=yes
// Success Url - index.php?transaction_result=success
// Fail Url - index.php?transaction_result=failure (POST method)
// Передавать параметры в предварительном запросе
// Не высылать Secret Key, если Result URL обеспечивает безопасность
// Не позволять использовать URL, передаваемые в форме
// Метод формирования контрольной подписи MD5

if (isset($_REQUEST["webmoney"]) && !isset($_REQUEST["LMI_PREREQUEST"])) {
    $orderID = (int)$_REQUEST["LMI_PAYMENT_NO"];
    $q = db_query("select paymethod  from " . ORDERS_TABLE . " where orderID=" . $orderID);
    $order = db_fetch_row($q);
    if ($order) {
        $paymentMethod = payGetPaymentMethodById($order["paymethod"]);
        $currentPaymentModule = modGetModuleObj($paymentMethod["module_id"], PAYMENT_MODULE);
        if ($currentPaymentModule != null) $result = $currentPaymentModule->after_payment_php($orderID, $_REQUEST);
    }
}


// Helper for Z-payment
// Result Url - index.php?zpayment=yes (POST method)
// Success Url - index.php?transaction_result=success (POST method)
// Fail Url - index.php?transaction_result=failure (POST method)
// Не высылать предварительный запрос перед оплатой на Result URL
// Не высылать Merchant Key, если Result URL обеспечивает безопасность

if (isset($_REQUEST["zpayment"])) {
    $result = '';
    $orderID = (int)$_REQUEST["LMI_PAYMENT_NO"];
    $q = db_query("select paymethod  from " . ORDERS_TABLE . " where orderID=" . $orderID);
    $order = db_fetch_row($q);
    if ($order) {
        $paymentMethod = payGetPaymentMethodById($order["paymethod"]);
        $currentPaymentModule = modGetModuleObj($paymentMethod["module_id"], PAYMENT_MODULE);
        if ($currentPaymentModule != null) $result = $currentPaymentModule->after_payment_php($orderID, $_REQUEST);
        if ($result != '') die($result);
    }
}

?>
