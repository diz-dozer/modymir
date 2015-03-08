{strip}
    {if $offers}


        {if $tit}
            {include file='mod/tit.tpl' txt=$tit}
        {/if}


        <section class="offers">
            {section name=i loop=$offers  max=$max|default:4}
                {include file='mod/offer.tpl' offer=$offers[i]}
            {/section}
        </section>


    {/if}

{/strip}