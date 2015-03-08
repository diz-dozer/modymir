<?php

namespace Diz;

class Form
{


    public $validator;
    public $defaults;


    public $form;
    public $config;
    public $data;


    public $additional;
    public $buttons = array();


    public $message;
    public $response;

    public $errors = false;

    public function __construct($formID = false)
    {

        $this->validator = new \GUMP();

        $this->set_defaults();
        $this->get_fields($formID);
        $this->process();
        $this->get_form();


        if ($this->form && isset($_POST['submit'])) {
            $this->validate();
        }


    }


    public function process()
    {

        $_GET = $this->validator->sanitize($_GET);
        $_POST = $this->validator->sanitize($_POST);
        $_REQUEST = $this->validator->sanitize($_REQUEST);

        $_GET = $this->validator->xss_clean($_GET);
        $_POST = $this->validator->xss_clean($_POST);
        $_REQUEST = $this->validator->xss_clean($_REQUEST);


        $allow_type = array('ajax', 'static');
        $this->config['uri'] = $_SERVER['REQUEST_URI'];
        $this->config['request_type'] = (in_array($_REQUEST['request'], $allow_type)) ? $_REQUEST['request'] : false;
        $this->config['response_type'] = (in_array($_REQUEST['response'], $allow_type)) ? $_REQUEST['response'] : false;


    }

    private function get_rules($type)
    {
        $result = array();

        foreach ($this->data['fields'] as $k => $v) {
            if ($v[$type]) {
                $result[$k] = $v[$type];
            }
        }


        return $result;

    }

    public function validate()
    {


        $rules = $this->get_rules('rules');
        $filters = $this->get_rules('filter');

        $_POST = $this->validator->filter($_POST, $filters);
        $validated = $this->validator->validate($_POST, $rules);


        foreach ($_POST as $key => $val) {
            if (array_key_exists($key, $this->data['fields']))
                $this->data['fields'][$key]['value'] = $val;
        }


        if ($validated === true) {


            $this->message['data'] = array_intersect_key($this->data['fields'], $this->form);


            if (_sendMail($this->message)) {
                $response['status'] = 'success';


                $response['tit'] = (!empty($this->config['rsp_tit'])) ? $this->config['rsp_tit'] : 'Заявка успешно отправлена!';
                $response['txt'] = (!empty($this->config['rsp_txt'])) ? $this->config['rsp_xt'] : 'Мы свяжемся с Вами в ближайшее время';

            } else {
                $response['status'] = 'error';
                $response['tit'] = 'Ошибка отправки';
                $response['txt'] = 'Не удалось отправить письмо, попробуйте позже';
            }


            $this->response = $response;

        } else {


            $errors = array();

            foreach ($this->validator->errors() as $e) {
                $errors[$e['field']][] = $this->set_validator_error($e['field'], $e['rule'], $e['param']);
                $this->data['fields'][$e['field']]['value'] = $e['value'];
            }

            foreach ($errors as $k => $v) {


                $error = $v[0];
                $this->data['fields'][$k]['error'] = $error;
                $errors[$k] = $error;
            }


            if ($errors) {
                $errors['status'] = 'error';
                $this->errors = $errors;
            }


        }


    }

    private function html_response()
    {

        $tpl = '<dl class="md-response ' . $this->response['status'] . '">';
        $tpl .= '<dt class="tit">' . $this->response['tit'] . '</dt>';
        $tpl .= '<dd>' . $this->response['txt'] . '</dd>';
        $tpl .= '</dl>';

        return $tpl;
    }


    public function response()
    {


        switch ($this->config['response_type']) {

            case 'ajax':
                header('Content-Type: application/json');
                echo json_encode(($this->errors) ? $this->errors : $this->response);

                exit();
                break;

            case 'static':

                if ($this->response) {

                    header('Content-Type: application/json');
                    echo json_encode($this->response);

                    exit();
                    break;


                } else {

                    $html = '<section>';
                    $html .= $this->additional;
                    $html .= ($this->response) ? $this->html_response() : $this->get_tpl();
                    $html .= '</section>';

                    return $html;

                }


                break;

            default:

                $html = '';

                $content = ($this->response) ? $this->html_response() : $this->get_tpl();

                if ($this->config['request_type']) {

                    $html .= $this->additional;
                    $html .= $content;

                } else {

                    header("Content-Type:text/html");
                    $html .= '<!doctype html>';
                    $html .= '<link rel="stylesheet" href="/assets/all.css" />';
                    $html .= '<meta charset="utf-8" />';
                    $html .= '<meta name="viewport" content="width=device-width, initial-scale=1"/>';
                    $html .= '<body>';
                    $html .= $this->additional;
                    $html .= $content;
                    $html .= '<script src="/assets/all.js" async="async"></script>';
                    $html .= '</body>';
                    $html .= '</html>';
                }


                echo $html;

                break;
        }


    }


