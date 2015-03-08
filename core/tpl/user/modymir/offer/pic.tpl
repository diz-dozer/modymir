{strip}

    {if $offer.picture}


        {assign var=w value=340}
        {assign var=h value=460}
        {assign var=bw value=1200}


        {*{assign var=hi value=325}*}

        {assign var=x_img value="/img/w`$w`-h`$h`-c`$w`x`$h``$offer.picture.src`"}
        {assign var=b_img value="/img/w`$bw``$offer.picture.src`"}

        {if $mod eq 'look'}
            <div class="pic zoom">
                <img class="img" src="{$x_img}" alt="{$offer.name}"/>
            </div>
        {else}
            <a class="fb pic zoom" href="{$b_img}" data-fancybox-group="g_{$offer.productID}">
                <img class="img" src="{$x_img}" alt="{$offer.name}"/>
            </a>
        {/if}
    {else}
        <div class="pic">
            <img class="img" src="{$x_img}data/acs/empty.jpg" alt="no photo"/>
        </div>
    {/if}



{/strip}