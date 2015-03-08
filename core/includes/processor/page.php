<?php


if (isset($_REQUEST['do']) && isset($_REQUEST['id']) && $_REQUEST['do'] == 'page') {


    require 'core/smarty/smarty.class.php';

    $smarty = new Smarty;
    $smarty->force_compile = CONF_SMARTY_FORCE_COMPILE;
    $smarty->template_dir = 'core/tpl/user/' . CONF_DEFAULT_TEMPLATE;


    $pageID = $_REQUEST['id'];

    $pages = array();
    $page = array();

    if ($pageID = 'help') {

        require 'core/includes/home.php';

//        $allow = array(5, 2, 3);
//
//        foreach ($allow as $key) {
//            $pages[$key] = getAuxPage($key);
//        }

        $pages[] = '1';

        $smarty->assign('pages', $pages);

    } else {

        $page = getAuxPage((int)$pageID);
    }


    if (!empty($page) || !empty($pages)) {


        $smarty->assign('page', $page);
        $smarty->display('page_ajax.tpl');


    } else {
        header("HTTP/1.0 404 Not Found");
        header("HTTP/1.1 404 Not Found");
        header("Status: 404 Not Found");
        die(ERROR_404_HTML);
        exit();
    }


}
?>