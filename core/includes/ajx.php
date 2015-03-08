<?php


if (isset($_GET['ajx_form'])) {


    echo($_GET);

//    if (isset($_GET['formID'])) {
//
//
//        $form = new \Diz\Form($_GET['formID']);
//
//        if ($form) {
//
//            $form->response();
//
//            exit();
//
//        } else {
//
//
//            header('HTTP/1.0 404 Not Found');
//            header('HTTP/1.1 404 Not Found');
//            header('Status: 404 Not Found');
//            die(ERROR_404_HTML);
//
//        }
//
//        $_REQUEST['response'] = 'static';
//        $_REQUEST['request'] = 'static';
//
//        $form = new \Diz\Form($id);
//
//        return $form->response();
//
//    }

    exit();
}

//if (isset($_POST['ajx_form'])) {
//
//
//
//
//
//    function _ajx_enter()
//    {
//
//        if (regAuthenticate($_POST['user_login'], $_POST['user_pw'])) {
//
//            if (!isset($_POST['order'])) {
//
//                $response['success'] = true;
//
//
//                $adm_lnk = '<a class="lnk" href="' . ADMIN_FILE . '" rel="nofollow">' . ADMINISTRATE_LINK . '</a>';
//                $usr_lnk = '<a class="lnk" href="/index.php?user_details" rel="nofollow">' . MY_ACCOUNT_LINK . '</a>';
//
//                $txt = $usr_lnk;
//                $tpl = '<ul class="is-log">';
//
//
//                if (in_array(100, checklogin())) {
//
//
//
//                    $txt .= '&nbsp;&nbsp;&nbsp;&nbsp;' . $adm_lnk;
//                    $tpl .= '<li>' . $adm_lnk . '</li>';
//                }
//
//
//                $tpl .= '<li>' . $usr_lnk . '</li>';
//                $tpl .= '<li><a class="lnk" href="/index.php?logout" rel="nofollow">' . LOGOUT_LINK . '</a></li>';
//                $tpl .= '</ul>';
//
//
//                $response['tit'] = 'Добро пожаловать!';
//                $response['txt'] = $txt;
//                $response['up'] = array(
//                    array(
//                        'cls' => 'no-log',
//                        'tpl' => $tpl
//                    )
//                );
//
//
//            }
//        } else {
//
//            $response['success'] = false;
//            $response['tit'] = 'Ошибка формы';
//            $response['txt'] = '<div class="error">Неверный логин или пароль</div>';
//
//        }
//
//        return $response;
//
//    }
//
//
//    function _ajx_callback()
//    {
//
//
//        $referrer = $_SERVER['REQUEST_URI'];
//
//        $contactPhone = $_POST['phone'];
//        $contactName = $_POST['name'];
//
//
//        $name = 'robot';
//        $email = 'robot@' . $_SERVER['SERVER_NAME'];
//        $subject = 'CALLBACK -> ' . $_SERVER['SERVER_NAME'];
//
//
//        $message = "ОБРАТНЫЙ ЗВОНОК" . " \n";
//        $message .= "дата отправки: " . date("d.m.y") . " \n";
//        $message .= "\n---------------------------------------------------------------- \n\n";
//
//        if (!empty($contactName)) {
//            $message .= "Контактное лицо: " . $contactName . " \n";
//        }
//
//        $message .= "Контактный телефон: " . $contactPhone . " \n";
//
//
//        if (!empty($referrer)) {
//            $message .= "\n---------------------------------------------------------------- \n\n";
//            $message .= "отправлено со страницы \n";
//            $message .= "http://" . $_SERVER['HTTP_HOST'] . $referrer;
//        }
//
//        if (xMailTxtHTML(CONF_GENERAL_EMAIL, $subject, $message, $email, $name)) {
//            $response = array(
//                'success' => true,
//                'tit' => 'Сообщение отправлено',
//                'txt' => 'Спасибо, менеджер свяжется с вами в ближайшее время.'
//            );
//        }
//
//
//
//        return $response;
//    }
//
//
//    switch ($_POST['ajx_form']) {
//
//        case 'enter':
//            $response = _ajx_enter();
//            break;
//
//        case 'callback':
//            $response = _ajx_callback();
//            break;
//
//    }
//
//
//    header('Content-Type: application/json');
//    echo json_encode($response);
//    exit();
//
//}
?>