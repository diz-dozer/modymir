<?php

function getSpecProductsID()
{

    $sql = 'SELECT productID FROM ' . SPECIAL_OFFERS_TABLE . ' ORDER BY sort_order ASC';


//    fb($sql);

    $specID = array();

    $q = db_query($sql);
    while ($row = db_fetch_assoc($q)) {
        $specID[] = $row['productID'];
    }

    return $specID;
}


function getProducts($where = false, $order = false, $limit = 8)
{

    $products = array();

    if ($where) {

        $order = ($order) ? ' ORDER BY ' . $order : '';
        $limit = ($limit) ? ' LIMIT ' . $limit : '';

        $sql = 'SELECT DISTINCT * FROM ' . PRODUCTS_TABLE . ' WHERE ' . $where . $order . $limit;
        $q = db_query($sql);

//        fb($sql);


        while ($row = db_fetch_row($q)) {
            _setPictures($row);
            $row = array_merge($row, getProductData($row));
            $products[] = $row;
        }

    }
    return $products;
}

function prdProductExists($productID)
{
    $q = db_query("select count(*) from " . PRODUCTS_TABLE . " where productID=" . (int)$productID);
    $row = db_fetch_row($q);
    return ($row[0] != 0);
}


function getcontentprod($productID)
{
    $out = array();
    $cnt = 0;
    $q = db_query("select Owner from " . RELATED_CONTENT_TABLE . " where productID=" . (int)$productID);
    while ($row = db_fetch_row($q)) {
        $outpre = $row["Owner"];
        $qh = db_query("select aux_page_name from " . AUX_PAGES_TABLE . " where aux_page_ID=" . (int)$outpre);
        $rowh = db_fetch_row($qh);
        $out[$cnt][0] = $outpre;
        $out[$cnt][1] = $rowh["aux_page_name"];
        $cnt++;
    }
    return $out;
}


function GetProduct($productID)
{

    $sql = '
    SELECT DISTINCT *
    FROM ' . PRODUCTS_TABLE . '
    WHERE productID="' . $productID . '"
    LIMIT 1';

    $q = db_query($sql);

    if ($product = db_fetch_assoc($q)) {


        _setPictures($product);

        $product['ProductIsProgram'] = (trim($product['eproduct_filename']) != '');
        $product['date_added'] = format_datetime($product['date_added']);
        $product['date_modified'] = format_datetime($product['date_modified']);

        $product = array_merge($product, getProductData($product));

        return $product;
    }

}

function extraToParam($extra)
{

    if ($extra) {

        $allow = array(
            'Бренд' => 'brand',
            'Цвет' => 'color',
            'Размер' => 'size',
            'Вес' => 'weight',
            'Код производителя' => 'model'
        );

        $param = array();

        foreach ($extra as $itm) {

            $label = $itm['name'];

            if ($itm['option_type'] == 0 && array_key_exists($label, $allow)) {
                $key = $allow[$label];
                $param[$key]['label'] = $label;
                $param[$key]['value'] = $itm['option_value'];
            }
        }


        return $param;
    }


}

function extraToVariants($extra)
{
    if ($extra) {
        $variants = array();
        foreach ($extra as $itm) {
            if ($itm['option_type'] == 1) {
                $variants[] = $itm;
            }
        }
        return $variants;
    }

}

function getProductMeta($product)
{


//    $result['data'] = '
//    data-id="' . $product['productID'] . '"
//    data-name="' . $product['name'] . '"
//    data-src="' . $product['picture'] . '"
//    data-url="' . $product['productID'] . '"
//    data-title="' . $product['title'] . '"
//    data-price="' . show_priceWithOutUnit($base_price) . '"
//    data-list-price="' . show_priceWithOutUnit($list_price) . '"';
//
//
//    $url = 'http://' . $_SERVER['SERVER_NAME'] . '/product_' . $product['productID'] . '.html';
//    $src = 'http://' . $_SERVER['SERVER_NAME'] . '/img/w1000/data/small/' . $product['picture'];
//
//    $result['social'] = '
//    data-name="' . $product['name'] . '"
//    data-src=' . $src . '
//    data-url=' . $url . '
//    data-title="' . $product['title'] . '"
//    data-description=""
//    ';

}

function getProductData($product)
{


    $base_price = $product['Price'];
    $price = $product['Price'];
    $list_price = $product['list_price'];


    $extra = GetProductExtra($product['productID'], $surplus);

    $result['extra'] = $extra;
    $result['extra_count'] = count($extra);

    $variants = extraToVariants($extra);
    $result['variants'] = $variants;
    $result['variants_count'] = count($variants);

//    fb($result['variants']);

//    $result['param'] = extraToParam($extra);
//
    //$result['sizes'] = GetXValByName($extra, 'Размер');

    if (!empty($surplus)) {
        $surplus[] = $base_price;
        $sum = function ($a, $b) {
            return $a + $b;
        };
        $price = array_reduce($surplus, $sum);
    }


    $profit = ($list_price > $price) ? round((($list_price - $price) / $list_price) * 100, 0) . '%' : false;
//    $save = ($list_price > $price) ? show_price($list_price - $price) : false;


    $result['PriceWithUnit'] = show_price($price);
    $result['list_priceWithUnit'] = show_price($list_price);
    $result['profit'] = $profit;


    if (((double)$product['shipping_freight']) > 0)
        $result["shipping_freightUC"] = show_price($product['shipping_freight']);


    $result['description'] = cleanTxt($product['description']);
    $result['brief_description'] = cleanTxt($product['brief_description']);


    //getProductMeta();


    return $result;
}


function cleanTxt($str)
{


    if (strlen($str) < 100) {
        $tstr = strip_tags(preg_replace('/\s|&nbsp;/', '', $str));
        if (strlen($tstr) == 0)
            $str = false;
    }

    return trim($str);
}

