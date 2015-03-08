<?php

setlocale(LC_ALL, 'ru_RU.utf8');

define('ERROR_DB_INIT', 'Database connection problem!');

function gmts()
{
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

$sc_1 = gmts();
$sc_4 = 0;
$sc_8 = 0;
$gmc = 1;

include('core/config/init.php');
include('core/includes/database/mysql.php');

$far_1 = array(
    'core/config/connect.inc.php',
    'core/config/language_list.php',
    'core/classes/class.ajax.php',
    'core/classes/class.kcaptcha.php',
    'core/classes/class.xml2array.php',
    'core/classes/class.virtual.paymentmodule.php',
    'core/classes/class.virtual.shippingratecalculator.php'
);

$far_2 = glob("core/functions/*.php");
$far = array_merge($far_1, $far_2);

$cfar = count($far);
if (file_exists("core/cache/fcache.php"))
    include("core/cache/fcache.php");
else
    for ($n = 0; $n < $cfar; $n++)
        include($far[$n]);

define('PATH_DELIMITER', isWindows() ? ';' : ':');

$_POST = xStripSlashesGPC($_POST);
$_GET = xStripSlashesGPC($_GET);
$_COOKIE = xStripSlashesGPC($_COOKIE);

db_connect(DB_HOST, DB_USER, DB_PASS) or die(ERROR_DB_INIT);
db_select_db(DB_NAME) or die(db_error());

settingDefineConstants();

include("core/config/headers.php");
include("core/config/error_handler.php");

function set_cookie($Name, $Value = '', $Expires = '', $Secure = false, $Path = '', $Domain = '', $HTTPOnly = false)
{
    header('Set-Cookie: ' . rawurlencode($Name) . '=' . rawurlencode($Value)
        . (empty($Expires) ? '' : '; expires=' . gmdate('D, d-M-Y H:i:s', $Expires) . ' GMT')
        . (empty($Path) ? '' : '; path=' . $Path)
        . (empty($Domain) ? '' : '; domain=' . $Domain)
        . (!$Secure ? '' : '; secure')
        . (!$HTTPOnly ? '' : '; HttpOnly'), false);
}

# стартуем сессию
define("SECURITY_EXPIRE", 60 * 60 * CONF_SECURITY_EXPIRE);
session_set_save_handler("sess_open", "sess_close", "sess_read", "sess_write", "sess_destroy", "sess_gc");
session_start();

# посылаем cookie сессии
if (isset($_COOKIE["PHPSESSID"])) {
    if (SECURITY_EXPIRE > 0) {
        set_cookie("PHPSESSID", $_COOKIE["PHPSESSID"], time() + SECURITY_EXPIRE);
    } else {
        set_cookie("PHPSESSID", $_COOKIE["PHPSESSID"]);
    }
}

/*
  //select a new language?
  if (isset($_POST["lang"]))
  $_SESSION["current_language"] = $_POST["lang"];


  //current language session variable
  if (!isset($_SESSION["current_language"]) || $_SESSION["current_language"] < 0 || $_SESSION["current_language"] > count($lang_list))
  $_SESSION["current_language"] = 0; //set default language
 */

$_SESSION["current_language"] = 0;

//include a language file
if (isset($lang_list[$_SESSION["current_language"]]) && file_exists("core/languages/" . $lang_list[$_SESSION["current_language"]]->filename)) {
    //include current language file
    include("core/languages/" . $lang_list[$_SESSION["current_language"]]->filename);
} else {
    die("<font color=red><b>ERROR: Couldn't find language file!</b></font>");
}

if (isset($_GET["do"])) {


    $do_inc = array(
        'captcha',
        'cart',
        'rss',
        'compare',
        'yandex',
        'invoice_jur',
        'invoice_phys',
        'stat',
        'get_file',
        'ajax',
        'crt',
        'look',
        'page'
    );

    if (in_array($_GET["do"], $do_inc)) {
        include("core/includes/processor/" . $_GET["do"] . ".php");
    } else {

        header("HTTP/1.0 404 Not Found");
        header("HTTP/1.1 404 Not Found");
        header("Status: 404 Not Found");
        die(ERROR_404_HTML);
    }
} else {

    //init Smarty
    require("core/smarty/smarty.class.php");
    $smarty = new Smarty; //core smarty object
    $smarty_mail = new Smarty; //for e-mails

    if ((int)CONF_SMARTY_FORCE_COMPILE) { //this forces Smarty to recompile design each time someone runs index.php
        $smarty->force_compile = true;
        $smarty_mail->force_compile = true;
    }

    $relaccess = checklogin();


    //# of selected currency
    $current_currency = isset($_SESSION["current_currency"]) ? $_SESSION["current_currency"] : CONF_DEFAULT_CURRENCY;

    $smarty->assign("current_currency", $current_currency);

    $sql = '
        SELECT
        code,
        currency_value,
        where2show,
        currency_iso_3,
        Name,
        roundval
        FROM ' . CURRENCY_TYPES_TABLE . '
        WHERE CID=' . (int)$current_currency;

    $q = db_query($sql);


    if ($row = db_fetch_row($q)) {

        $smarty->assign("currency_name", $row['code']);
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
            $smarty->assign("currency_name", $row['code']);
            $selected_currency_details = $row; //for show_price() function
        }
    }


    $smarty->assign("currency_roundval", $selected_currency_details["roundval"]);


    $currency_data = 'data-cr ="' . $selected_currency_details['roundval'] . '" data-cc ="' . $selected_currency_details['code'] . '" data-cs ="' . $selected_currency_details['where2show'] . '"';
    $smarty->assign('currency_data', $currency_data);

    $pageID = 'home';

    $set_var = array(
        'categoryID',
        'productID',
        'register',
        'update_details',
        'order',
        'order_without_billing_address',
        'check_order',
        'proceed_ordering',
        'update_customer_info',
        'show_aux_page',
        'address_editor',
        'add_new_address',
        'contact_info',
        'order_detailed',
        'p_order_detailed',
        'fullnews',
        'affiliate',
        'add_new_address',
        'address_editor',
        'order_detailed'
    );


    foreach ($set_var as $k) {
        if (isset($_GET[$k]) || isset($_POST[$k])) {
            $$k = isset($_GET[$k]) ? (int)$_GET[$k] : (int)$_POST[$k];
            $pageID = $k;
        }
    }


    $set_var_ture = array(
        'visit_history',
        'order_history',
        'address_book',
        'change_address',
        'comparison_products',
        'register_authorization',
        'page_not_found',
        'news',
        'quick_register',
        'shopping_cart',
        'order2_shipping_quick',
        'order3_billing_quick',
        'order4_confirmation_quick',
        'order2_shipping',
        'order3_billing',
        'order4_confirmation',
        'user_details',
        'feedback'
    );

    foreach ($set_var_ture as $k) {
        if (isset($_GET[$k]) || isset($_POST[$k])) {
            $$k = 1;
            $pageID = $k;
        }
    }


    if (!empty($productID)) { //to rollout categories navigation table
        $sql = '
            SELECT DISTINCT categoryID, name
            FROM ' . PRODUCTS_TABLE . '
            WHERE productID= ' . $productID;

        $q = db_query($sql);

        while ($row = db_fetch_row($q)) {
            if ($row['categoryID']) {
                $categoryID = $row['categoryID'];
                $page_name = $row['name'];
            }
        }
    }


    if (!isset($_SESSION["vote_completed"]))
        $_SESSION["vote_completed"] = array();

    //checking for proper $offset init
    $offset = isset($_GET["offset"]) ? $_GET["offset"] : 0;
    if ($offset < 0 || $offset % CONF_PRODUCTS_PER_PAGE)
        $offset = 0;


    if (isset($_POST["change_design"]))
        $_SESSION['CUSTOM_DESIGN'] = $_POST["change_design"];

    if (isset($_SESSION["CUSTOM_DESIGN"])) {
        $smarty->template_dir = "core/tpl/user/" . $_SESSION["CUSTOM_DESIGN"];
        define('TPL', $_SESSION["CUSTOM_DESIGN"]);
    } else {
        $smarty->template_dir = "core/tpl/user/" . CONF_DEFAULT_TEMPLATE;
        define('TPL', CONF_DEFAULT_TEMPLATE);
    }

    $smarty_mail->template_dir = "core/tpl/email";

    //fetch currency types from database

    $sql = '
        SELECT
        CID,
        Name,
        code,
        currency_value,
        where2show,
        roundval,
        currency_iso_3
        FROM ' . CURRENCY_TYPES_TABLE . '
        ORDER BY sort_order';


    $q = db_query($sql);

    $currencies = array();

    while ($row = db_fetch_row($q)) {
        $currencies[] = $row;
    }


    $smarty->assign('currencies', $currencies);
    $smarty->assign('currencies_count', count($currencies));

    $smarty->assign('lang_list', $lang_list);

    if (isset($_SESSION['current_language']))
        $smarty->assign('current_language', $_SESSION['current_language']);

    if (isset($_SESSION['log']))
        $smarty->assign('log', $_SESSION['log']);

    // - following vars are used as hidden in the customer survey form
    if (isset($categoryID))
        $smarty->assign('categoryID', $categoryID);

    if (isset($productID))
        $smarty->assign('productID', $productID);

    if (isset($_GET['currency']))
        $smarty->assign('currency', $_GET['currency']);

    if (isset($_GET['user_details']))
        $smarty->assign('user_details', $_GET['user_details']);

    if (isset($_GET['aux_page']))
        $smarty->assign('aux_page', $_GET['aux_page']);

    if (isset($_GET['show_price']))
        $smarty->assign('show_price', $_GET['show_price']);

    if (isset($_GET['searchstring']))
        $smarty->hassign('searchstring', $_GET['searchstring']);

    if (isset($register))
        $smarty->assign('register', $register);

    if (isset($order))
        $smarty->assign('order', $order);

    if (isset($check_order))
        $smarty->assign('check_order', $check_order);

    //set defualt main_content template to homepage
    $smarty->assign('main_content_template', 'home.tpl');

    //catalog

    $sql = '
       SELECT
       categoryID,
       name,
       products_count,
       products_count_admin,
       parent,
       picture,
       subcount
       FROM ' . CATEGORIES_TABLE . '
       ORDER BY sort_order, name';


    $q = db_query($sql);

    $fc = array(); //parents
    $mc = array(); //parents
    while ($row = db_fetch_row($q)) {
        $fc[(int)$row['categoryID']] = $row;
        $mc[(int)$row['categoryID']] = (int)$row['parent'];
    }

    $cats = catGetCategoryCListMin();

    //include all .php files from core/includes/ dir or from cache
    if ((int)CONF_SMARTY_FORCE_COMPILE) {

        if (file_exists("core/cache/incache.php"))
            unlink("core/cache/incache.php");

        if (file_exists("core/cache/fcache.php"))
            unlink("core/cache/fcache.php");

        $fls = glob("core/includes/*.php");
        $cfls = count($fls);
        for ($zc = 0; $zc < $cfls; $zc++) {
            include($fls[$zc]);
        }
    } else {

        if (file_exists("core/cache/incache.php")) {
            include("core/cache/incache.php");
        } else {

            ob_start();

            for ($n = 0; $n < $cfar; $n++) {
                readfile($far[$n]);
            }

            $_res = ob_get_contents();
            ob_end_clean();


            $fh = fopen("core/cache/fcache.php", 'w');
            fwrite($fh, $_res);
            fclose($fh);
            unset($_res);

            $fls = glob("core/includes/*.php");
            $cfls = count($fls);
            ob_start();

            for ($i = 0; $i < $cfls; $i++) {
                readfile($fls[$i]);
            }

            $_res = ob_get_contents();
            ob_end_clean();

            $fh = fopen("core/cache/incache.php", 'w');

            fwrite($fh, $_res);
            fclose($fh);

            unset($_res);

            include('core/cache/incache.php');
        }
    }

    //show admin a administrative mode link
    if (!empty($relaccess) && in_array(100, $relaccess)) {
        $smarty->assign("isadmin", "yes");
        $adminislog = true;
    } else {
        $adminislog = false;
    }


//    $exploerrors = "";
//
//    if (file_exists("install.php"))
//        $exploerrors .= WARNING_DELETE_INSTALL_PHP;
//
//    if (!is_writable("core/cache"))
//        die(WARNING_WRONG_CHMOD);
//
//    $RGLBLS = @ini_get('register_globals');
//    if (strtolower($RGLBLS) == "on" || (int)$RGLBLS == 1)
//        die(WARNING_REGISTER_GLOBALS);
//
//    $smarty->assign("exploerrors", $exploerrors);


    $template = $smarty->get_template_vars('main_content_template');


    $tmpb = blocksCheckState($leftb, $template, $adminislog);
    $smarty->assign("left_blocks", $tmpb);
    $smarty->assign("countlb", count($tmpb));


    $tmpb = blocksCheckState($rightb, $template, $adminislog);
    $smarty->assign("right_blocks", $tmpb);
    $smarty->assign("countrb", count($tmpb));


    $tmpb = blocksCheckState($topb, $template, $adminislog);
    $smarty->assign("top_blocks", $tmpb);
    $smarty->assign("counttb", count($tmpb));


    $tmpb = blocksCheckState($bottomb, $template, $adminislog);
    $smarty->assign("bottom_blocks", $tmpb);
    $smarty->assign("countbb", count($tmpb));


    $sc_2 = getmicrotime();
    $sr_1 = $sc_2 - $sc_1 - $sc_8;

    //show Smarty output
    $smarty->display('index.tpl');

    if ($adminislog && CONF_DISPLAY_INFO) {
        $sr3 = getmicrotime();
        $sr_2 = $sr3 - $sc_2;
        $sr_3 = $sr3 - $sc_1;
        $sr_1 = number_format(round($sr_1, 3), 3, '.', '');
        $sr_2 = number_format(round($sr_2, 3), 3, '.', '');
        $sr_3 = number_format(round($sr_3, 3), 3, '.', '');
        $sc_8 = number_format(round($sc_8, 3), 3, '.', '');

        $_SESSION['tgenexe'] = $sr_1;
        $_SESSION['tgencompile'] = $sr_2;
        $_SESSION['tgendb'] = $sc_8;
        $_SESSION['tgenall'] = $sr_3;
        $_SESSION['tgensql'] = $sc_4;
    }
}
?>