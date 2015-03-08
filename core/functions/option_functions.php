<?php


function optGetOptions()
{

    $SQL = 'select ps.optionID, ps.name, ps.sort_order, COUNT(povv.variantID) as count_variants FROM ' . PRODUCT_OPTIONS_TABLE . ' as ps
                LEFT JOIN ' . PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE . ' as povv ON ps.optionID = povv.optionID GROUP BY ps.optionID ORDER BY sort_order, name
        ';
    $q = db_query($SQL);
    $result = array();

    while ($row = db_fetch_row($q)) $result[] = $row;
    return $result;
}

function optGetOptionscat($categoryID)
{

    $SQL = 'select ps.optionID, ps.name, ps.sort_order, COUNT(povv.variantID) as count_variants FROM ' . PRODUCT_OPTIONS_TABLE . ' as ps
                LEFT JOIN ' . PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE . ' as povv ON (ps.optionID = povv.optionID) LEFT JOIN ' . CATEGORY_PRODUCT_OPTIONS_TABLE . ' as j on (ps.optionID = j.optionID) where j.categoryID=' . (int)$categoryID . ' GROUP BY ps.optionID ORDER BY sort_order, name
        ';
    $q = db_query($SQL);
    $result = array();

    while ($row = db_fetch_row($q)) $result[] = $row;
    return $result;
}


function optGetOptionById($optionID)
{
    $q = db_query("select optionID, name, sort_order from " .
        PRODUCT_OPTIONS_TABLE . " where optionID=" . (int)$optionID);
    if ($row = db_fetch_row($q)) return $row;
    else return null;
}


function optUpdateOptions($updateOptions)
{
    foreach ($updateOptions as $key => $val) {
        if (isset($val["extra_option"]) && $val["extra_option"] != "") {
            db_query("update " . PRODUCT_OPTIONS_TABLE . " set name='" . xToText(trim($val["extra_option"])) .
                "', sort_order=" . (int)$val["extra_sort"] . " where optionID=" . (int)$key);
        }
    }
}


function optAddOption($extra_option, $extra_sort)
{
    if (trim($extra_option) == "") return;
    db_query("insert into " . PRODUCT_OPTIONS_TABLE .
        " (name, sort_order) values ('" . xToText($extra_option) . "', '" . (int)$extra_sort . "')");
}


function optGetOptionValues($optionID)
{
    $q = db_query("select variantID, optionID, option_value, sort_order from " .
        PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE .
        " where optionID=" . (int)$optionID .
        " order by sort_order, option_value");
    $result = array();
    while ($row = db_fetch_row($q)) $result[] = $row;
    return $result;
}


function optOptionValueExists($optionID, $value_name)
{
    $q = db_query("select variantID from " .
        PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE .
        " where optionID=" . (int)$optionID . " and option_value='" . xEscSQL(trim($value_name)) . "';");
    $row = db_fetch_row($q);
    if ($row)
        return $row[0]; //return variant ID
    else
        return false;
}


function optUpdateOptionValues($updateOptions)
{
    foreach ($updateOptions as $key => $value) {
        db_query("update " . PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE .
            " set option_value='" . xToText($value["option_value"]) . "', " .
            " sort_order=" . (int)$value["sort_order"] . " " .
            " where variantID=" . (int)$key);
    }
}


function optAddOptionValue($optionID, $value, $sort_order)
{
    db_query("insert into " . PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE .
        "(optionID, option_value, sort_order) " .
        "values('" . (int)$optionID . "', '" . xToText($value) . "', '" .
        (int)$sort_order . "' )");
    return db_insert_id();
}

?>