function UpdateProduct(
    $productID,
    $categoryID,
    $name,
    $Price,
    $description,
    $in_stock,
    $customers_rating,
    $brief_description,
    $list_price,
    $product_code,
    $sort_order,
    $ProductIsProgram,
    $eproduct_filename,
    $eproduct_available_days,
    $eproduct_download_times,
    $weight,
    $meta_description,
    $meta_keywords,
    $free_shipping,
    $min_order_amount,
    $shipping_freight,
    $classID,
    $title,
    $updateGCV = 1)
{

    if ($min_order_amount == 0) $min_order_amount = 1;

    if (!$ProductIsProgram) $eproduct_filename = "";

    if (!$free_shipping) $free_shipping = 0;
    else $free_shipping = 1;

    $q = db_query("select eproduct_filename from " . PRODUCTS_TABLE . " where productID=" . (int)$productID);
    $old_file_name = db_fetch_row($q);
    $old_file_name = $old_file_name[0];

    if ($classID == null) $classID = "NULL";

    if ($eproduct_filename != "" && $ProductIsProgram) {
        if (trim($_FILES[$eproduct_filename]["name"]) != "") {
            if (trim($old_file_name) != "" && file_exists("core/files/" . $old_file_name))
                unlink("core/files/$old_file_name");

            if ($_FILES[$eproduct_filename]["size"] != 0)
                $r = move_uploaded_file($_FILES[$eproduct_filename]["tmp_name"],
                    "core/files/" . $_FILES[$eproduct_filename]["name"]);
            $eproduct_filename = trim($_FILES[$eproduct_filename]["name"]);
            SetRightsToUploadedFile("core/files/" . $eproduct_filename);
        } else
            $eproduct_filename = $old_file_name;
    } elseif ($old_file_name != "") unlink("core/files/" . $old_file_name);


    $sql = '
        UPDATE ' . PRODUCTS_TABLE . '
        SET
        categoryID=' . (int)$categoryID . ',
        name = "' . xToText(trim($name)) . '",
        Price = "' . (double)$Price . '",
        description= "' . xEscSQL(trim($description)) . '",
        in_stock = ' . (int)$in_stock . ',
        customers_rating = "' . (float)$customers_rating . '",
        brief_description = "' . xEscSQL(trim($brief_description)) . '",
        list_price = "' . (double)$list_price . '",
        product_code = "' . xToText($product_code) . '",
        sort_order = ' . (int)$sort_order . ',
        date_modified = "' . xEscSQL(get_current_time()) . '",
        eproduct_filename = "' . xEscSQL($eproduct_filename) . '",
        eproduct_available_days = ' . (int)$eproduct_available_days . ',
        eproduct_download_times = ' . (int)$eproduct_download_times . ',
        weight = "' . (float)$weight . '",
        meta_description = "' . xToText(trim($meta_description)) . '",
        meta_keywords = "' . xToText(trim($meta_keywords)) . '",
        free_shipping = ' . (int)$free_shipping . ',
        min_order_amount = ' . (int)$min_order_amount . ',
        shipping_freight = ' . (double)$shipping_freight . ',
        title ="' . xToText(trim($title)) . '"';


    if ($classID != null) $sql .= ', classID = ' . (int)$classID;

    $sql .= ' WHERE productID=' . (int)$productID;

    db_query($sql);

    db_query('DELETE FROM ' . CATEGORIY_PRODUCT_TABLE . ' WHERE productID = ' . (int)$productID . ' AND categoryID = ' . (int)$categoryID);

    //update goods count values for categories in case of regular file editing. do not update during import from excel
    if ($updateGCV == 1 && CONF_UPDATE_GCV == '1')
        update_psCount(1);
}


function SetProductFile($productID, $eproduct_filename)
{

    $sql = '
    UPDATE ' . PRODUCTS_TABLE . '
    SET eproduct_filename="' . xEscSQL($eproduct_filename) . '"
    WHERE productID=' . (int)$productID;

    db_query($sql);

}


function AddProduct(
    $categoryID,
    $name,
    $Price,
    $description,
    $in_stock,
    $brief_description,
    $list_price,
    $product_code,
    $sort_order,
    $ProductIsProgram,
    $eproduct_filename,
    $eproduct_available_days,
    $eproduct_download_times,
    $weight,
    $meta_description,
    $meta_keywords,
    $free_shipping,
    $min_order_amount,
    $shipping_freight,
    $classID,
    $title,
    $updateGCV = 1)
{


    // special symbol prepare
    if ($free_shipping)
        $free_shipping = 1;
    else
        $free_shipping = 0;

    if ($classID == null) $classID = "NULL";

    if ($min_order_amount == 0) $min_order_amount = 1;

    if (!$ProductIsProgram) $eproduct_filename = '';

    if ($eproduct_filename != '') {
        if (trim($_FILES[$eproduct_filename]['name']) != '') {
            if ($_FILES[$eproduct_filename]['size'] != 0)
                $r = move_uploaded_file($_FILES[$eproduct_filename]['tmp_name'],
                    'core/files/' . $_FILES[$eproduct_filename]['name']);
            $eproduct_filename = trim($_FILES[$eproduct_filename]['name']);
            SetRightsToUploadedFile('core/files/' . $eproduct_filename);
        }
    }

    if (trim($name) == '') $name = '?';


    $sql = '
        INSERT INTO ' . PRODUCTS_TABLE . '
        SET
        categoryID = ' . (int)$categoryID . ',
        name="' . xToText(trim($name)) . '",
        description="' . xEscSQL(trim($description)) . '",
        customers_rating = 0,
        Price="' . (double)$Price . '",
        in_stock=' . (int)$in_stock . ',
        customer_votes =0,
        items_sold=0,
        enabled=1,
        brief_description="' . xEscSQL(trim($brief_description)) . '",
        list_price="' . (double)$list_price . '",
        product_code ="' . xToText($product_code) . '",
        sort_order =' . (int)$sort_order . ',
        date_added ="' . xEscSQL(get_current_time()) . '",
        eproduct_filename="' . xEscSQL($eproduct_filename) . '",
        eproduct_available_days=' . (int)$eproduct_available_days . ',
        eproduct_download_times=' . (int)$eproduct_download_times . ',
        weight="' . (float)$weight . '",
        meta_description="' . xToText(trim($meta_description)) . '",
        meta_keywords="' . xToText(trim($meta_keywords)) . '",
        free_shipping=' . (int)$free_shipping . ',
        min_order_amount=' . (int)$min_order_amount . ',
        shipping_freight="' . (double)$shipping_freight . '",
        classID = ' . (int)$classID . ',
        title = "' . xToText(trim($title)) . '"';

    db_query($sql);

    $insert_id = db_insert_id();

    if ($updateGCV == 1 && CONF_UPDATE_GCV == '1') update_psCount(1);

    return $insert_id;
}


