{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_ORDER_CONFIRMATION}
        </header>


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


            {if $orderSum eq Null}

                {include file='mod/message.tpl'  txt=$smarty.const.ERROR_CANT_FIND_REQUIRED_PAGE}

            {else}

                {if $orderSum.orderContentCartProductsCount eq 0}
                    {include file='mod/message.tpl'  txt=$smarty.const.CART_EMPTY}
                {else}

                    {if $payment_error}
                        {include file='mod/message.tpl'  txt="`$smarty.const.ADMIN_PAYMENT_ERROR` `$payment_error`"}
                    {/if}
                    <table class="cart">

                        <col width="100"/>
                        <col width="40%"/>


                        <thead>


                        <tr class="tit">
                            <td>Фото</td>
                            <td>Описание</td>
                            <td>Кол-во</td>
                            <td>Цена</td>
                            <td>Сумма</td>
                        </tr>

                        </thead>

                        <tfoot>


                        {*<tr>*}
                        {*<td colspan="4">{$smarty.const.STRING_PRED_TOTAL}</td>*}
                        {*<td>{$orderSum.pred_total}</td>*}
                        {*</tr>*}


                        {if $orderSum.discount_percent > 0}
                            <tr class="info">
                                <td colspan="4">{$smarty.const.ADMIN_DISCOUNT} {$orderSum.discount_percent}%</td>
                                <td><span class="price">{$orderSum.discount_show}</span></td>
                            </tr>
                        {/if}

                        <tr>
                            <td colspan="4">{$smarty.const.STRING_SHIPPING_TYPE_PAY}</td>
                            <td><span class="price">{$orderSum.shipping_cost}</span></td>
                        </tr>


                        {*{$smarty.const.TABLE_TOTAL}*}
                        <tr class="total">
                            <td colspan="4">Общая сумма</td>
                            <td><span class="price">{$orderSum.total}</span></td>
                        </tr>
                        </tfoot>

                        <tbody>
                        {assign var=w value=60}
                        {section name=i loop=$orderSum.sumOrderContent}
                            {if $orderSum.sumOrderContent[i].picture}
                                {assign var=x_img value="/img/w`$w`/data/small/`$orderSum.sumOrderContent[i].picture`"}
                                {assign var=b_img value="/img/w1000/data/small/`$orderSum.sumOrderContent[i].picture`"}
                            {else}
                                {assign var=x_img value="/img/w`$w`/data/empty.jpg"}
                            {/if}
                            <tr>
                                <td>
                                    {if $b_img}
                                        <a class="picture" href="{$b_img}">
                                            <img src="{$x_img}" alt=""/>
                                        </a>
                                    {else}
                                        <div class="picture">
                                            <img src="{$x_img}" alt=""/>
                                        </div>
                                    {/if}
                                </td>
                                <td>


                                    <div class="product_name">
                                        {$orderSum.sumOrderContent[i].name}
                                    </div>

                                    {if $smarty.const.CONF_DISPLAY_PRCODE  && $orderSum.sumOrderContent[i].product_code}
                                        <div class="product_code">Код товара:  {$orderSum.sumOrderContent[i].product_code}</div>
                                    {/if}

                                </td>
                                <td>{$orderSum.sumOrderContent[i].quantity}</td>
                                <td><span class="price _grey">{$orderSum.sumOrderContent[i].price}</span></td>
                                <td><span class="price">{$orderSum.sumOrderContent[i].cost}</span></td>
                            </tr>
                        {/section}
                        </tbody>
                    </table>
                    <table class="order_info">
                        {if $orderSum.shipping_name ne '-'}
                            <tr>
                                <td>{$smarty.const.STRING_SHIPPING_TYPE_MAKE}:</td>
                                <td>{$orderSum.shipping_name}{if $orderSum.shippingServiceInfo} ({$orderSum.shippingServiceInfo}){/if}</td>
                            </tr>
                        {/if}

                        {if $orderSum.payment_name ne '-'}
                            <tr>
                                <td>{$smarty.const.STRING_PAYMENT_TYPE_MAKE}:</td>
                                <td>{$orderSum.payment_name}</td>
                            </tr>
                        {/if}
                        <tr>
                            <td>{$smarty.const.STRING_TARGET_SHIPPING_ADDRESS}:</td>
                            <td>{$orderSum.shipping_address|replace:"<":"&lt;"|replace:"&lt;br>":", "}</td>
                        </tr>
                    </table>
                    <form class="col _1_2" method="post" action="#">
                        {if $orderSum.payment_form_html}
                            <div class="field">
                                {$orderSum.payment_form_html}
                            </div>
                        {/if}
                        <div class="field">
                            <textarea name="order_comment" cols="80" rows="3" placeholder="{$smarty.const.STRING_ORDER_COMMENT}"></textarea>
                        </div>
                        <div class="buttons">
                            <input type="hidden" name="totalUC" value="{$totalUC}"/>
                            <button type="submit" name="submitgo" value="1">{*$smarty.const.STRING_FORMALIZE_ORDER*}Подтведить заказ</button>
                        </div>

                    </form>
                {/if}
            {/if}
        {/if}

    </article>
{/strip}