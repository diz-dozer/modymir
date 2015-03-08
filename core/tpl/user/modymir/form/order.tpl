{strip}

{if $products_to_show}

<form id="orderForm" method="post" action="/">


    <div class="w_order_form">

        <h2 class="tit">Форма заказа</h2>

        <div id="orderFormSuccess">
        </div>
        <ol>
            <li>Выбирите нужные позиции товаров</li>
            <li>Укажите количество товара</li>
            <li>Добавьте товар в корзину заказа</li>
        </ol>


        <h3 class="tit">{$selected_category.name}</h3>
        <table width="100%" cellspacing="0" cellpadding="0" summary="product order form">
            {*
            <thead>
                <tr>
                    <td>&nbsp;</td>
                    <td>наименование</td>
                    <td>количество</td>
                    <td>цена</td>
                </tr>

            </thead>
            *}
            <tfoot>
                <tr>
                    <td colspan="4">
                        <br/>
                        <button class="submit"  name="x_order" value="ajax">В корзину</button>
                    </td>
                </tr>
            </tfoot>
            <tbody>

                {section name=u loop=$products_to_show}

                {assign var=id value=`$products_to_show[u].productID`}

                <tr>

                    <td>
                        <input class="check_enabled" id="pid_{$id}" type="checkbox" name="x_id[]" size="1" value="{$id}"  />

                    </td>
                    <td>
                        <label for="pid_{$id}">{$products_to_show[u].name}</label>
                    </td>
                    <td>
                        <input class="qty" id="pid_{$id}_i" type="text" name="x_qty[{$id}]" size="1" value=""  disabled="disabled" />
                        шт
                    </td>
                    <td>
                        <b>
                            {$products_to_show[u].PriceWithUnit}
                        </b>
                    </td>


                </tr>

                {/section}
            </tbody>
        </table>
    </div>

</form>
{/if}

{/strip}
