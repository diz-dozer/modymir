{if $compare_value}

<div id="compare-page" class="cf">
    <div class="compare-legend">

        <h1 class="compare-title">{$smarty.const.STRING_PRODUCT_COMPARISON}</h1>

        <div class="compare-count">Количество товаров: <b id="qty_compare_item">{$compare_value|default:'0'}</b></div>
        <a href="/index.php?do=compare&amp;compare_clear=all" rel="nofollow">очистить</a>
    </div>
    <div class="scroll-panel">

    <table id="compare-table" cellspacing="0" cellpadding="0" class="compare-table">
    <thead>
    <tr>
        <th class="compare-label">
            {*  <span class="compare-label-wrap">
                Фото
            </span>
            *}
        </th>
        {section name=i loop=$products}
            <td class="compare-item compareID-{$smarty.section.i.iteration}">
                <div class="compare-item-wrap">
                    {if $products[i].picture}
                        <img class="compare-item-image" src="data/small/{$products[i].picture}" alt="{$products[i].name}"/>
                    {else}
                        <img class="compare-item-image" src="data/empty.gif" alt="no photo"/>
                    {/if}
                </div>
            </td>
        {/section}
    </tr>
    <tr>
        <th class="compare-label">
            {*
<div class="compare-label-wrap">
    {$smarty.const.TABLE_PRODUCT_NAME}
</div>
*}
        </th>
        {section name=i loop=$products}

            {if $smarty.const.CONF_MOD_REWRITE}
                {assign var=product_link value="product_`$products[i].productID`.html"}
            {else}
                {assign var=product_link value="index.php?productID=`$products[i].productID`"}
            {/if}
            <td class="compare-item compareID-{$smarty.section.i.iteration}">
                <div class="compare-item-wrap">
                    <a class="compare-item-name-link" href="{$product_link}">{$products[i].name}</a>
                </div>


            </td>
        {/section}
    </tr>
    <tr>
        <th class="compare-label">
            {*  <span class="compare-label-wrap">
                {$smarty.const.STRING_PRODUCT_PRICE}
            </span>
            *}
        </th>
        {section name=i loop=$products}
            <td class="compare-item compareID-{$smarty.section.i.iteration}">
                <div class="compare-item-wrap">


                    {if $currencies_count ne 0}
                        <div class="price">
                            {if $products[i].Price <= 0}
                                <div class="no-price">{$smarty.const.STRING_NOPRODUCT_IN}</div>
                            {else}
                                <span class="value">{$products[i].Price}</span>
                                <span class="currency">{$currency_name}</span>
                            {/if}
                        </div>
                    {/if}

                </div>
            </td>
        {/section}
    </tr>
    <tr>
    <th class="compare-label">
                    <span class="compare-label-wrap compare-head-bottom">
                        &nbsp;
                    </span>
    </th>
    {section name=i loop=$products}

        {if $smarty.const.CONF_MOD_REWRITE}
            {assign var=product_link value="product_`$products[i].productID`.html"}
        {else}
            {assign var=product_link value="index.php?productID=`$products[i].productID`"}
        {/if}

    <td class="compare-item compareID-{$smarty.section.i.iteration} compare-head-bottom">
        <div class="compare-item-wrap">
        {if $products[i].productID|in_array:$shopping_cart_itemsID}
            {assign var=offer_link_class value="link offer-link-cart tooltip offer-link-in-cart"}
            {assign var=offer_link_title value="добавить в корзину"}
        {else}
            {assign var=offer_link_class value="link offer-link-cart tooltip"}
            {assign var=offer_link_title value="добавить в корзину"}
        {/if}
        {assign var=compare_link value="/index.php?do=compare&amp;compareID=`$products[i].productID`"}

        {if $products[i].productID|in_array:$compare_itemsID}
            {assign var=offer_compare_class value="link tooltip offer-link-compare-remove offer-link-compare-active"}
            {assign var=offer_compare_link value="`$compare_link`&amp;remove=yes"}
            {assign var=offer_compare_title value="исключить из сравнения"}
        {else}
            {assign var=offer_compare_class value="link tooltip offer-link-compare-remove"}
            {assign var=offer_compare_link value="`$compare_link`&amp;add=yes""}
                        {assign var=offer_compare_title value="добавить к сравнению"}
                        {/if}

                        <ul class="offer-action cf">
                            <li class="item"><a class="link offer-link-info tooltip" href="{$product_link}" title="подробное описание">информация</a></li>
                            <li class="item"><a class="link offer-link-tech tooltip" href="{$product_link}" title="технические характеристики">характеристики</a></li>
                            <li class="item"><a class="{$offer_compare_class}" href="{$offer_compare_link}" title="{$offer_compare_title}" rel="{$smarty.section.i.iteration}">сравнение</a></li>
                            {if $products[i].Price > 0}
                            <li class="item"><a class="{$offer_link_class}" href="/index.php?add2cart={$products[i].productID}&amp;multyaddcount=1&amp;shopping_cart=yes" title="{$offer_link_title}" rel="nofollow">добавить в корзину</a></li>
                            {/if}
                        </ul>
                    </div>
                </td>
                {/section}
            </tr>
            </thead>
            <tbody>

                {section name=p loop=$definedOptions}
                <tr>
                    <th class="compare-label">
                        <span class="compare-label-wrap">
                            {$definedOptions[p].name}
                        </span>
                    </th>

                    {section name=v loop=$products}
                    <td class="compare-item compareID-{$smarty.section.v.iteration}">
                        <div class="compare-item-wrap">
                            {$products[v][p]}
                        </div>
                    </td>
                    {/section}
                </tr>
                {/section}

                <tr>
                    <th class="compare-label">
                        <span class="compare-label-wrap">
                            {$smarty.const.STRING_PRODUCT_BRIEF_DESC}
                        </span>
                    </th>
                    {section name=i loop=$products}
                    <td class="compare-item compareID-{$smarty.section.i.iteration}">
                        <div class="compare-item-wrap">
                            {if $products[i].brief_description}
                            {$products[i].brief_description|strip_tags}
                            {/if}
                        </div>
                    </td>
                    {/section}
                </tr>


            </tbody>
        </table>
    </div>
</div>
{else}
<p class="error">Список сравнения пуст</p>
{/if}
