<?php



$leftb = array();
$topb = array();
$bottomb = array();
$rightb = array();


$sql = '
    SELECT
    bid,
    title,
    content,
    bposition,
    which,
    sort,
    html,
    url,
    admin,
    pages,
    dpages,
    categories,
    products
    FROM ' . BLOCKS_TABLE . '
    WHERE active=1
    ORDER BY sort ASC';

$result = db_query($sql);




while ($row = db_fetch_assoc($result)) {

    $row['pages'] = ($row['pages'] != '') ? unserialize($row['pages']) : array();
    $row['dpages'] = ($row['dpages'] != '') ? unserialize($row['dpages']) : array();
    $row['categories'] = ($row['categories'] != '') ? unserialize($row['categories']) : array();
    $row['products'] = ($row['products'] != '') ? unserialize($row['products']) : array();

    $row['state'] = true;


//    fb($row);

    if ($row['bposition'] == 1) {
        if ($row['html'] == 1) {
            if (file_exists('core/tpl/user/' . TPL . '/blocks/' . $row['url']))
                $leftb[] = $row;
        } else {
            $leftb[] = $row;
        }
    }
    
    if ($row['bposition'] == 2) {
        if ($row['html'] == 1) {
            if (file_exists('core/tpl/user/' . TPL . '/blocks/' . $row['url']))
                $topb[] = $row;
        } else {
            $topb[] = $row;
        }
    }
    
    if ($row['bposition'] == 3) {
        if ($row['html'] == 1) {
            if (file_exists('core/tpl/user/' . TPL . '/blocks/' . $row['url']))
                $bottomb[] = $row;
        } else {
            $bottomb[] = $row;
        }
    }
    
    if ($row['bposition'] == 4) {
        if ($row['html'] == 1) {
            if (file_exists('core/tpl/user/' . TPL . '/blocks/' . $row['url']))
                $rightb[] = $row;
        } else {
            $rightb[] = $row;
        }
    }
}
?>