    public function set_defaults()
    {


        $this->defaults['fields'] = array(
            'username' => array(
                'label' => 'Имя',
                'tag' => 'input',
                'type' => 'text',
                'rules' => 'required|min_len,2|max_len,50',
                'filter' => 'trim|sanitize_string'
            ),
            'phone' => array(
                'label' => 'Контактный телефон',
                'tag' => 'input',
                'type' => 'text',
                'rules' => 'required|min_len,10',
                'filter' => 'trim|sanitize_string'
            ),
            'email' => array(
                'label' => 'Email',
                'tag' => 'input',
                'type' => 'email',
                'rules' => 'valid_email',
                'filter' => 'trim|sanitize_string'
            ),
            'city' => array(
                'label' => 'Город',
                'tag' => 'input',
                'type' => 'text',
                'rules' => 'min_len,2|max_len,50',
                'filter' => 'trim|sanitize_string'
            ),
            'place' => array(
                'label' => 'Место проведения мероприятиян',
                'tag' => 'input',
                'type' => 'text',
                'rules' => 'min_len,2|max_len,100',
                'filter' => 'trim|sanitize_string'
            ),
            'amount' => array(
                'label' => 'Количество билетов',
                'tag' => 'input',
                'type' => 'text',
                'rules' => 'min_len,6|max_len,20',
                'filter' => 'trim|sanitize_string'
            ),
            'desc' => array(
                'label' => 'Дополнительная информация, пожелания',
                'tag' => 'textarea',
                'type' => 'text',
                'rules' => 'min_len,2|max_len,200',
                'filter' => 'trim|sanitize_string'
            ),
            'date' => array(
                'label' => 'Дата проведения мероприятия',
                'tag' => 'input',
                'type' => 'date',
                'rules' => 'min_len,6|max_len,20',
                'filter' => 'trim|sanitize_string'
            )
        );

        $this->defaults['buttons'] = array(
            'submit' => array(
                'label' => 'Отправить',
                'name' => 'submit',
                'type' => 'submit',
                'value' => 1
            )
        );

    }

    public function get_form()
    {


        if ($this->form) {

            $data['request'] = $this->config['request_type'];
            $data['action'] = $this->config['uri'];
            $data['caption'] = $this->config['caption'];

            $defaults = array_replace_recursive($this->form, array_intersect_key($this->defaults['fields'], $this->form));
            $data['fields'] = array_replace_recursive($defaults, $this->form);


            $data['buttons'] = array_replace_recursive($this->buttons, $this->defaults['buttons']);

            $this->data = $data;


        }


    }

    public function get_tpl()
    {

        $tpl = '';

        $data = $this->data;

        if ($data) {


            $dataTool = (!empty($data['request'])) ? 'data-tools="form"' : false;

            $tpl .= '<form action="' . $data['action'] . '" method="post" ' . $dataTool . ' class="md-form">';


            $tpl .= (!empty($data['caption'])) ? '<header class="h2">' . $data['caption'] . '</header>' : false;


            foreach ($data['fields'] as $key => $val) {

                $id = 'f_' . $key;
                $value = (!empty($val['value'])) ? $val['value'] : false;
                $type = $val['type'];


                $data_rules = (!empty($val['rules'])) ? ' data-rules="' . $val['rules'] . '"' : false;

                if ($data_rules) {
                    $rules = explode('|', $val['rules']);
                    $required = ($rules[0] == 'required') ? ' required="required"' : false;
                }


                if (!empty($val['error'])) {
                    $class = (!empty($val['class'])) ? 'class="invalid ' . $val['class'] . '"' : 'class="invalid"';
                } else {
                    $class = (!empty($val['class'])) ? 'class="' . $val['class'] . '"' : '';
                }


                $tpl .= '<div class="field">';

                $placeholder = false;

                if ($this->config['response_type'] == 'static') {

                    $req = (!empty($required)) ? '<span class="req">*</span> ' : '';
                    $tpl .= '<label for="' . $id . '">' . $req . $val['label'] . '</label>';


                } else {
                    $placeholder = 'placeholder="' . $val['label'] . '"';
                }

                // $req = ($required) ? '* ' : false;
//                $placeholder = 'placeholder="'.$req. $val['label'] . '"';


                switch ($val['tag']) {

                    case 'input':
                        $tpl .= '<input ' . $class . ' id="' . $id . '" type="' . $type . '"  name="' . $key . '" value="' . $value . '"' . $data_rules . $required . $placeholder . ' />';
                        break;
                    case 'textarea':

                        $tpl .= '<textarea ' . $class . ' id="' . $id . '"  name="' . $key . '" ' . $data_rules . $required . $placeholder . ' rows="3" cols="15" name="message" wrap="soft">' . $value . '</textarea>';
                        break;

                }

                if (!empty($val['error'])) {
                    $tpl .= '<small id="' . $id . '-error" class="invalid">' . $val['error'] . '</small>';
                }


                $tpl .= '</div>';
            }


//            if (!empty($data['buttons'])) {   }


            $tpl .= '<div class="buttons">';

            foreach ($data['buttons'] as $key => $val) {

                $class = (!empty($val['class'])) ? ' class="' . $val['class'] . '"' : false;


                $name = (!empty($val['name'])) ? ' name="' . $val['name'] . '"' : false;
                $value = (!empty($val['value'])) ? ' value="' . $val['value'] . '"' : false;

                $tpl .= '<button type="' . $val['type'] . '"' . $class . $name . $value . '>' . $val['label'] . '</button>';
            }

            if (!empty($data['hiddens'])) {
                foreach ($data['hiddens'] as $key => $val) {
                    $tpl .= '<input type="hidden"  name="' . $key . '"  value="' . $val['value'] . '" />';
                }
            }


            $tpl .= '</div>';


            $tpl .= '</form>';
        }

        return $tpl;
    }


