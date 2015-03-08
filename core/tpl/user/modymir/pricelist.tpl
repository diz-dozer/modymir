{strip}


    {include file='mod/header.tpl' header=$smarty.const.STRING_PRICELIST}


    <a class="price-download-link" href="index.php?download_price=yes" title="{$smarty.const.STRING_DOWNLOAD_PRICE}"><img src="{$tpl_path}/img/icon/icon_dwnld_xls.png" alt="" width="160" height="70"/></a>
    {*
    {if $pricelist_elements}

    <div class="paginator-line cf"><div class="sort">{$price_sort}</div></div>
    {/if}
    *}

    {if $pricelist_elements}
        <table class="table price-list" cellspacing="0" cellpadding="0" width="100%">


            <thead class="table-thead">
            <tr>
                <th>{$smarty.const.STRING_PRICE_PRODUCT_NAME}</th>
                {if $smarty.const.CONF_DISPLAY_PRCODE eq 1}
                    <th>{$smarty.const.STRING_PRODUCT_CODE}</th>
                {/if}
                <th>{$smarty.const.CURRENT_PRICE}</th>
                <th>&nbsp;</th>
            </tr>
            </thead>

            <tbody class="table-tbody">
            {section name=i loop=$pricelist_elements}




                {assign var="lvl" value=1}
                {section name=j loop=$pricelist_elements max=($pricelist_elements[i][2]-2)}
                    {assign var="lvl" value="`$lvl+1`"}
                {/section}


                {if $pricelist_elements[i][4] ne 1}


                    {if $smarty.const.CONF_MOD_REWRITE}
                        {assign var=price_link value="category_`$pricelist_elements[i][0]`.html"}
                    {else}
                        {assign var=price_link value="index.php?categoryID=`$pricelist_elements[i][0]`"}
                    {/if}
                    <tr>
                        <th class="lvl_{$lvl}" colspan="4">
                            <a class="price-list-category-link tooltip" href="{$price_link}" title="перейти в категорию">{$pricelist_elements[i][1]}</a>
                        </th>
                    </tr>
                {elseif $pricelist_elements[i][4] eq 1}

                    {if $smarty.const.CONF_MOD_REWRITE}
                        {assign var=price_link value="product_`$pricelist_elements[i][0]`.html"}
                    {else}
                        {assign var=price_link value="index.php?productID=`$pricelist_elements[i][0]`"}
                    {/if}
                    <tr>

                        <td class="table-name lvl_{$lvl}">
                            <a class="price-list-product-link tooltip" href="{$price_link}" title="подробное описание">{$pricelist_elements[i][1]}</a>
                        </td>


                        {if  $smarty.const.CONF_DISPLAY_PRCODE eq 1}
                            <td>
                                {if $pricelist_elements[i][7]}
                                    <span class="price-list-code tooltip" title="код товара">#{$pricelist_elements[i][7]}</span>
                                {/if}
                            </td>
                        {/if}



                        {if $pricelist_elements[i][5] > 0}
                            <td class="price">{$pricelist_elements[i][5]}</td>
                        {else}
                            <td class="no-price">&nbsp;&nbsp;&nbsp;&nbsp;&ndash;
                                {*$smarty.const.STRING_NOPRODUCT_IN*}
                            </td>
                        {/if}

                        <td class="priclist-cart">
                            {if $pricelist_elements[i][5] > 0}
                                <a class="button offer-link-cart" href="/index.php?add2cart={$pricelist_elements[i][0]}&amp;multyaddcount=1&amp;shopping_cart=yes">в корзину</a>
                            {/if}
                        </td>


                    </tr>
                {/if}

            {/section}
            </tbody>
        </table>
    {else}
        <div class="error">{$smarty.const.STRING_EMPTY_LIST}</div>
    {/if}

{/strip}
