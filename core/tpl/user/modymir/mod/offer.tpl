{strip}
    {if $offer}
        {if $smarty.const.CONF_MOD_REWRITE}
            {assign var=url value="/product_`$offer.productID`.html"}
        {else}
            {assign var=url value="/index.php?productID=`$offer.productID`"}
        {/if}



        {*{assign var=mw value=200}*}
        {*{assign var=mh value=300}*}
        {*{assign var=mw value=160}*}
        {*{assign var=mh value=200}*}

        <div class="offer{$itm_class}">
            <dl>


                <dt class="picture">
                    <a href="{$url}">

                        {slir w=200 h=300 offer=$offer}

                    </a>


                </dt>

                <dd class="name">
                    <a class="url" href="{$url}" title="узнать больше">{$offer.name}</a>
                </dd>
                <dd>
                    <div class="price">{$offer.PriceWithUnit}</div>
                    {if $offer.profit}
                        <del class="old-price">{$offer.list_priceWithUnit}</del>
                    {/if}
                </dd>
            </dl>


            <div class="qlook">
                <a data-tools="modal" data-content="/index.php?do=look&amp;id={$offer.productID}">Быстрый просмотр</a>
            </div>

        </div>
    {/if}
{/strip}