    private function get_fields($formID)
    {


        switch ($formID) {
            case 'callback':

                $this->message = array(
                    'mail_tit' => 'Callback',
                    'mail_subject' => 'Callback',
                    'tit' => 'Обратный звонок'
                );

                $this->config['rsp_tit'] = 'Сообщение отправленно!';

                $this->form = array(
                    'username' => array(),
                    'phone' => array(),
                );
                break;
            default:
                $this->form = false;
                break;
        }


    }

    private function set_validator_error($field, $rule, $param)
    {

        switch ($rule) {
            case 'mismatch' :
                $resp = "There is no validation rule for $field";
                break;
            case 'validate_required':
                $resp = "The $field field is required";
                break;
            case 'validate_valid_email':
                $resp = "The $field field is required to be a valid email address";
                break;
            case 'validate_max_len':
                if ($param == 1) {
                    $resp = "The $field field needs to be shorter than $param character";
                } else {
                    $resp = "The $field field needs to be shorter than $param characters";
                }
                break;
            case 'validate_min_len':
                if ($param == 1) {
                    $resp = "The $field field needs to be longer than $param character";
                } else {
                    $resp = "The $field field needs to be longer than $param characters";
                }
                break;
            case 'validate_exact_len':
                if ($param == 1) {
                    $resp = "The $field field needs to be exactly $param character in length";
                } else {
                    $resp = "The $field field needs to be exactly $param characters in length";
                }
                break;
            case 'validate_alpha':
                $resp = "The $field field may only contain alpha characters(a-z)";
                break;
            case 'validate_alpha_numeric':
                $resp = "The $field field may only contain alpha-numeric characters";
                break;
            case 'validate_alpha_dash':
                $resp = "The $field field may only contain alpha characters &amp; dashes";
                break;
            case 'validate_numeric':
                $resp = "The $field field may only contain numeric characters";
                break;
            case 'validate_integer':
                $resp = "The $field field may only contain a numeric value";
                break;
            case 'validate_boolean':
                $resp = "The $field field may only contain a true or false value";
                break;
            case 'validate_float':
                $resp = "The $field field may only contain a float value";
                break;
            case 'validate_valid_url':
                $resp = "The $field field is required to be a valid URL";
                break;
            case 'validate_url_exists':
                $resp = "The $field URL does not exist";
                break;
            case 'validate_valid_ip':
                $resp = "The $field field needs to contain a valid IP address";
                break;
            case 'validate_valid_cc':
                $resp = "The $field field needs to contain a valid credit card number";
                break;
            case 'validate_valid_name':
                $resp = "The $field field needs to contain a valid human name";
                break;
            case 'validate_contains':
                $resp = "The $field field needs to contain one of these values: " . implode(', ', $param);
                break;
            case 'validate_street_address':
                $resp = "The $field field needs to be a valid street address";
                break;
            case 'validate_date':
                $resp = "The $field field needs to be a valid date";
                break;
            case 'validate_min_numeric':
                $resp = "The $field field needs to be a numeric value, equal to, or higher than $param";
                break;
            case 'validate_max_numeric':
                $resp = "The $field field needs to be a numeric value, equal to, or lower than $param";
                break;
            default:
                $resp = "The $field field is invalid";
        }


        return $resp;

    }

}