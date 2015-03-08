{strip}



    {include file='mod/header.tpl' header=$smarty.const.STRING_ORDER_CONFIRMATION}


    {if $order_success}
        <div class="success">

            {if $smarty.const.CONF_ACTIVE_ORDER}

                {$smarty.const.STRING_ORDER_PLACED_ACTIVATE}
                <br/>
                {if $smarty.const.CONF_DISP_ORDERNUM}
                    {$smarty.const.STRING_ORDER_NUME}: {$orderidd}
                {/if}

            {else}
                {$smarty.const.STRING_ORDER_PLACED}
                <br/>
                {if $smarty.const.CONF_DISP_ORDERNUM}
                    {$smarty.const.STRING_ORDER_NUME}: {$orderidd}
                {/if}
            {/if}


            {if $after_processing_html}
                <p>
                    {$after_processing_html}
                </p>
            {/if}

        </div>
    {else}


        {if $orderSum eq NULL}
            <div class="error">{$smarty.const.ERROR_CANT_FIND_REQUIRED_PAGE}</div>
        {else}

            {if $orderSum.orderContentCartProductsCount eq 0}
                <div class="error">{$smarty.const.CART_EMPTY}</div>
            {else}

                {if $payment_error}
                    <div class="error">
                        {$smarty.const.ADMIN_PAYMENT_ERROR}
                        {if $payment_error ne 1}: {$payment_error}{/if}
                    </div>
                {/if}


                {assign var=w value=80}
                <table class="tbl">

                    <thead>


                    <tr>
                        <th>Фото</th>
                        <th>{$smarty.const.TABLE_PRODUCT_NAME}</th>
                        <th>{$smarty.const.TABLE_PRODUCT_QUANTITY}</th>
                        <th>{$smarty.const.TABLE_PRODUCT_COST_WITHOUT_TAX}</th>
                    </tr>

                    </thead>

                    <tfoot>
                    <tr>
                        <td colspan="3">{$smarty.const.STRING_PRED_TOTAL}</td>
                        <td>{$orderSum.pred_total}</td>
                    </tr>


                    {if $orderSum.discount_percent > 0}
                        <tr>
                            <td colspan="3">{$smarty.const.ADMIN_DISCOUNT} {$orderSum.discount_percent}%</td>
                            <td>{$orderSum.discount_show}</td>
                        </tr>
                    {/if}

                    <tr>
                        <td colspan="3">{$smarty.const.STRING_SHIPPING_TYPE_PAY}</td>
                        <td>{$orderSum.shipping_cost}</td>
                    </tr>
                    <tr>
                        <td colspan="3">{$smarty.const.TABLE_TOTAL}</td>
                        <td>{$orderSum.total}</td>
                    </tr>
                    </tfoot>


                    <tbody>


                    {section name=i loop=$orderSum.sumOrderContent}

                        {assign var=x_img value="/img/w`$w`/data/small/`$orderSum.sumOrderContent[i].picture`"}
                        <tr>
                            <td>
                                <div class="pic">
                                    <img class="img" src="{$x_img}" alt=""/>
                                </div>
                            </td>
                            <td>{$orderSum.sumOrderContent[i].name}</td>
                            <td>{$orderSum.sumOrderContent[i].quantity}</td>
                            <td>{$orderSum.sumOrderContent[i].cost}</td>
                        </tr>
                    {/section}

                    </tbody>

                </table>
                <table class="tbl">
                    <thead>
                    {if $orderSum.shipping_name ne '-'}
                        <tr>
                            <th>{$smarty.const.STRING_SHIPPING_TYPE_MAKE}:</th>
                            <td>{$orderSum.shipping_name}{if $orderSum.shippingServiceInfo} ({$orderSum.shippingServiceInfo}){/if}</td>
                        </tr>
                    {/if}

                    {if $orderSum.payment_name ne '-'}
                        <tr>
                            <th>{$smarty.const.STRING_PAYMENT_TYPE_MAKE}:</th>
                            <td>{$orderSum.payment_name}</td>
                        </tr>
                    {/if}

                    <tr>
                        <th>{$smarty.const.STRING_TARGET_SHIPPING_ADDRESS}:</th>
                        <td>{$orderSum.shipping_address|replace:"<":"&lt;"|replace:"&lt;br>":", "}</td>
                    </tr>

                    </thead>
                </table>
                <form class="form" method="post" action="#">

                    <div class="field">
                        {$orderSum.payment_form_html}
                    </div>


                    <div class="field">

                        <textarea name="order_comment" cols="40" rows="5" placeholder="{$smarty.const.STRING_ORDER_COMMENT}.."></textarea>
                        <input type="hidden" name="submitgo" value="1"/>
                        <input type="hidden" name="totalUC" value="{$totalUC}"/>

                    </div>

                    <div class="field">
                        <button type="submit">{$smarty.const.STRING_FORMALIZE_ORDER}</button>
                    </div>

                </form>
            {/if}
        {/if}
    {/if}


{/strip}