function DeleteProduct($productID, $updateGCV = 1)
{
    $whereClause = " where productID=" . (int)$productID;

    $q = db_query("select itemID from " . SHOPPING_CART_ITEMS_TABLE . " " . $whereClause);
    while ($row = db_fetch_row($q))
        db_query("delete from " . SHOPPING_CARTS_TABLE . " where itemID=" . (int)$row["itemID"]);

    // delete all items for this product
    db_query("update " . SHOPPING_CART_ITEMS_TABLE .
        " set productID=NULL " . $whereClause);

    // delete all product option values
    db_query("delete from " . PRODUCTS_OPTIONS_SET_TABLE . $whereClause);
    db_query("delete from " . PRODUCT_OPTIONS_VALUES_TABLE . $whereClause);

    // delete pictures
    DeleteThreePictures2($productID);

    // delete additional categories records
    db_query("delete from " . CATEGORIY_PRODUCT_TABLE . $whereClause);

    // delete discussions
    db_query("delete from " . DISCUSSIONS_TABLE . $whereClause);

    // delete special offer
    db_query("delete from " . SPECIAL_OFFERS_TABLE . $whereClause);

    // delete related items
    db_query("delete from " . RELATED_PRODUCTS_TABLE . $whereClause);
    db_query("delete from " . RELATED_PRODUCTS_TABLE . " where Owner=" . (int)$productID);

    // delete product
    db_query("delete from " . PRODUCTS_TABLE . $whereClause);


    if ($updateGCV == 1 && CONF_UPDATE_GCV == '1') update_psCount(1);

    return true;
}


function DeleteAllProductsOfThisCategory($categoryID)
{
    $q = db_query("select productID from " . PRODUCTS_TABLE .
        " where categoryID=" . (int)$categoryID);
    $res = true;
    while ($r = db_fetch_row($q)) {
        if (!DeleteProduct($r["productID"], 0))
            $res = false;
    }

    if (CONF_UPDATE_GCV == '1') update_psCount(1);

    return $res;
}


function GetProductExtra($productID, &$surplus = array())
{

    if (!is_array($productID)) {

        $ProductIDs = array($productID);
        $IsProducts = false;

    } elseif (count($productID)) {

        $ProductIDs = &$productID;
        $IsProducts = true;

    } else {

        return array();
    }

    $extra = array();

    $sql = 'SELECT
            v.productID,
            v.option_value,
            v.option_type,
            v.option_show_times,
            v.variantID,
            v.optionID,
            o.optionID,
            o.name
            FROM ?#PRODUCT_OPTIONS_VALUES_TABLE AS v
            LEFT JOIN  ?#PRODUCT_OPTIONS_TABLE AS o ON (o.optionID = v.optionID)
            WHERE v.productID IN (?@)
            ORDER BY o.sort_order, o.name';


    $result = db_phquery($sql, $ProductIDs);


    while ($row = db_fetch_assoc($result)) {

        if (($row['option_type'] == 0 || $row['option_type'] == NULL) && strlen(trim($row['option_value'])) > 0) {


            $extra[$row['productID']][] = array(
                'option_type' => $row['option_type'],
                'name' => $row['name'],
                'option_value' => $row['option_value']
            );


        } else if ($row['option_type'] == 1) {

            //fetch all option values variants
            $sql = '
            SELECT
            v.option_value,
            v.variantID,
            o.price_surplus
            FROM ' . PRODUCTS_OPTIONS_SET_TABLE . ' AS o
            LEFT JOIN ' . PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE . ' AS v ON v.variantID=o.variantID
            WHERE
            v.optionID=' . $row['optionID'] . ' AND
            o.productID=' . $row['productID'] . ' AND
            v.optionID=' . $row['optionID'] . '
            ORDER BY v.sort_order, v.option_value';


            $q = db_query($sql);

            $variants = array();

            while ($sub_row = db_fetch_assoc($q)) {

                if (!empty($row['variantID']) && $row['variantID'] == $sub_row['variantID']) {
                    $surplus[] = $sub_row['price_surplus'];
                }


                $values['variantID'] = $sub_row['variantID'];
                $values['option_value'] = $sub_row['option_value'];

//                if ($sub_row['price_surplus'] > 0) $row['values_to_select'][$i]['option_value'] .= ' (+ ' . show_price($sub_row['price_surplus']) . ')';
//                elseif ($sub_row['price_surplus'] < 0) $row['values_to_select'][$i]['option_value'] .= ' (- ' . show_price(-$sub_row['price_surplus']) . ')';


                // $values['option_valueWithOutPrice'] = $sub_row['option_value'];
                $values['price_surplus'] = show_priceWithOutUnit($sub_row['price_surplus']);


                $variants[] = $values;

            }

            $row['values_to_select'] = $variants;
            $row['values_to_select_count'] = count($variants);
            $extra[$row['productID']][] = $row;
        }

    }

    if (!$IsProducts) {
        if (!count($extra)) return array();
        else {
            return $extra[$productID];
        }
    }


    return $extra;
}


