<?php

@ini_set('session.use_trans_sid', 0);
@ini_set('session.use_cookies', 1);
@ini_set('session.use_only_cookies', 1);
@ini_set('session.auto_start', 0);
@ini_set('magic_quotes_gpc', 0);
@ini_set('magic_quotes_runtime', 0);
@ini_set('register_globals', 0);
@ini_set('display_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);



define('ADMIN_FILE', 'admin.php');

?>