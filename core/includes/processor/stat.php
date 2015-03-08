<?php


$JsHttpRequest = & new JsHttpRequest(DEFAULT_CHARSET);

$GLOBALS['_RESULT'] = array(
    "tgenexe" => $_SESSION["tgenexe"],
    "tgencompile" => $_SESSION["tgencompile"],
    "tgendb" => $_SESSION["tgendb"],
    "tgenall" => $_SESSION["tgenall"],
    "tgensql" => $_SESSION["tgensql"]
);

?>