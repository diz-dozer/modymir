<?php


if (!strcmp($sub, 'xml_import')) {

    if (CONF_BACKEND_SAFEMODE != 1 && (!isset($_SESSION['log']) || !in_array(5, $relaccess))) //unauthorized
    {
        $smarty->assign('admin_sub_dpt', 'error_forbidden.tpl');
    } else {

        //upload file and show import configurator
        if (isset($_POST['proceed']) && isset($_POST['mode'])) {

            if (CONF_BACKEND_SAFEMODE) //this action is forbidden when SAFE MODE is ON
            {
                Redirect(ADMIN_FILE . '?dpt=catalog&sub=xml_import&safemode=yes');
            }


            // reset database content
            if ($_POST['mode'] == 2) {
                imDeleteAllProducts();
                $res = 1;
                $smarty->assign('xml_import_result', 'ok');


            } else {

                if (isset($_FILES['xml']) && $_FILES['xml']['name']) {


                    $file = $_FILES['xml'];

                    if ($file['type'] === 'text/xml') {

                        $file_xml_name = 'core/temp/tt.xml';


                        if (file_exists($file_xml_name)) unlink($file_xml_name);

                        $res = @move_uploaded_file($_FILES['xml']['tmp_name'], $file_xml_name);


                        $smarty->assign('file_xml_name', $file_xml_name);

                    } else {
                        fb('no xml file!');
                    }


                }

                //uploaded successfully
                if ($res) {

                    SetRightsToUploadedFile($file_xml_name);


                    $xml = simplexml_load_file($file_xml_name);


                    $data['offers'] = $xml;
                    $data['count_offers'] = count($xml->children());

//                    $data['currencyID'] = false;

                    $start_time = microtime(true);


                    xmlImport($data);

                    update_psCount(1);

                    $exec_time = microtime(true) - $start_time;

                    $data['exec_time'] = $exec_time;

                    $smarty->assign('data', $data);


                } else $smarty->assign('xml_import_result', 'upload_file_error');
            }
        }

        $smarty->assign('admin_sub_dpt', 'catalog_xml_import.tpl');
    }
}