function _get_pic($filename, $pre = 'data/small/')
{


    $pic = null;
    $filename = $pre . $filename;


    if (file_exists($filename)) {

        $info = getimagesize($filename);

        if ($info[1] > 0 && $info[0] > 0) {

            $pic['w'] = $info[0];
            $pic['h'] = $info[1];

            $pic['ratio'] = round($info[1] / $info[0], 2);
            $pic['src'] = $filename;

        }
    }


    return $pic;
}


function _setPictures(&$product)
{

    $empty = _get_pic('empty.jpg', 'data/');

    $sql = 'SELECT photoID, filename FROM ' . PRODUCT_PICTURES . ' WHERE productID="' . $product['productID'] . '"';
    $q = db_query($sql);

    $defaultID = $product['default_picture'];

    $product['picture'] = $empty;


    while ($row = db_fetch_assoc($q)) {

        $img = _get_pic($row['filename']);

        if ($defaultID === $row['photoID']) {
            $product['picture'] = ($img) ? $img : $empty;
            $product['picture']['alt'] = ($img) ? $product['name'] : 'no photo';
            $product['picture']['empty'] = ($img) ? false : true;
        } elseif ($img) {
            $product['thumbs'][] = $img;
        }
    }


//    fb($product);

}


function GetProductInSubCategories($callBackParam, &$count_row, $navigatorParams = null)
{

    if ($navigatorParams != null) {
        $offset = $navigatorParams["offset"];
        $CountRowOnPage = $navigatorParams["CountRowOnPage"];
    } else {
        $offset = 0;
        $CountRowOnPage = 0;
    }

    $categoryID = $callBackParam["categoryID"];
    $subCategoryIDArray = catGetSubCategories($categoryID);
    $cond = "";
    foreach ($subCategoryIDArray as $subCategoryID) {
        if ($cond != "")
            $cond .= " OR categoryID=" . (int)$subCategoryID;
        else
            $cond .= " categoryID=" . (int)$subCategoryID . " ";
    }
    $whereClause = "";
    if ($cond != "")
        $whereClause = " where " . $cond;

    $result = array();
    if ($whereClause == "") {
        $count_row = 0;
        return $result;
    }

    $q = db_query("select categoryID, name, brief_description, " .
        " customers_rating, Price, in_stock, " .
        " customer_votes, list_price, " .
        " productID, default_picture, sort_order from " . PRODUCTS_TABLE .
        " " . $whereClause . " order by " . CONF_DEFAULT_SORT_ORDER);
    $i = 0;
    while ($row = db_fetch_row($q)) {
        if (($i >= $offset && $i < $offset + $CountRowOnPage) ||
            $navigatorParams == null
        ) {
            $row["PriceWithUnit"] = show_price($row["Price"]);
            $row["list_priceWithUnit"] = show_price($row["list_price"]);
            // you save (value)
            $row["SavePrice"] = show_price($row["list_price"] - $row["Price"]);

            // you save (%)
            if ($row["list_price"])
                $row["SavePricePercent"] = ceil(((($row["list_price"] - $row["Price"]) / $row["list_price"]) * 100));

            _setPictures($row);

            $row["product_extra"] = GetProductExtra($row["productID"]);
            $row["PriceWithOutUnit"] = show_priceWithOutUnit($row["Price"]);
            $result[] = $row;
        }
        $i++;
    }
    $count_row = $i;
    return $result;
}


function prdGetProductByCategory($callBackParam, &$count_row, $navigatorParams = null)
{

    if ($navigatorParams != null) {
        $offset = $navigatorParams["offset"];
        $CountRowOnPage = $navigatorParams["CountRowOnPage"];
    } else {
        $offset = 0;
        $CountRowOnPage = 0;
    }

    $result = array();

    $categoryID = $callBackParam["categoryID"];
    $fullFlag = $callBackParam["fullFlag"];
    if ($fullFlag) {
        $conditions = array(" categoryID=" . (int)$categoryID . " ");
        $q = db_query("select productID from " .
            CATEGORIY_PRODUCT_TABLE . " where  categoryID=" . (int)$categoryID);
        while ($products = db_fetch_row($q))
            $conditions[] = " productID=" . (int)$products[0];

        $data = array();
        foreach ($conditions as $cond) {
            $q = db_query("select categoryID, name, brief_description, " .
                " customers_rating, Price, in_stock, " .
                " customer_votes, list_price, " .
                " productID, default_picture, sort_order, items_sold, enabled, product_code from " . PRODUCTS_TABLE .
                " where " . $cond . " order by " . CONF_DEFAULT_SORT_ORDER);
            while ($row = db_fetch_row($q)) {
                $row["PriceWithUnit"] = show_price($row["Price"]);
                $row["list_priceWithUnit"] = show_price($row["list_price"]);
                // you save (value)
                $row["SavePrice"] = show_price($row["list_price"] - $row["Price"]);

                // you save (%)
                if ($row["list_price"])
                    $row["SavePricePercent"] = ceil(((($row["list_price"] - $row["Price"]) / $row["list_price"]) * 100));
                _setPictures($row);
                $row["product_extra"] = GetProductExtra($row["productID"]);
                $row["product_extra_count"] = count($row["product_extra"]);
                $row["PriceWithOutUnit"] = show_priceWithOutUnit($row["Price"]);
                $data[] = $row;
            }
        }

        function _compare($row1, $row2)
        {
            if ((int)$row1["sort_order"] == (int)$row2["sort_order"])
                return 0;
            return ((int)$row1["sort_order"] < (int)$row2["sort_order"]) ? -1 : 1;
        }

        usort($data, "_compare");

        $result = array();
        $i = 0;
        $ccdata = count($data);
        for ($s = 0; $s < $ccdata; $s++) {
            if (($i >= $offset && $i < $offset + $CountRowOnPage) ||
                $navigatorParams == null
            )
                $result[] = $data[$s];
            $i++;
        }
        $count_row = $i;
        return $result;
    } else {
        $q = db_query("select categoryID, name, brief_description, " .
            " customers_rating, Price, in_stock, " .
            " customer_votes, list_price, " .
            " productID, default_picture, sort_order, items_sold, enabled, product_code from " . PRODUCTS_TABLE .
            " where categoryID=" . (int)$categoryID . " order by " . CONF_DEFAULT_SORT_ORDER);
        $i = 0;
        while ($row = db_fetch_row($q)) {
            if (($i >= $offset && $i < $offset + $CountRowOnPage) ||
                $navigatorParams == null
            )
                $result[] = $row;
            $i++;
        }
        $count_row = $i;
        return $result;
    }
}


