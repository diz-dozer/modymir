{strip}

    {if $smarty.const.CONF_CHECKSTOCK AND $offer.in_stock <= 0}

        {*<div class="in_stock is_available">нет в наличии</div>*}

    {else}

        {*<div class="in_stock is_available">В наличии</div>*}

        {if $offer && $smarty.const.CONF_SHOW_ADD2CART}

            {*
            && (!$smarty.const.CONF_CHECKSTOCK || $offer.in_stock > 0) &&
            {assign var=id value=$offer.productID}
            {assign var=catID value=$offer.categoryID}
            *}

            {*

                        {if !$smarty.const.CONF_MULTYCART || $small || $offer.ss.cart}
                            {assign var=set value='type="hidden"'}
                        {else}
                            {assign var=set value='type="text" size="2" maxlength="2"'}
                        {/if}
            *}


            {assign var=set value='type="hidden"'}

            <div class="to-cart">


                <input type="hidden" name="qty" value="1"/>
                <input type="hidden" name="offerID" value="{$offer.productID}"/>

                <button name="add2cart" class="btn" title="{$name}" type="submit" >{$smarty.const.ADD_TO_CART_STRING}</button>

            </div>

        {/if}

    {/if}


    {*
    CONF_CART_METHOD
    0 - Standart
    1 - New window
    2 - Ajax
    *}

    {*
    <form method="post" action="/index.php?categoryID={$offer.categoryID}&amp;prdID={$offer.productID}">

    {if $smarty.const.CONF_CART_METHOD eq 0}
    {assign var=onclick value="open_window('index.php?do=cart&amp;addoffer=`$offer.productID`&amp;multyaddcount=' + document.HiddenFieldsForm_`$offer.productID`.multyaddcount.value + '', 550, 300); return false"}
    {/if}

    {if $smarty.const.CONF_CART_METHOD eq 1}
    {assign var=onclick value="doLoad('do=cart&amp;addoffer=`$offer.productID`&amp;xcart=yes&amp;multyaddcount=' + document.HiddenFieldsForm_`$offer.productID`.multyaddcount.value + ''); return false"}
    {/if}

    {if $smarty.const.CONF_CART_METHOD eq 2}
    {assign var=onclick value="document.getElementById('HiddenFieldsForm_`$offer.productID`').submit(); return false"}
    {/if}

    *}

    {*
          {if $offer.ss.cart}
          <a class="to_cart lnk is_active" {if $onclick}onclick="{$onclick}"{/if} href="{$href|default:'#'}" title="{$name}" rel="nofollow">
          <i class="ico_cart">&nbsp;</i><span>товар в корзине</span>
          </a>
          {else}
          <a class="to_cart lnk" {if $onclick}onclick="{$onclick}"{/if} href="{$href|default:'#'}" title="{$name}" rel="nofollow">
          <i class="ico_cart">&nbsp;</i><span>{$smarty.const.ADD_TO_CART_STRING}</span>
          </a>
          {/if}

          *}

    {*    {if $pageID eq 'offer_detailed'}
            {assign var=txt value='Добавить в корзину'}
        {else}
            {assign var=txt value=}
        {/if}*}




    {*     {if $onclick}onclick="{$onclick}"{/if} href="{$href|default:'#'}"*}
{/strip}