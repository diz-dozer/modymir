{strip}

    {if $offer}




        {include file="offer/price.tpl" offer=$offer}
        {include file="offer/to_cart.tpl" offer=$offer}
        {include file="offer/one_click.tpl" offer=$offer}
        {include file="offer/description" offer=$offer}



    {/if}
{/strip}