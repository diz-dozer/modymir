<table class="adn">
    <tr>
        <td class="se"></td>
    </tr>
</table>
<table width="186" class="adw" style="margin: auto;">
    {if $admin_sub_dpt eq "custord_custlist.tpl"}
        <tr>
            <td class="head2">
                <table class="adn">
                    <tr>
                        <td class="head3">{$smarty.const.ADMIN_CUSTOMERS}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dvmenu">
                    <form name="leftsrform" method=GET id="leftsrform" action="">
                        <table border="0" cellspacing="4">

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.ADMIN_CUSTOMER_LOGIN}</div>
                                    <input type="text" name="login" value='{$login}' class="prc" size="25"></td>
                            </tr>

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.ADMIN_CUSTOMER_FIRST_NAME}</div>
                                    <input type="text" name="first_name" value='{$first_name}' class="prc" size="25">
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.ADMIN_CUSTOMER_LAST_NAME}</div>
                                    <input type="text" name="last_name" value='{$last_name}' class="prc" size="25"></td>
                            </tr>

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.ADMIN_CUSTOMER_EMAIL}</div>
                                    <input type="text" name="email" value='{$email}' class="prc" size="25"></td>
                            </tr>

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.ADMIN_CUSTOMER_GROUP_NAME}</div>
                                    <select name="groupID">

                                        <option value='0'>
                                            {$smarty.const.STRING_ANY}
                                        </option>

                                        {section name=i loop=$customer_groups}
                                            <option value='{$customer_groups[i].custgroupID}'
                                                    {if $groupID == $customer_groups[i].custgroupID}
                                                        selected
                                                    {/if}
                                                    >
                                                {$customer_groups[i].custgroup_name}
                                            </option>
                                        {/section}

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.STRING_MODULE_STATUS}</div>

                                    <select name="fActState">
                                        <option value='-1'{if $ActState eq -1} selected="selected"{/if}>
                                            {$smarty.const.STRING_ANY_M}
                                        </option>
                                        <option value='1'{if $ActState eq 1} selected="selected"{/if}>
                                            {$smarty.const.STR_ACTIVATED}
                                        </option>
                                        <option value='0'{if $ActState eq 0 && $ActState ne ''} selected="selected"{/if}>
                                            {$smarty.const.STR_NOTACTIVATED}
                                        </option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <input type=hidden name='dpt' value='custord'> <input type=hidden name='sub' value='custlist'>
                        <input type=hidden name='search' value="1">
                    </form>
                    <br>

                    <div align="center">
                        <img src="data/admin/spl.gif" alt="" onclick="document.getElementById('leftsrform').submit();" style="cursor: pointer;">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="se"></td>
        </tr>
    {/if}


    {if $admin_sub_dpt eq "custord_affiliate.tpl" && $smarty.const.CONF_AFFILIATE_PROGRAM_ENABLED eq 1}
        <tr>
            <td class="head2">
                <table class="adn">
                    <tr>
                        <td class="head3">{$smarty.const.AFFP_COMMISSION_PAYMENTS}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dvmenu">
                    {$smarty.const.STRING_CALENDAR}
                    <br> {if $Error_DateFormat}<span style="color: red;">{$smarty.const.AFFP_MSG_ERROR_DATE_FORMAT}</span><br>{/if}
                    <form method="POST" action="{$REQUEST_URI}" id="leftsrform">
                        <table border="0" cellspacing="4">

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.STRING_FROM}:</div>
                                    <input type="text" name="from" value="{$from}" class="prc" size="25"></td>
                            </tr>

                            <tr>
                                <td>
                                    <div align="left" style="padding-bottom: 2px;">{$smarty.const.STRING_TILL}:</div>
                                    <input name="till" value="{$till}" type="text" class="prc" size="25"></td>
                            </tr>

                        </table>
                    </form>
                    <br>

                    <div align="center">
                        <img src="data/admin/spl.gif" alt="" onclick="document.getElementById('leftsrform').submit();" style="cursor: pointer;">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="se"></td>
        </tr>
    {/if}




    {if $admin_sub_dpt eq "catalog_products_categories.tpl"}
        <tr>
            <td class="head2">
                <table class="adn">
                    <tr>
                        <td class="head4">{$smarty.const.ADMIN_CATALOG_CATV}</td>
                        <td align="right">
                            <div align="right">
                                <a href='{$urlToCategoryTreeExpand}&amp;expandCatp=all' title="{$smarty.const.ADMIN_ADMIN_MENUNEW2}" style="cursor: pointer;"><img src="data/admin/004.gif" alt=""></a>
                            </div>
                        </td>
                        <td align="right" class="head7">
                            <div align="right">
                                <a href='{$urlToCategoryTreeExpand}&amp;shrinkCatm=all' title="{$smarty.const.ADMIN_ADMIN_MENUNEW3}" style="cursor: pointer;"><img src="data/admin/003.gif" alt=""></a>
                            </div>
                        </td>

                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dvmenusmall">
                    <table class="adn">
                        <tr>
                            <td class="l1"><img src="data/admin/dr.gif" alt=""></td>
                            <td class="l2">
                                <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=products_categories&amp;categoryID=1">{$smarty.const.ADMIN_CATEGORY_ROOT}</a>
                            </td>
                            <td class="l3">{$products_in_root_category}</td>
                        </tr>
                    </table>
                    {section name=i loop=$categories}
                        <table class="adn">
                            <tr>
                                <td class="l1">{section name=j loop=$categories[i].level max=$categories[i].level}{if $smarty.section.j.index==$categories[i].level-1}
                                    <img src="data/admin/pm.gif" alt="">{else}
                                    <img src="data/admin/pmp.gif" alt="">{/if}{/section}{if !$categories[i].ExpandedCategory}{if $categories[i].ExistSubCategories}
                                    <a href='{$urlToCategoryTreeExpand}&amp;expandCat={$categories[i].categoryID}'><img src="data/admin/mplus.gif" alt=""></a>{else}
                                    <img src="data/admin/dr.gif" alt="">{/if}{else}{if $categories[i].ExistSubCategories}
                                    <a href='{$urlToCategoryTreeExpand}&amp;shrinkCat={$categories[i].categoryID}'><img src="data/admin/minus.gif" alt=""></a>{else}
                                    <img src="data/admin/dr.gif" alt="">{/if}{/if}</td>
                                <td class="l2">
                                    <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=products_categories&amp;categoryID={$categories[i].categoryID}&amp;expandCat={$categories[i].categoryID}">{$categories[i].name}</a>
                                </td>
                                <td class="l3">
                                    <a href="{$smarty.const.ADMIN_FILE}?categoryID={$categories[i].categoryID}&amp;eaction=cat">{if !$categories[i].ExpandedCategory}{$categories[i].products_count_admin}{else}{$categories[i].products_count_category}{/if}</a>
                                </td>
                            </tr>
                        </table>
                    {/section}</div>
            </td>
        </tr>
        <tr>
            <td class="se"></td>
        </tr>
    {/if}
    {if $admin_sub_dpt eq "custord_new_orders.tpl"}
        <tr>
            <td class="head2">
                <table class="adn">
                    <tr>
                        <td class="head3">{$smarty.const.ADMIN_TX23}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dvmenu">
                    <script type="text/javascript">
                        <!--
                        {literal}
                        function checkBoxes(_idForm, _syncID, _checkableID) {

                            if (document.getElementById(_syncID).checked == false) {
                                {/literal}
                                {section name=i loop=$order_statuses}
                                document.getElementById('checkbox_order_status_{$order_statuses[i].statusID}').checked = false;
                                {/section}
                                {literal}
                            } else {
                                {/literal}
                                {section name=i loop=$order_statuses}
                                document.getElementById('checkbox_order_status_{$order_statuses[i].statusID}').checked = true;
                                {/section}
                                {literal}
                            }
                            return true;
                        }
                        {/literal}
                        //-->
                    </script>
                    <form method=GET action="{$smarty.const.ADMIN_FILE}" name=MainForm id="MainForm">
                        <table class="adw">
                            <tr>
                                <td align="left" width="16" valign="middle">
                                    <input type=radio class="round" name=order_search_type id=order_search_type1 value='SearchByOrderID'
                                            {if $order_search_type == 'SearchByOrderID' || $order_search_type == null}
                                                checked
                                            {/if}
                                            onclick='order_search_typeClickHandler()'></td>
                                <td valign="middle" height="20">{$smarty.const.ADMIN_ORDER_SEARCH_BY_NUMBER}</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td align="left">
                                    <input type=text name='orderID_textbox' id='orderID_textbox' value='{$orderID}' class="prc" size="21">
                                </td>
                            </tr>
                            <tr>
                                <td height="6" colspan="2"></td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <input type=radio class="round" name=order_search_type id=order_search_type2 value='SearchByStatusID'
                                            {if $order_search_type == 'SearchByStatusID'} checked {/if} onclick='order_search_typeClickHandler()'>
                                </td>
                                <td valign="middle">&nbsp;{$smarty.const.ADMIN_SHOW_ORDER_IN_STATUS}</td>
                            </tr>
                            <tr>
                                <td height="5" colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    {if $order_statuses}
                                        <table class="adw">
                                            <tr>
                                                <td height="20" width="16">
                                                    <input id="id_checkall" class="round" onclick="checkBoxes('MainForm', 'id_checkall', 'id_ch');" type="checkbox" name="chk">
                                                </td>
                                                <td align="left" nowrap="nowrap" valign="middle">&nbsp;{$smarty.const.ADMIN_SHOW_ALLL}</td>
                                            </tr>
                                            {section name=i loop=$order_statuses}
                                                <tr>
                                                    <td height="18" width="16">
                                                        <input type=checkbox class="round" name=checkbox_order_status_{$order_statuses[i].statusID}  id=checkbox_order_status_{$order_statuses[i].statusID}
                                                                {if $order_statuses[i].selected == 1} checked {/if} value='1'>
                                                    </td>
                                                    <td align="left" nowrap="nowrap" valign="middle">&nbsp;{$order_statuses[i].status_name}</td>
                                                </tr>
                                            {/section}
                                        </table>
                                    {/if}
                                    <script type="text/javascript">
                                        function order_search_typeClickHandler() {literal}{{/literal}

                                            if (document.getElementById('order_search_type1').checked) {literal}{{/literal}
                                                {section name=i loop=$order_statuses}
                                                document.getElementById('checkbox_order_status_{$order_statuses[i].statusID}').disabled = true;
                                                {/section}
                                                document.getElementById('orderID_textbox').disabled = false;
                                                document.getElementById('id_checkall').disabled = true;
                                                {literal}
                                            }{/literal}
                                            else if (document.getElementById('order_search_type2').checked) {literal}{{/literal}
                                                {section name=i loop=$order_statuses}
                                                document.getElementById('checkbox_order_status_{$order_statuses[i].statusID}').disabled = false;
                                                {/section}
                                                document.getElementById('orderID_textbox').disabled = true;
                                                document.getElementById('id_checkall').disabled = false;
                                                {literal}
                                            }
                                            {/literal}
                                            {literal}
                                        }
                                        {/literal}

                                        order_search_typeClickHandler();
                                    </script>
                                </td>
                            </tr>
                        </table>


                        {if $offset}
                            <input type='hidden' name='offset' value='{$offset}'>
                        {/if}

                        {if $show_all}
                            <input type='hidden' name='show_all' value='{$show_all}'>
                        {/if}
                        <input type=hidden name=dpt value=custord> <input type=hidden name=sub value=new_orders>
                        <input type=hidden name="search">
                    </form>
                    <table class="adn">
                        <tr>
                            <td height="8"></td>
                        </tr>
                    </table>
                    <div align="center">
                        <img src="data/admin/spl.gif" alt="" onclick="document.getElementById('MainForm').submit()" style="cursor: pointer;">
                    </div>
                    <input type=hidden name="search"></div>
            </td>
        </tr>
        <tr>
            <td class="se"></td>
        </tr>
        <tr>
            <td class="head2">
                <table class="adn">
                    <tr>
                        <td class="head3">{$smarty.const.STRING_ORD_DEL1}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dvmenu">
                    <div align="center" style="padding-bottom: 5px;">{$smarty.const.STRING_ORD_DEL2}:</div>
                    <div align="center">
                        <form method=GET action="{$smarty.const.ADMIN_FILE}" name="delordform" id="delordform">
                            <select name="status_del">
                                {section name=i loop=$order_statuses}
                                    <option value="{$order_statuses[i].statusID}"> {$order_statuses[i].status_name} </option>
                                {/section}
                            </select> <input type=hidden name=dpt value=custord>
                            <input type=hidden name=sub value=new_orders></form>
                    </div>
                    <table class="adn">
                        <tr>
                            <td height="8"></td>
                        </tr>
                    </table>
                    <div align="center">
                        <img src="data/admin/delkn.gif" alt="" onclick="confirmDeletef('delordform','{$smarty.const.QUESTION_DELETE_CONFIRMATION_ZAK}'); return false" style="cursor: pointer">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="se"></td>
        </tr>
    {/if}
    {if $admin_sub_dpt eq "modules_linkexchange.tpl"}
        <tr>
            <td class="head2">
                <table class="adn">
                    <tr>
                        <td class="head3">{$smarty.const.ADMIN_LINKS_CATC}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dvmenusmall">
                    <script type="text/javascript">
                        <!--
                        var _curEditCategory = Array();
                        _curEditCategory['le_cID'] = 0;
                        _curEditCategory['le_cName'] = '';
                        var _cur_le_cID = '{$le_CategoryID}';
                        var _url_pref = '{"msg=&amp;page=1&amp;categoryID="|set_query}';
                        var _request_uri = '{$REQUEST_URI}';
                        {literal}

                        function checkBoxes(_idForm, _syncID, _checkableID) {

                            for (_i = 0; _i < document.getElementById(_idForm).elements.length; _i++) {

                                if (document.getElementById(_idForm).elements[_i].type == 'checkbox' && document.getElementById(_idForm).elements[_i].id == _checkableID) {

                                    document.getElementById(_idForm).elements[_i].checked = document.getElementById(_syncID).checked;
                                }
                            }
                            return true;
                        }

                        function show_rencat_block(_cID, _cName) {
                            var _t = '';
                            _cName = _cName.replace('"', '&quot;');
                            while (_t != _cName) {

                                _t = _cName;
                                _cName = _cName.replace('"', '&quot;');
                            }
                            _cName = _cName.replace('>', '&gt;');
                            _cName = _cName.replace('<', '&lt;');

                            if (_curEditCategory['le_cID'] != _cID) {

                                if (_curEditCategory['le_cID']) {

                                    document.getElementById('category_renblock').innerHTML = '';
                                }
                                {/literal}
                                _curEditCategory['le_cID'] = _cID;
                                _curEditCategory['le_cName'] = _cName;
                                document.getElementById('category_renblock').style.display = 'block';
                                document.getElementById('category_renblock').innerHTML = '<form action="" method="POST" id="form_rename_linkcategory" name="catform">' +
                                        '<input name="fACTION" value="SAVE_LINK_CATEGORY" type="hidden" />' +
                                        '<input name="fREDIRECT" value="' + _request_uri + '" type="hidden" />' +
                                        '<input name="LINK_CATEGORY[le_cID]" type="hidden" value="' + _cID + '" />' +
                                        '<table class="adn"><tr class="lineb"><td align="left">{$smarty.const.CAT_REN}<\/td><\/tr>' +
                                        '<tr class="lins"><td align="left"><input name="LINK_CATEGORY[le_cName]" value="' + _cName + '" type="text" size="40" class="textp"><\/td><\/tr><\/table>' +
                                        '<table class="adn"><tr><td class="separ"><img src="core\/tpl\/admin\/images\/pixel.gif" alt="" class="sep"><\/td><\/tr><tr><td class="se5"><\/td><\/tr><\/table><a href="#" onclick="catform.submit()" class="inl">{$smarty.const.SAVE_BUTTON}<\/a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" onclick="return delete_category(' + _cID + ')" class="inl">{$smarty.const.DELETE_BUTTON}<\/a><table class="adn"><tr><td class="se6"><\/td><\/tr><\/table>' +
                                        '<\/form>';
                                {literal}
                            } else {

                                document.getElementById('category_renblock').style.display = 'none';
                                document.getElementById('category_renblock').innerHTML = '';
                                _curEditCategory['le_cID'] = 0;
                                _curEditCategory['le_cName'] = '';
                            }
                        }

                        function le_show_newlink() {

                            var lenl = document.getElementById('le_new_link');
                            if (lenl.style.display != 'block') {
                                lenl.style.display = 'block';
                            } else {
                                lenl.style.display = 'none';
                            }
                        }

                        function delete_category(_cID) {

                            if (window.confirm('{/literal}{$smarty.const.QUESTION_DELETE_CONFIRMATION}{literal}')) {

                                document.getElementById('form_delete_linkcategory').elements['LINK_CATEGORY[le_cID]'].value = _cID;
                                document.form_delete_linkcategory.submit();
                            }
                            return false;
                        }
                        {/literal}
                        //-->
                    </script>
                    {* link categories *}
                    {assign var='le_CategoryName' value=$smarty.const.ADMIN_LE_ALL_CATEGORIES}
                    <table class="adn">
                        <tr>
                            <td class="l1"><img src="data/admin/dr.gif" alt=""></td>
                            <td class="l2"><a href="{$url_allcategories}">{$smarty.const.ADMIN_LE_ALL_CATEGORIES}</a>
                            </td>
                            <td class="l3">{$le_LinksNumInCategories}</td>
                        </tr>
                    </table>
                    {section name=i loop=$le_categories}
                        {if $le_categories[i].le_cID==$le_CategoryID}
                            {assign var='le_CategoryName' value=$le_categories[i].le_cName}
                        {/if}
                        <table class="adn">
                            <tr>
                                <td class="l1"><img src="data/admin/dr.gif" alt=""></td>
                                <td class="l2">
                                    <a href="{"msg=&page=1&show_all=&categoryID=`$le_categories[i].le_cID`"|set_query}">{$le_categories[i].le_cName}</a>
                                </td>
                                <td class="l3">
                                    <a href="#" onclick="show_rencat_block('{$le_categories[i].le_cID}', '{$le_categories[i].le_cName|replace:"\\":"\\\\"|replace:"&#039;":"\'"}');">{$le_categories[i].links_num}</a>
                                </td>
                            </tr>
                        </table>
                    {/section}
                </div>
            </td>
        </tr>
        <tr>
            <td class="se"></td>
        </tr>
    {/if}
    <tr>
        <td class="head2">
            <table class="adn">
                <tr>
                    <td class="head4" onclick="menuresetit('menu1');">{$smarty.const.ADMIN_CATALOG}</td>
                    <td align="right" class="head7">
                        <img src="data/admin/004.gif" alt="" onclick="menuresetit('menu1')" id="menu12" style="cursor: pointer;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id='menu13' style="display: none">
        <td>
            <div class="dvmenu">
                <table class="adn">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=products_categories">{$smarty.const.ADMIN_CATEGORIES_PRODUCTS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=dbsync">{$smarty.const.ADMIN_SYNCHRONIZE_TOOLS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=extra">{$smarty.const.ADMIN_PRODUCT_OPTIONS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=special">{$smarty.const.ADMIN_SPECIAL_OFFERS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=excel_import">{$smarty.const.ADMIN_IMPORT_FROM_EXCEL}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=excel_export">{$smarty.const.ADMIN_EXPORT_TO_EXCEL}</a>
                        </td>
                    </tr>
                </table>
                {*<table class="adn topj">*}
                    {*<tr>*}
                        {*<td><img src="data/admin/drs.gif" alt=""></td>*}
                        {*<td width="100%">*}
                            {*<a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=xml_import">{$smarty.const.ADMIN_IMPORT_FROM_XML}</a>*}
                        {*</td>*}
                    {*</tr>*}
                {*</table>*}
            </div>
        </td>
    </tr>
    <tr>
        <td class="se"></td>
    </tr>
    <tr>
        <td class="head2">
            <table class="adn">
                <tr>
                    <td class="head4" onclick="menuresetit('menu2');">{$smarty.const.ADMIN_CUSTOMERS_AND_ORDERS}</td>
                    <td align="right" class="head7">
                        <img src="data/admin/004.gif" alt="" onclick="menuresetit('menu2')" id="menu22" style="cursor: pointer;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id='menu23' style="display: none">
        <td>
            <div class="dvmenu">
                <table class="adn">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=new_orders">{$smarty.const.ADMIN_NEW_ORDERS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=subscribers">{$smarty.const.ADMIN_NEWS_SUBSCRIBERS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=order_statuses">{$smarty.const.ADMIN_ORDER_STATUES}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=reg_fields">{$smarty.const.ADMIN_CUSTOMER_REG_FIELDS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=discounts">{$smarty.const.ADMIN_DISCOUNT_MENU}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=aux_pages">{$smarty.const.ADMIN_TX7}</a>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td class="se"></td>
    </tr>
    <tr>
        <td class="head2">
            <table class="adn">
                <tr>
                    <td class="head4" onclick="menuresetit('menu3');">{$smarty.const.ADMIN_SETTINGS}</td>
                    <td align="right" class="head7">
                        <img src="data/admin/004.gif" alt="" onclick="menuresetit('menu3')" id="menu32" style="cursor: pointer;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id='menu33' style="display: none">
        <td>
            <div class="dvmenu">
                <table class="adn">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=setting&amp;settings_groupID=2">{$smarty.const.ADMIN_SETTINGS_GENERAL}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=currencies">{$smarty.const.ADMIN_CURRENCY_TYPES}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=shipping">{$smarty.const.ADMIN_STRING_SHIPPING_TYPE}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=payment">{$smarty.const.ADMIN_STRING_PAYMENT_TYPE}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=blocks_edit">{$smarty.const.ADMIN_TX20}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=admin_edit">{$smarty.const.ADMIN_CONF_ADMINS}</a>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td class="se"></td>
    </tr>
    <tr>
        <td class="head2">
            <table class="adn">
                <tr>
                    <td class="head4" onclick="menuresetit('menu4');">{$smarty.const.ADMIN_MODULES}</td>
                    <td align="right" class="head7">
                        <img src="data/admin/004.gif" alt="" onclick="menuresetit('menu4')" id="menu42" style="cursor: pointer;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id='menu43' style="display: none">
        <td>
            <div class="dvmenu">
                <table class="adn">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=modules&amp;sub=news">{$smarty.const.ADMIN_NEWS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=modules&amp;sub=survey">{$smarty.const.ADMIN_VOTING}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=modules&amp;sub=shipping">{$smarty.const.ADMIN_STRING_SHIPPING_MODULES}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=modules&amp;sub=payment">{$smarty.const.ADMIN_STRING_PAYMENT_MODULES}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=modules&amp;sub=linkexchange">{$smarty.const.ADMIN_STRING_MODULES_LINKEXCHANGE}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=modules&amp;sub=yandex">{$smarty.const.ADMIN_STRING_YANDEX}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=affiliate">{$smarty.const.STRING_AFFILIATE_PROGRAM}</a>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td class="se"></td>
    </tr>
    <tr>
        <td class="head2">
            <table class="adn">
                <tr>
                    <td class="head4" onclick="menuresetit('menu5');">{$smarty.const.ADMIN_REPORTS}</td>
                    <td align="right" class="head7">
                        <img src="data/admin/004.gif" alt="" onclick="menuresetit('menu5')" id="menu52" style="cursor: pointer;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id='menu53' style="display: none">
        <td>
            <div class="dvmenu">
                <table class="adn">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=reports&amp;sub=category_viewed_times">{$smarty.const.ADMIN_CATEGORY_VIEWED_TIMES}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=reports&amp;sub=customer_log">{$smarty.const.ADMIN_CUSTOMER_LOG}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=reports&amp;sub=information">{$smarty.const.ADMIN_INFORMATION2}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=reports&amp;sub=coming">{$smarty.const.ADMIN_COMING}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=reports&amp;sub=security">{$smarty.const.ADMIN_SECURITY}</a>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td class="se"></td>
    </tr>
    <tr>
        <td class="head2">
            <table class="adn">
                <tr>
                    <td class="head4" onclick="menuresetit('menu6');">{$smarty.const.ADMIN_LIST_ALL}</td>
                    <td align="right" class="head7">
                        <img src="data/admin/004.gif" alt="" onclick="menuresetit('menu6')" id="menu62" style="cursor: pointer;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id='menu63' style="display: none">
        <td>
            <div class="dvmenu">
                <table class="adn">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?login=&amp;first_name=&amp;last_name=&amp;email=&amp;groupID=0&amp;fActState=-1&amp;dpt=custord&amp;sub=custlist&amp;search=Find">{$smarty.const.ADMIN_CUSTOMERS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=custord&amp;sub=custgroup">{$smarty.const.ADMIN_CUSTGROUP}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=countries">{$smarty.const.ADMIN_MENU_TOWNS}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=conf&amp;sub=zones">{$smarty.const.ADMIN_MENU_TAXEZ}</a>
                        </td>
                    </tr>
                </table>
                <table class="adn topj">
                    <tr>
                        <td><img src="data/admin/drs.gif" alt=""></td>
                        <td width="100%">
                            <a href="{$smarty.const.ADMIN_FILE}?dpt=catalog&amp;sub=discuss">{$smarty.const.ADMIN_DISCUSSIONS}</a>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>{literal}
    <SCRIPT type="text/javascript">
        megamenu();
    </SCRIPT>
{/literal}