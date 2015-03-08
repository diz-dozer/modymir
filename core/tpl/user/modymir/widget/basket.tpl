{strip}

    {if $smarty.const.CONF_SHOW_ADD2CART}

        {if $smarty.const.CONF_MOD_REWRITE}
            {assign var=cart_url value="/cart.html"}
        {else}
            {assign var=cart_url value="/index.php?shopping_cart=yes"}
        {/if}
        <div class="w_basket">

            {*{include file='widget/schedule.tpl'}*}

            <dl class="basket{if $sc.qty == 0} empty{/if}">
                <dt>
                    {if $sc.qty > 0}
                    <a class="tit" href="/cart.html" rel="nofollow">Моя Корзина</a>
                    {else}
                    <span class="tit">Моя Корзина<span>
                    {/if}
                </dt>
                <dd class="hint">
                    <span class="sc_qty">{$sc.qty}</span>
                    <span class="sc_hint">{$sc.hint}</span>
                    <span class="sc_val">{$sc.shown}</span>
                </dd>
            </dl>

        </div>
    {/if}

    {*
    {if $sc.qty > 0}
    {else}
    <dt class="tit">Моя Корзина</dt>
    <dd class="hint _empty"><span class="sc_qty">пустая</span>
    <span class="sc_hint"></span>
    </dd>
    {/if}
    *}

{/strip}