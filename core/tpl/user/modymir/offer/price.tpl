{strip}

    {*
    $profit = ($retail - $cost);
    $percent = ($profit / $retail);
    $totalpercent = ($percent * 100);
    *}

    {if $offer.Price > 0}


        {if $wide neq 1 and $offer.profit}
            <div class="profit">
                <b class="rib">-<span class="val">{$offer.profit}</span></b>
            </div>
        {/if}
        <div class="price-line{if $wide eq 1} _wide{/if}">


            <div class="price{if $offer.profit} _red{/if}">
                {if $wide eq 1}
                    <div class="hint">
                        Цена:
                    </div>
                {/if}
                <span class="val">{$offer.PriceWithUnit}</span>
            </div>


            {if $offer.profit}
                <del class="old-price">
                    {if $wide eq 1}
                        <div class="hint">
                            Старая цена:
                        </div>
                    {/if}
                    <span class="val">{$offer.list_priceWithUnit}</span>
                </del>
                {if $wide eq 1}
                    <div class="profit"><span class="lbl">Скидка</span> <span class="val">{$offer.profit}</span></div>
                {/if}

            {/if}

        </div>
    {/if}

{/strip}