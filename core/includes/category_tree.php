<?php

// category navigation form

if (isset($categoryID))
    $out = catGetCategoryCompactCList($categoryID);
else
    $out = catGetCategoryCompactCList(1);
$smarty->assign("categories_tree_count", count($out));
$smarty->assign("categories_tree", $out);

$smarty->assign("big_categories_tree_count", count($cats));
$smarty->assign("big_categories_tree", $cats);

function get_sub_cat($cats, $catID, $lvl)
{
    $arr = array();
    foreach ($cats as $cat => $val) {

        if ($val['level'] === $lvl && $val['parent'] = $catID) {
            $arr[] = $val;
        }
    }

    return $arr;
}

function catGetMenuCategoryList($cats)
{

    $arr = array();
    $cats_tree = array();

    foreach ($cats as $cat => $val) {

        $level = (int)$val['level'];
        $parentID = (int)$val['parent'];
        $categoryID = (int)$val['categoryID'];
        $subcount = (int)$val['subcount'];


        if ($level === 0) {
            $arr[$categoryID] = $val;
        }

        if ($level === 1) {
            if ($subcount > 0) {
                $val['sub'] = get_sub_cat($cats, $categoryID, 2);
            }
            $arr[$parentID]['sub'][] = $val;
        }
    }

    foreach ($arr as $cat => $val) {
        $cats_tree[] = $val;
    }

    return $cats_tree;
}

//fbug($cats);

if (!empty($cats)) {

    $cats_tree = catGetMenuCategoryList($cats);
    $smarty->assign("cats_tree", $cats_tree);
}
?>