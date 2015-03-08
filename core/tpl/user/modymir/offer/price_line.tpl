{strip}

    {if $offer}
        <form class="offer-form" action="#" method="post" {$offer.data}>

            {include file='offer/variants.tpl' offer=$offer}

            {include file='offer/price.tpl' offer=$offer wide=1}
            <ul class="bar">
                <li>{include file='offer/to_cart.tpl' offer=$offer}</li>
                {*<li>{include file='offer/one_click.tpl' offer=$offer}</li>*}
            </ul>

        </form>
    {/if}

{/strip}