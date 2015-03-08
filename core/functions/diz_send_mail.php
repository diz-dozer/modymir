<?php
function _prety_date($date)
{

    $months = array('Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня', 'Июля', 'Августа', 'Сентября', 'Октября', 'Ноября', 'Декабря');
    $pattern = array('Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь');


    $data = str_replace($pattern, $months, strftime("%e %B %Y", $date));
    return trim($data);

}

function _set_tpl($tpl, $data)
{


    foreach ($data as $marker => $value) {
        $tpl = str_replace('{' . $marker . '}', $value, $tpl);
    }

    return trim($tpl);
}


function _set_content($message)
{

    $tpl = '<div style="color:#555;font-family:Helvetica,Arial,FreeSans,sans-serif;font-size: 14px;line-height: 1.5;">';

    if (!empty($message['data'])) {

        $tpl .= '<ul style="padding-bottom:5px;padding-top:5px;text-align:left;list-style:square">';

        foreach ($message['data'] as $v) {
            $tpl .= '<li style="padding-bottom:5px;">' . $v['label'] . ': <b style="font-size: 16px">' . $v['value'] . '</b></li>';
        }
        $tpl .= '</ul>';

    }
    $tpl .= '</div>';
    return trim($tpl);
}

function _sendMail($message)
{


//    $to = 'gblok@bigmir.net';
//    fb(CONF_GENERAL_EMAIL);
    $to = CONF_GENERAL_EMAIL;

    $tpl = file_get_contents('./assets/email/simple.html');
    $date = _prety_date(time());
    $data['date'] = $date;
    $data['header_tit'] = $message['tit'];
    $data['header_hint'] = $date;
    $data['content'] = _set_content($message);
    $tpl = _set_tpl($tpl, $data);


    $mailer = new \SimpleMail();
    $domen = $_SERVER['SERVER_NAME'];

//    $from = 'robot@' . $domen;

    $subject = $message['mail_subject'] . ' -> ' . $domen;


    $send = $mailer->setTo($to, 'Robot')
        ->setSubject($subject)
        ->setFrom('no-reply@' . $domen, $domen)
        ->addMailHeader('Reply-To', 'no-reply@' . $domen, $domen)
      //  ->addMailHeader('Bcc', 'gblok@bigmir.net', 'Steve Jobs')
        ->addGenericHeader('MIME-Version', '1.0')
        ->addGenericHeader('Content-Type', 'text/html; charset=utf-8')
        ->setMessage($tpl)
        ->send();


// $referrer = $_REQUEST['referrer'];
// unlink($file);
// ->addAttachment($file)
//->setWrap(100)

    return $send;
}

function clean_string($string)
{
    $bad = array('content-type', 'bcc:', 'to:', 'cc:', 'href');
    return str_replace($bad, '', trim($string));
}


function getAttFile()
{

    $doc_path = $_SERVER['DOCUMENT_ROOT'];
    $tmp = '/tmp/';

    $ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
    $file = uniqid() . '.' . $ext;
    $path = $doc_path . $tmp . $file;

    if (move_uploaded_file($_FILES['file']['tmp_name'], $path)) {
        return $path;
    }

}

?>