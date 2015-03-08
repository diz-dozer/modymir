<?php


// currency selection form

if (isset($_POST["current_currency"])) {
    currSetCurrentCurrency($_POST["current_currency"]);

    $url = "index.php";
    $paramGetVars = "";
    foreach ($_GET as $key => $value) {
        if ($paramGetVars == "")
            $paramGetVars .= "?" . $key . "=" . $value;
        else
            $paramGetVars .= "&" . $key . "=" . $value;
    }
    if (isset($_POST["InvId"])) {
        if ($paramGetVars == "")
            $paramGetVars .= "?InvId=" . $_POST["InvId"];
        else
            $paramGetVars .= "&InvId=" . $_POST["InvId"];
    }
    Redirect($url . $paramGetVars);
}

?>