function _getConditionWithCategoryConjWithSubCategories($condition, $categoryID) //fetch products from current category and all its subcategories
{
    $new_condition = "";
    $tempcond = "";

    $categoryID_Array = catGetSubCategories($categoryID);
    $categoryID_Array[] = (int)$categoryID;

    foreach ($categoryID_Array as $catID) {
        if ($new_condition != "")
            $new_condition .= " OR ";

        $new_condition .= _getConditionWithCategoryConj($tempcond, $catID);

    }
    if ($condition == "") return $new_condition;
    else return $condition . " AND (" . $new_condition . ")";
}


function _getConditionWithCategoryConj($condition, $categoryID) //fetch products from current category
{
    $category_condition = "";
    $q = db_query("select productID from " .
        CATEGORIY_PRODUCT_TABLE . " where categoryID=" . (int)$categoryID);
    $icounter = 0;
    while ($product = db_fetch_row($q)) {
        if ($icounter == 0)
            $category_condition .= " productID IN (";
        if ($icounter > 0)
            $category_condition .= ",";
        $category_condition .= (int)$product[0];
        $icounter++;
    }
    if ($icounter > 0) $category_condition .= ")";

    if ($condition == "") {
        if ($category_condition == "")
            return "categoryID=" . (int)$categoryID;
        else
            return "(" . $category_condition . " OR categoryID=" . (int)$categoryID . ")";
    } else {
        if ($category_condition == "")
            return $condition . " AND categoryID=" . (int)$categoryID;
        else
            return "(" . $condition . " AND (" . $category_condition . " OR categoryID=" . (int)$categoryID . "))";
    }
}


function _testExtraParametrsTemplate($productID, &$template)
{

    // get category ID
    $categoryID = $template["categoryID"];

    foreach ($template as $key => $item) {

        if (!isset($item["optionID"])) continue;

        if ((string)$key == "categoryID") continue;

        // get value to search
        if ($item['set_arbitrarily'] == 1) {

            $valueFromForm = $item["value"];
        } else {

            if ((int)$item["value"] == 0) continue;

            if (!isset($template[$key]['__option_value_from_db'])) {

                $SQL = 'select option_value FROM ?#PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE WHERE variantID=?
                                ';
                $option_value = db_fetch_assoc(db_phquery($SQL, (int)$item['value']));
                $template[$key]['__option_value_from_db'] = $option_value['option_value'];
            }
            $valueFromForm = $template[$key]['__option_value_from_db'];
        }

        // get option value
        $SQL = 'select option_value, option_type FROM ?#PRODUCT_OPTIONS_VALUES_TABLE WHERE optionID=? AND productID=?
                ';
        $q = db_phquery($SQL, (int)$item['optionID'], (int)$productID);

        if (!($row = db_fetch_row($q))) {

            if (trim($valueFromForm) == '') continue;
            else return false;
        }

        $option_value = $row['option_value'];
        $option_type = $row['option_type'];
        $valueFromDataBase = array();

        if ($option_type == 0) {

            $valueFromDataBase[] = $option_value;
        } else {

            $SQL = 'select povv.option_value FROM ?#PRODUCTS_OPTIONS_SET_TABLE as pos
                                LEFT JOIN ?#PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE as povv ON pos.variantID=povv.variantID WHERE pos.optionID=? AND pos.productID=?
                        ';
            $result = db_phquery($SQL, (int)$item["optionID"], (int)$productID);
            while ($Row = db_fetch_assoc($result)) {

                $valueFromDataBase[] = $Row['option_value'];
            }
        }

        if (trim($valueFromForm) != '') {

            $existFlag = false;
            $vcount = count($valueFromDataBase);
            for ($v = 0; $v < $vcount; $v++) {
                if (strstr(strtolower((string)trim($valueFromDataBase[$v])), strtolower((string)trim($valueFromForm)))) {
                    $existFlag = true;
                    break;
                }
            }
            if (!$existFlag) return false;
        }
    }
    return true;
}


function _deletePercentSymbol(&$str)
{
    $str = str_replace("%", "", $str);
    return $str;
}


