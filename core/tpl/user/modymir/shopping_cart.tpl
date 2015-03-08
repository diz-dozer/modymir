{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.CART_TITLE}
        </header>


        {if $product_removed}

            {include file='mod/message.tpl' type='info' txt=$smarty.const.STRING_PRODUCT_REMOVED}


        {else}

            {if !$cart_content}

                {include file='mod/message.tpl'  txt=$smarty.const.CART_EMPTY}
            {else}
                <form id="cartForm" method="post" action="{$cart_reguest}">


                    <table class="cart">

                        <col width="100"/>
                        <col width="40%"/>



                        <thead>
                        <tr>
                            <td>фото</td>
                            <td>описание</td>
                            <td>кол-во</td>
                            <td>цена</td>
                            <td>сумма</td>
                            <td>&nbsp;</td>
                        </tr>
                        </thead>


                        <tfoot>

                        {if $make_more_exact_cart_content}
                            <tr class="error">
                                <td colspan="6">
                                    {$smarty.const.STRING_MAKE_MORE_EXACT_CART_CONTENT}
                                </td>
                            </tr>
                        {/if}



                        {if $cart_amount < $smarty.const.CONF_MINIMAL_ORDER_AMOUNT}
                            <tr class="error">
                                <td colspan="6">
                                    {$smarty.const.CART_TOO_SMALL_ORDER_AMOUNT}&nbsp;&nbsp;&nbsp;<span class="price">{$cart_min}</span>
                                </td>
                            </tr>
                        {/if}

                        {if $discount_prompt != 0}

                            {if $discount_prompt == 1 && $discount_percent != 0}
                                <tr class="info">
                                    <td colspan="4">
                                        {$smarty.const.ADMIN_DISCOUNT} {$discount_percent}%
                                    </td>
                                    <td><span class="price">{$discount_value}</span></td>
                                    <td>&nbsp;</td>
                                </tr>
                            {/if}


                            {*{if $discount_prompt == 2}
                                <tr>
                                    <td colspan="6" class="info _tc">
                                        {$smarty.const.STRING_UNREGISTERED_CUSTOMER_DISCOUNT_PROMPT}
                                    </td>
                                </tr>
                            {/if}*}

                            {if $discount_prompt == 3 && $discount_percent != 0}
                                <tr class="info">
                                    <td colspan="4">
                                        {$smarty.const.ADMIN_DISCOUNT} {$discount_percent}%
                                        <br/>{$smarty.const.STRING_UNREGISTERED_CUSTOMER_COMBINED_DISCOUNT_PROMPT}
                                    </td>
                                    <td><span class="price">{$discount_value}</span></td>
                                    <td>&nbsp;</td>
                                </tr>
                            {/if}

                        {/if}


                        {*{$smarty.const.TABLE_TOTAL}*}

                        <tr class="total">
                            <td colspan="4">Общая сумма</td>
                            <td><b class="price">{$cart_total}</b></td>
                            <td>
                                <input type="hidden" name="update" value="1"/>
                                <input type="hidden" name="shopping_cart" value="1"/>
                            </td>
                        </tr>
                        </tfoot>

                        <tbody>

                        {assign var=w value=60}

                        {section name=i loop=$cart_content}

                            {if $smarty.const.CONF_MOD_REWRITE}
                                {assign var=url value="product_`$cart_content[i].productID`.html"}
                            {else}
                                {assign var=url value="index.php?productID=`$cart_content[i].productID`"}
                            {/if}


                            {if $session_items}
                                {assign var=ids value=$session_items[i]}
                            {else}
                                {assign var=ids value=$cart_content[i].id}
                            {/if}


                            {if $cart_content[i].picture}
                                {assign var=x_img value="/img/w`$w`/data/small/`$cart_content[i].picture`"}
                                {assign var=b_img value="/img/w1000/data/small/`$cart_content[i].picture`"}
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
                                    <a class="product_name" href="{$url}">{$cart_content[i].name}</a>
                                    {if $smarty.const.CONF_DISPLAY_PRCODE  && $cart_content[i].product_code}
                                        <div class="product_code">Код товара: {$cart_content[i].product_code}</div>
                                    {/if}
                                </td>


                                <td>

                                    <input class="amount" type="text" name="count_{$ids}" size="3" value="{$cart_content[i].quantity}"/>

                                    {if $cart_content[i].min_order_amount}
                                        <div class="error">
                                            {$smarty.const.STRING_MIN_ORDER_AMOUNT} {$cart_content[i].min_order_amount} {$smarty.const.STRING_ITEM}
                                        </div>
                                    {/if}

                                </td>

                                <td><span class="price _grey">{$cart_content[i].price}</span></td>

                                <td><span class="price">{$cart_content[i].cost}</span></td>
                                <td class="remove_action">
                                    <a class="remove_link" href="{$cart_reguest}&remove={$ids}" title="удалить товар">&times;</a>
                                </td>
                            </tr>
                        {/section}

                        </tbody>
                    </table>






                    {if $log}
                        {assign var=cart_url value="index.php?order2_shipping&shippingAddressID=`$shippingAddressID`"}
                    {else}
                        {assign var=cart_url value="index.php?register_authorization"}
                    {/if}


                    <div class="buttons">


                        <div class="col _2_4">


                            {if $cart_amount < $smarty.const.CONF_MINIMAL_ORDER_AMOUNT}
                                <a class="button disabled" href="#">{$smarty.const.CART_PROCEED_TO_CHECKOUT}</a>
                            {else}
                                <a class="button" href="{$cart_url}">{$smarty.const.CART_PROCEED_TO_CHECKOUT}</a>
                            {/if}


                            {if $refer}
                                <a class="button _dark" href="{$refer}">Вернуться к покупкам</a>
                            {/if}

                        </div>

                        <div class="col _2_4 _tr">
                            <button type="submit">{$smarty.const.UPDATE_BUTTON}</button>
                            <a class="button" href="{$cart_reguest}&amp;clear_cart">{$smarty.const.CART_CLEAR}</a>
                        </div>

                    </div>

                </form>
            {/if}

        {/if}
    </article>
{/strip}
