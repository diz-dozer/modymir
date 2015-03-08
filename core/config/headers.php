<?php

$do_arr = array(
    'cart',
    'invoice_jur',
    'invoice_phys',
    'configurator',
    'wishcat',
    'wishlist',
    'wishprod',
    'ajax',
    'crt',
    'look',
    'page',
    'get_file'
);

if (!isset($_GET['do']) || in_array($_GET['do'], $do_arr)) {

    @ini_set('zlib.output_compression_level', 9);
    ob_end_flush();
    ob_start('ob_gzhandler');

    header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
    header('Content-Type: text/html; charset=utf-8');
}
?>