function prdSearchProductByTemplateAdmin($callBackParam, &$count_row, $navigatorParams = null)
{
    // navigator params
    if ($navigatorParams != null) {
        $offset = xEscSQL($navigatorParams["offset"]);
        $CountRowOnPage = xEscSQL($navigatorParams["CountRowOnPage"]);
    } else {
        $offset = 0;
        $CountRowOnPage = 0;
    }

    if (isset($callBackParam["extraParametrsTemplate"])) {

        $replicantExtraParametersTpl = $callBackParam["extraParametrsTemplate"];
    }
    // special symbol prepare
    if (isset($callBackParam["search_simple"])) {
        /*                for( $i=0; $i<count($callBackParam["search_simple"]); $i++ )
                        {
                                $callBackParam["search_simple"][$i] = $callBackParam["search_simple"][$i];
                        }*/
        _deletePercentSymbol($callBackParam["search_simple"]);
    }
    if (isset($callBackParam["name"])) {
        for ($i = 0; $i < count($callBackParam["name"]); $i++)
            $callBackParam["name"][$i] = xToText(trim($callBackParam["name"][$i]));
        _deletePercentSymbol($callBackParam["name"][$i]);
    }
    if (isset($callBackParam["product_code"])) {
        for ($i = 0; $i < count($callBackParam["product_code"]); $i++) {
            $callBackParam["product_code"][$i] = xToText(trim($callBackParam["product_code"][$i]));
        }
        _deletePercentSymbol($callBackParam["product_code"]);
    }

    if (isset($callBackParam["extraParametrsTemplate"])) {
        foreach ($callBackParam["extraParametrsTemplate"] as $key => $value) {
            if (is_int($key)) {
                $callBackParam["extraParametrsTemplate"][$key] = xEscSQL(trim($callBackParam["extraParametrsTemplate"][$key]));
                _deletePercentSymbol($callBackParam["extraParametrsTemplate"][$key]);
            }
        }
    }


    $where_clause = "";

    if (isset($callBackParam["search_simple"])) {
        if (!count($callBackParam["search_simple"])) //empty array
        {
            $where_clause = " where 0";
        } else //search array is not empty
        {
            $sscount = count($callBackParam["search_simple"]);
            for ($n = 0; $n < $sscount; $n++) {
                if ($where_clause != "") $where_clause .= " AND ";
                $where_clause .= " ( LOWER(name) LIKE '%" . xToText(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' OR " .
                    "   LOWER(description) LIKE '%" . xEscSQL(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' OR " .
                    "   LOWER(product_code) LIKE '%" . xEscSQL(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' OR " .
                    "   LOWER(brief_description) LIKE '%" . xEscSQL(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' ) ";
            }

            if ($where_clause != "") {
                $where_clause = " where categoryID>1 and enabled=1 and " . $where_clause;
            } else {
                $where_clause = " where categoryID>1 and enabled=1";
            }


        }

    } else {

        // "enabled" parameter
        if (isset($callBackParam["enabled"])) {
            if ($where_clause != "")
                $where_clause .= " AND ";
            $where_clause .= " enabled=" . (int)$callBackParam["enabled"];
        }

        // take into "name" parameter
        if (isset($callBackParam["name"])) {
            foreach ($callBackParam["name"] as $name)
                if (strlen($name) > 0) {
                    if ($where_clause != "")
                        $where_clause .= " AND ";
                    $where_clause .= " LOWER(name) LIKE '%" . xToText(trim(strtolower($name))) . "%' ";
                }
        }

        // take into "product_code" parameter
        if (isset($callBackParam["product_code"])) {
            foreach ($callBackParam["product_code"] as $product_code) {
                if ($where_clause != "")
                    $where_clause .= " AND ";
                $where_clause .= " LOWER(product_code) LIKE '%" . xToText(trim(strtolower($product_code))) . "%' ";
            }
        }

        // take into "price" parameter
        if (isset($callBackParam["price"])) {
            $price = $callBackParam["price"];

            if (trim($price["from"]) != "" && $price["from"] != null) {
                if ($where_clause != "")
                    $where_clause .= " AND ";
                $from = ConvertPriceToUniversalUnit($price["from"]);
                $where_clause .= " Price>=" . (double)$from . " ";
            }
            if (trim($price["to"]) != "" && $price["to"] != null) {
                if ($where_clause != "")
                    $where_clause .= " AND ";
                $to = ConvertPriceToUniversalUnit($price["to"]);
                $where_clause .= " Price<=" . (double)$to . " ";
            }
        }


        // categoryID
        if (isset($callBackParam["categoryID"])) {
            $searchInSubcategories = false;
            if (isset($callBackParam["searchInSubcategories"])) {
                if ($callBackParam["searchInSubcategories"])
                    $searchInSubcategories = true;
                else
                    $searchInSubcategories = false;
            }

            if ($searchInSubcategories) {
                $where_clause = _getConditionWithCategoryConjWithSubCategories($where_clause,
                    $callBackParam["categoryID"]);
            } else {
                $where_clause = _getConditionWithCategoryConj($where_clause,
                    $callBackParam["categoryID"]);
            }
        }

        if ($where_clause != "")
            $where_clause = "where " . $where_clause;

    }


    $order_by_clause = "order by " . CONF_DEFAULT_SORT_ORDER;

    if (isset($callBackParam["sort"])) {
        if ($callBackParam["sort"] == "categoryID" ||
            $callBackParam["sort"] == "name" ||
            $callBackParam["sort"] == "brief_description" ||
            $callBackParam["sort"] == "in_stock" ||
            $callBackParam["sort"] == "Price" ||
            $callBackParam["sort"] == "customer_votes" ||
            $callBackParam["sort"] == "customers_rating" ||
            $callBackParam["sort"] == "list_price" ||
            $callBackParam["sort"] == "sort_order" ||
            $callBackParam["sort"] == "items_sold" ||
            $callBackParam["sort"] == "product_code" ||
            $callBackParam["sort"] == "shipping_freight" ||
            $callBackParam["sort"] == "viewed_times"
        ) {
            $order_by_clause = " order by " . xEscSQL($callBackParam["sort"]) . " ASC ";
            if (isset($callBackParam["direction"]))
                if ($callBackParam["direction"] == "DESC")
                    $order_by_clause = " order by " . xEscSQL($callBackParam["sort"]) . " DESC ";
        }
    }

    $sqlQueryCount = "select count(*) from " . PRODUCTS_TABLE . " " . $where_clause;
    $q = db_query($sqlQueryCount);
    $products_count = db_fetch_row($q);
    $products_count = $products_count[0];
    $limit_clause = (isset($callBackParam["extraParametrsTemplate"]) || !$CountRowOnPage) ? "" : " LIMIT " . $offset . "," . $CountRowOnPage;
    $sqlQuery = "select categoryID, name, brief_description, " .
        " customers_rating, Price, in_stock, " .
        " customer_votes, list_price, " .
        " productID, default_picture, sort_order, items_sold, enabled, " .
        " product_code, description, shipping_freight, viewed_times, min_order_amount from " . PRODUCTS_TABLE . " " .
        $where_clause . " " . $order_by_clause . $limit_clause;

    $q = db_query($sqlQuery);
    $result = array();
    $i = 0;

    if ($offset >= 0 && $offset <= $products_count) {
        while ($row = db_fetch_row($q)) {

            if (isset($callBackParam["extraParametrsTemplate"])) {

                // take into "extra" parametrs
                $testResult = _testExtraParametrsTemplate($row["productID"], $replicantExtraParametersTpl);
                if (!$testResult) continue;
            }

            if ((($i >= $offset || !isset($callBackParam["extraParametrsTemplate"])) && $i < $offset + $CountRowOnPage) ||
                $navigatorParams == null
            ) {
                $row["PriceWithUnit"] = show_price($row["Price"]);
                $row["list_priceWithUnit"] = show_price($row["list_price"]);
                // you save (value)
                $row["SavePrice"] = show_price($row["list_price"] - $row["Price"]);

                // you save (%)
                if ($row["list_price"]) $row["SavePricePercent"] = ceil(((($row["list_price"] - $row["Price"]) / $row["list_price"]) * 100));
                _setPictures($row);
                $row["product_extra"] = GetProductExtra($row["productID"]);
                $row["product_extra_count"] = count($row["product_extra"]);
                $row["PriceWithOutUnit"] = show_priceWithOutUnit($row["Price"]);
                if (((double)$row["shipping_freight"]) > 0) $row["shipping_freightUC"] = show_price($row["shipping_freight"]);
                $row["name"] = $row["name"];
                $row["description"] = $row["description"];
                $row["brief_description"] = $row["brief_description"];
                $row["product_code"] = $row["product_code"];
                $row["viewed_times"] = $row["viewed_times"];
                $row["items_sold"] = $row["items_sold"];
                $result[] = $row;
            }
            $i++;
        }
    }
    $count_row = isset($callBackParam["extraParametrsTemplate"]) ? $i : $products_count;
    return $result;
}


function prdSearchProductByTemplate($callBackParam, &$count_row, $navigatorParams = null)
{
    // navigator params
    if ($navigatorParams != null) {
        $offset = xEscSQL($navigatorParams["offset"]);
        $CountRowOnPage = xEscSQL($navigatorParams["CountRowOnPage"]);
    } else {
        $offset = 0;
        $CountRowOnPage = 0;
    }

    if (isset($callBackParam["extraParametrsTemplate"])) {

        $replicantExtraParametersTpl = $callBackParam["extraParametrsTemplate"];
    }
    // special symbol prepare
    if (isset($callBackParam["search_simple"])) {
        /*                for( $i=0; $i<count($callBackParam["search_simple"]); $i++ )
                        {
                                $callBackParam["search_simple"][$i] = $callBackParam["search_simple"][$i];
                        }*/
        _deletePercentSymbol($callBackParam["search_simple"]);
    }
    if (isset($callBackParam["name"])) {
        for ($i = 0; $i < count($callBackParam["name"]); $i++)
            $callBackParam["name"][$i] = xToText(trim($callBackParam["name"][$i]));
        _deletePercentSymbol($callBackParam["name"][$i]);
    }
    if (isset($callBackParam["product_code"])) {
        for ($i = 0; $i < count($callBackParam["product_code"]); $i++) {
            $callBackParam["product_code"][$i] = xToText(trim($callBackParam["product_code"][$i]));
        }
        _deletePercentSymbol($callBackParam["product_code"]);
    }

    if (isset($callBackParam["extraParametrsTemplate"])) {
        foreach ($callBackParam["extraParametrsTemplate"] as $key => $value) {
            if (is_int($key)) {
                $callBackParam["extraParametrsTemplate"][$key] = xEscSQL(trim($callBackParam["extraParametrsTemplate"][$key]));
                _deletePercentSymbol($callBackParam["extraParametrsTemplate"][$key]);
            }
        }
    }


    $where_clause = "";

    if (isset($callBackParam["search_simple"])) {
        if (!count($callBackParam["search_simple"])) //empty array
        {
            $where_clause = " where 0";
        } else //search array is not empty
        {
            $sscount = count($callBackParam["search_simple"]);
            for ($n = 0; $n < $sscount; $n++) {
                if ($where_clause != "") $where_clause .= " AND ";
                $where_clause .= " ( LOWER(name) LIKE '%" . xToText(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' OR " .
                    "   LOWER(description) LIKE '%" . xEscSQL(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' OR " .
                    "   LOWER(product_code) LIKE '%" . xEscSQL(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' OR " .
                    "   LOWER(brief_description) LIKE '%" . xEscSQL(trim(strtolower($callBackParam["search_simple"][$n]))) . "%' ) ";
            }

            if ($where_clause != "") {
                $where_clause = " where categoryID>1 and enabled=1 and " . $where_clause;
            } else {
                $where_clause = " where categoryID>1 and enabled=1";
            }

            if (CONF_CHECKSTOCK && CONF_SHOW_NULL_STOCK) {
                if ($where_clause != "")
                    $where_clause .= " AND in_stock>0 ";
                else
                    $where_clause = "where in_stock>0 ";
            }
        }

    } else {

        // "enabled" parameter
        if (isset($callBackParam["enabled"])) {
            if ($where_clause != "")
                $where_clause .= " AND ";
            $where_clause .= " enabled=" . (int)$callBackParam["enabled"];
        }

        // take into "name" parameter
        if (isset($callBackParam["name"])) {
            foreach ($callBackParam["name"] as $name)
                if (strlen($name) > 0) {
                    if ($where_clause != "")
                        $where_clause .= " AND ";
                    $where_clause .= " LOWER(name) LIKE '%" . xToText(trim(strtolower($name))) . "%' ";
                }
        }

        // take into "product_code" parameter
        if (isset($callBackParam["product_code"])) {
            foreach ($callBackParam["product_code"] as $product_code) {
                if ($where_clause != "")
                    $where_clause .= " AND ";
                $where_clause .= " LOWER(product_code) LIKE '%" . xToText(trim(strtolower($product_code))) . "%' ";
            }
        }

        // take into "price" parameter
        if (isset($callBackParam["price"])) {
            $price = $callBackParam["price"];

            if (trim($price["from"]) != "" && $price["from"] != null) {
                if ($where_clause != "")
                    $where_clause .= " AND ";
                $from = ConvertPriceToUniversalUnit($price["from"]);
                $where_clause .= " Price>=" . (double)$from . " ";
            }
            if (trim($price["to"]) != "" && $price["to"] != null) {
                if ($where_clause != "")
                    $where_clause .= " AND ";
                $to = ConvertPriceToUniversalUnit($price["to"]);
                $where_clause .= " Price<=" . (double)$to . " ";
            }
        }

        if (CONF_CHECKSTOCK && CONF_SHOW_NULL_STOCK) {
            if ($where_clause != "")
                $where_clause .= " AND in_stock>0 ";
            else
                $where_clause = "where in_stock>0 ";
        }

        // categoryID
        if (isset($callBackParam["categoryID"])) {
            $searchInSubcategories = false;
            if (isset($callBackParam["searchInSubcategories"])) {
                if ($callBackParam["searchInSubcategories"])
                    $searchInSubcategories = true;
                else
                    $searchInSubcategories = false;
            }

            if ($searchInSubcategories) {
                $where_clause = _getConditionWithCategoryConjWithSubCategories($where_clause,
                    $callBackParam["categoryID"]);
            } else {
                $where_clause = _getConditionWithCategoryConj($where_clause,
                    $callBackParam["categoryID"]);
            }
        }

        if ($where_clause != "")
            $where_clause = "where " . $where_clause;

    }


    $order_by_clause = "order by " . CONF_DEFAULT_SORT_ORDER . "";

    if (isset($callBackParam["sort"])) {
        if ($callBackParam["sort"] == "categoryID" ||
            $callBackParam["sort"] == "name" ||
            $callBackParam["sort"] == "brief_description" ||
            $callBackParam["sort"] == "in_stock" ||
            $callBackParam["sort"] == "Price" ||
            $callBackParam["sort"] == "customer_votes" ||
            $callBackParam["sort"] == "customers_rating" ||
            $callBackParam["sort"] == "list_price" ||
            $callBackParam["sort"] == "sort_order" ||
            $callBackParam["sort"] == "items_sold" ||
            $callBackParam["sort"] == "product_code" ||
            $callBackParam["sort"] == "shipping_freight" ||
            $callBackParam["sort"] == "viewed_times"
        ) {
            $order_by_clause = " order by " . xEscSQL($callBackParam["sort"]) . " ASC ";
            if (isset($callBackParam["direction"]))
                if ($callBackParam["direction"] == "DESC")
                    $order_by_clause = " order by " . xEscSQL($callBackParam["sort"]) . " DESC ";
        }
    }

    $sqlQueryCount = "select count(*) from " . PRODUCTS_TABLE . " " . $where_clause;
    $q = db_query($sqlQueryCount);
    $products_count = db_fetch_row($q);
    $products_count = $products_count[0];
    $limit_clause = (isset($callBackParam["extraParametrsTemplate"]) || !$CountRowOnPage) ? "" : " LIMIT " . $offset . "," . $CountRowOnPage;


    $sql = "select categoryID, name, brief_description, " .
        " customers_rating, Price, in_stock, " .
        " customer_votes, list_price, " .
        " productID, default_picture, sort_order, items_sold, enabled, " .
        " product_code, description, shipping_freight, viewed_times, min_order_amount from " . PRODUCTS_TABLE . " " .
        $where_clause . " " . $order_by_clause . $limit_clause;


    $q = db_query($sql);
    $result = array();
    $i = 0;

    if ($offset >= 0 && $offset <= $products_count) {
        while ($row = db_fetch_row($q)) {

//            if (isset($callBackParam["extraParametrsTemplate"])) {
//
//                // take into "extra" parametrs
//                $testResult = _testExtraParametrsTemplate($row["productID"], $replicantExtraParametersTpl);
//                if (!$testResult) continue;
//            }

            if ((($i >= $offset || !isset($callBackParam["extraParametrsTemplate"])) && $i < $offset + $CountRowOnPage) ||
                $navigatorParams == null
            ) {

                _setPictures($row);
                $row = array_merge($row, getProductData($row));

                $result[] = $row;
            }
            $i++;
        }
    }


    $count_row = isset($callBackParam["extraParametrsTemplate"]) ? $i : $products_count;
    return $result;
}


function prdGetMetaKeywordTag($productID)
{
    $q = db_query("select meta_description from " . PRODUCTS_TABLE . " where productID=" . (int)$productID);
    if ($row = db_fetch_row($q))
        return $row["meta_description"];
    else
        return "";
}

function prdGetMetaTags($productID) //gets META keywords and description - an HTML code to insert into <head> section
{
    $q = db_query("select meta_description, meta_keywords from " .
        PRODUCTS_TABLE . " where productID=" . (int)$productID);
    $row = db_fetch_row($q);
    $meta_description = $row["meta_description"];
    $meta_keywords = $row["meta_keywords"];

    $res = "";

    if ($meta_description != "")
        $res .= "<meta name=\"Description\" content=\"" . $meta_description . "\">\n";
    if ($meta_keywords != "")
        $res .= "<meta name=\"KeyWords\" content=\"" . $meta_keywords . "\" >\n";

    return $res;
}

?>