{strip}

    {if $s_offers}




        {include file='mod/tit.tpl' txt='Специальное предложение'}

        <div class="w_carousel">

            <section class="offers carousel">
                {section name=i loop=$s_offers  max=$max|default:8}
                    {include file='mod/offer.tpl' offer=$s_offers[i]}
                {/section}
            </section>


        </div>
    {/if}
{/strip}