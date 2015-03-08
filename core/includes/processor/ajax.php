<?php

if (isset($_REQUEST['g'])) {


    include_once('core/classes/diz.form.class.php');
    include_once('core/classes/gump.class.php');
    include_once('core/classes/class.simple_mail.php');




    $form = new \Diz\Form($_REQUEST['g']);

    if ($form) {

        $form->response();

        exit();

    } else {
        header("HTTP/1.0 404 Not Found");
        header("HTTP/1.1 404 Not Found");
        header("Status: 404 Not Found");
        die(ERROR_404_HTML);
        exit();
    }

}
?>