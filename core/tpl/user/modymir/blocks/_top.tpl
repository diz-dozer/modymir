{strip}

    {if $v_offers}

        {include file='mod/tit.tpl' txt='Выгодная цена'}

        <div class="w_carousel">
            <section class="offers carousel">
                {section name=i loop=$v_offers  max=$max|default:8}
                    {include file='mod/offer.tpl' offer=$v_offers[i]}
                {/section}
            </section>
        </div>


    {/if}

{/strip}