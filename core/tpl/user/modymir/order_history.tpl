{strip}


{if !$order_detailed}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_SHOPPING_HISTORY}
        </header>

        {include file='mod/menu_cabinet.tpl'}

        <form name='MainForm' id="MainForm" action="index.php?order_history=yes" method="get">


            <table cellspacing="0" cellpadding="0">


                <tr>
                    <td>
                        <input type=radio name=order_search_type value='SearchByOrderID'
                                {if $order_search_type == 'SearchByOrderID' || $order_search_type == null}
                                    checked="checked"
                                {/if}
                               onclick='order_search_typeClickHandler()'/>
                    </td>
                    <td valign="middle" class="padt">{$smarty.const.ADMIN_ORDER_SEARCH_BY_NUMBER}:</td>
                    <td>
                        <input type="text" name="orderID_textbox" value="{$orderID}"/>
                    </td>
                </tr>

                <tr>
                    <td height="6" colspan="3"></td>
                </tr>

                <tr>
                    <td>
                        <input type=radio class="radio" name=order_search_type value='SearchByStatusID'
                                {if $order_search_type == 'SearchByStatusID'}
                                    checked
                                {/if}
                               onclick='order_search_typeClickHandler()'/>
                    </td>
                    <td colspan="2">
                        {$smarty.const.ADMIN_SHOW_ORDER_IN_STATUS}:
                    </td>
                <tr>
                    <td></td>
                    <td colspan="2">
                        <script type="text/javascript">
                            <!--
                            function checkBoxes(_idForm, _syncID) {literal}{{/literal}
                                if (document.getElementById(_syncID).checked == false) {literal}{{/literal}
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
                                    {
                                        literal
                                    }
                                }
                                {/literal}
                                return true;
                                {literal}
                            }
                            {/literal}
                            //-->
                        </script>
                        {if $order_statuses}
                            <table cellspacing="0" cellpadding="0">
                                <tr>
                                    <td valign="middle">
                                        <input id="id_checkall" name="id_checkall" onclick="checkBoxes('MainForm', 'id_checkall');" type="checkbox">
                                    </td>
                                    <td valign="middle">&nbsp;{$smarty.const.ADMIN_SHOW_ALLL}</td>
                                </tr>
                                {section name=i loop=$order_statuses}
                                    <tr>
                                        <td valign="middle">
                                            <input type=checkbox id=checkbox_order_status_{$order_statuses[i].statusID}
                                                   name=checkbox_order_status_{$order_statuses[i].statusID}
                                                    {if $order_statuses[i].selected == 1} checked {/if}value='1'>
                                        </td>
                                        <td valign="middle">&nbsp;{$order_statuses[i].status_name}</td>
                                    </tr>
                                {/section}
                            </table>
                        {/if}
                        <br><a href="#" onclick="document.getElementById('MainForm').submit(); return false">{$smarty.const.OK_BUTTON3}</a>
                        <input type=hidden value=1 name="search">
                    </td>
                </tr>
            </table>


            <input type="hidden" name="order_history" value="yes"/>
        </form>




        {if $user_orders}



            {if $orders_navigator}
                <table cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td>{$orders_navigator}</td>
                    </tr>
                </table>
            {/if}

            <table cellspacing="0" cellpadding="0" width="100%">
                <thead>


                <tr>
                    <td nowrap="nowrap">
                        <a href='{$urlToSort}&amp;sort=orderID&amp;direction=ASC'>{$smarty.const.STRING_MODULE_NUMERATIK} #</a>
                    </td>
                    <td class="lt pad" align="left" valign="middle">
                        <a href='{$urlToSort}&amp;sort=order_time&amp;direction=ASC'>{$smarty.const.TABLE_ORDER_TIME}</a>
                    </td>
                    <td>{$smarty.const.ADMIN_ORDER_STATUS_NAME}</td>
                    <td>{$smarty.const.TABLE_ORDERED_PRODUCTS}</td>
                    <td nowrap="nowrap">
                        <a href='{$urlToSort}&amp;sort=order_amount&amp;direction=ASC'>{$smarty.const.TABLE_ORDER_TOTAL}, {$currency_name}</a>
                    </td>
                </tr>
                </thead>

                <tbody>
                {section name=i loop=$user_orders}
                    <tr>
                        <td class="pad" align="left" valign="middle">
                            <a href='index.php?order_detailed={$user_orders[i].orderID}&amp;urlToReturn={$urlToReturn}'>{$smarty.const.STRING_ORDER_NAME1} #{$user_orders[i].orderID}</a>
                        </td>
                        <td class="pad" align="left" valign="middle">{$user_orders[i].order_time}</td>
                        <td class="pad" align="left" valign="middle">{$user_orders[i].OrderStatus}</td>
                        <td class="pad" align="left" valign="middle">
                            <table>
                                {section name=j loop=$user_orders[i].content}
                                    <tr>
                                        <td>{$user_orders[i].content[j].name}
                                            {if $user_orders[i].content[j].eproduct_filename}
                                                {if $completed_order_status}
                                                    {if $completed_order_status == $user_orders[i].statusID}
                                                        <br>
                                                        <a href='index.php?do=get_file&amp;getFileParam={$user_orders[i].content[j].getFileParam}'>{$smarty.const.ADMIN_DOWN_LOAD} ({$user_orders[i].content[j].file_size}
                                                        MB)</a>{if $user_orders[i].content[j].day_count_remainder > 0} - {$smarty.const.ADMIN_EPRODUCT_AVAILABLE_DAYS} {$user_orders[i].content[j].day_count_remainder} {$smarty.const.ADMIN_DAYS}{if $user_orders[i].content[j].load_counter_remainder != 0}, {$smarty.const.ADMIN_REMANDER_EPRODUCT_DOWNLOAD_TIMES} {$user_orders[i].content[j].load_counter_remainder} {$smarty.const.ADMIN_DOWNLOAD_TIMES}{/if}{/if}{/if}{/if}{/if}
                                        </td>
                                    </tr>
                                {/section}
                            </table>
                        </td>
                        <td>{$user_orders[i].order_amount}
                            {if $user_orders[i].calculate_tax ne 0 && $user_orders[i].tax ne 0}
                                <br>
                                ({$smarty.const.STRING_TAX} {$user_orders[i].tax}){/if}
                        </td>
                    </tr>
                {/section}
                </tbody>


            </table>
        {else}
            {include file='mod/message.tpl' txt=$smarty.const.STRING_NO_ORDERS}
        {/if}

    </article>
    <script type="text/javascript">
        function order_search_typeClickHandler() {literal}{{/literal}
            if (document.MainForm.order_search_type[0].checked) {literal}{{/literal}
                {section name=i loop=$order_statuses}
                document.MainForm.checkbox_order_status_{$order_statuses[i].statusID}.disabled = true;
                {/section}
                document.MainForm.id_checkall.disabled = true;
                document.MainForm.orderID_textbox.disabled = false;
                {literal}
            }{/literal}
            else if (document.MainForm.order_search_type[1].checked) {literal}{{/literal}
                {section name=i loop=$order_statuses}
                document.MainForm.checkbox_order_status_{$order_statuses[i].statusID}.disabled = false;
                {/section}
                document.MainForm.orderID_textbox.disabled = true;
                document.MainForm.id_checkall.disabled = false;
                {literal}
            }
            {/literal}
            {literal}
        }
        {/literal}
        order_search_typeClickHandler();
    </script>
    {else}
    <article>

        <header>
            {include  file='mod/link.tpl' link=$url.cabinet_orders}
            {include file='mod/header.tpl' header="`$smarty.const.STRING_ORDERING_INFO` #`$order.orderID`"}
        </header>


        <form name='MainForm' method="post" action="">


            <table cellspacing="0" cellpadding="0" width="100%">


                <tr>
                    <td>{$smarty.const.TABLE_ORDER_TIME}: <b>{$order.order_time}</b></td>
                </tr>

                <tr>
                    <td>{$smarty.const.CUSTOMER_FIRST_NAME}: <b>{$order.customer_firstname}</b></td>
                </tr>

                <tr>
                    <td>{$smarty.const.CUSTOMER_LAST_NAME}: <b>{$order.customer_lastname}</b></td>
                </tr>


                {section name=i loop=$order.reg_fields_values}
                    <tr>
                        <td> {$order.reg_fields_values[i].reg_field_name}:
                            <b>{$order.reg_fields_values[i].reg_field_value}</b></td>
                    </tr>
                {/section}

                <td>{$smarty.const.CUSTOMER_ADRESL}:
                    <b>{if $order.shipping_address ne ""}{$order.shipping_address}{/if}{if $order.shipping_city ne ""}, {$order.shipping_city}{/if}{if $order.shipping_state ne ""}, {$order.shipping_state}{/if}{if $order.shipping_country ne ""}, {$order.shipping_country}{/if}</b>
                </td>

                </tr>



                {if $order.shipping_type}
                    <tr>
                        <td>{$smarty.const.STRING_SHIPPING_TYPE_MAKE}:
                            <b>{$order.shipping_type} {if $order.shippingServiceInfo} ({$order.shippingServiceInfo}){/if}</b>
                        </td>
                    </tr>
                {/if}
                {if $order.payment_type}
                    <tr>
                        <td>{$smarty.const.STRING_PAYMENT_TYPE_MAKE}: <b>{$order.payment_type}</b></td>
                    </tr>
                {/if}


            </table>


            <section>

                <header>
                    <h2>{$smarty.const.ADMIN_ORDERED_PRODUCTS}</h2>
                </header>


                <table cellspacing="0" cellpadding="0" width="100%">
                    <thead>


                    <tr>
                        <th width="80%">{$smarty.const.ADMIN_PRODUCT_NAME}</th>
                        <th>{$smarty.const.TABLE_PRODUCT_QUANTITY}</th>
                        <th>{$smarty.const.TABLE_PRODUCT_COST_WITHOUT_TAX}</th>
                    </tr>

                    </thead>

                    <tfoot>
                    <tr>
                        <td colspan="2">{$smarty.const.STRING_PRED_TOTAL}:</td>
                        <td nowrap="nowrap">{$order.clear_total_priceToShow}</td>
                    </tr>
                    {if $order.order_discount > 0}
                        <tr>
                            <td colspan="2">{$smarty.const.ADMIN_DISCOUNT} {$order.order_discount}%:</td>
                            <td nowrap="nowrap">{$order.order_discount_ToShow}</td>
                        </tr>
                    {/if}
                    <tr>
                        <td colspan="2">{$smarty.const.ADMIN_SHIPPING_COST}:</td>
                        <td nowrap="nowrap">{$order.shipping_costToShow}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{$smarty.const.TABLE_TOTAL}:</td>
                        <td nowrap="nowrap">{$order.order_amountToShow}</td>
                    </tr>
                    </tfoot>
                    <tbody>


                    {section name=i loop=$orderContent}
                        <tr>
                            <td>{$orderContent[i].name}
                                {if $orderContent[i].eproduct_filename}
                                    {if $completed_order_status}
                                        {if $completed_order_status == $order.statusID}
                                            <a href='index.php?do=get_file&amp;getFileParam={$orderContent[i].getFileParam}'>{$smarty.const.ADMIN_DOWN_LOAD} ({$orderContent[i].file_size}
                                            MB)</a>{if $orderContent[i].day_count_remainder > 0} - {$smarty.const.ADMIN_EPRODUCT_AVAILABLE_DAYS} {$orderContent[i].day_count_remainder} {$smarty.const.ADMIN_DAYS}{if $orderContent[i].load_counter_remainder != 0}, {$smarty.const.ADMIN_REMANDER_EPRODUCT_DOWNLOAD_TIMES} {$orderContent[i].load_counter_remainder} {$smarty.const.ADMIN_DOWNLOAD_TIMES}{/if}{/if}{/if}{/if}{/if}
                            </td>
                            <td>{$orderContent[i].Quantity}</td>
                            <td nowrap="nowrap">{$orderContent[i].PriceToShow}</td>
                        </tr>
                    {/section}

                    </tbody>

                </table>
            </section>


            {if $order_status_report}

            <section>

                <header>
                    <h2>{$smarty.const.ADMIN_ORDER_EXECUTING}</h2>
                </header>


                <table cellspacing="0" cellpadding="0" width="100%">

                    <thead>
                    <tr>
                        <th width="80%">{$smarty.const.ADMIN_TIME}</th>
                        <th>{$smarty.const.ADMIN_ORDER_STATUS_NAME}</th>
                    </tr>
                    </thead>
                    {section name=i loop=$order_status_report}
                        <tr>
                            <td>{$order_status_report[i].status_change_time}</td>
                            <td>
                                {if $order_status_report[i].status_name != 'STRING_CANCELED_ORDER_STATUS'}
                                    {$order_status_report[i].status_name}
                                {else}
                                    {$smarty.const.STRING_CANCELED_ORDER_STATUS}
                                {/if}
                            </td>
                        </tr>
                    {/section}
                </table>
                {/if}

                <input type=hidden name='orders_detailed' value='yes'/>
            </section>

        </form>
        {/if}

    </article>
{/strip}