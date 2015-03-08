<?php


if (isset($_GET["activate"])) {
    $smarty->assign("activate_result", activate_order($_GET["activate"], $smarty_mail));
    $smarty->assign("activate_mode", 1);
    $smarty->assign("main_content_template", "activation_orders.tpl");
} elseif (isset($_GET["deactivate"])) {
    $smarty->assign("activate_result", deactivate_order($_GET["deactivate"], $smarty_mail));
    $smarty->assign("activate_mode", 2);
    $smarty->assign("main_content_template", "activation_orders.tpl");
}

?>