{strip}

    {if $offer.description}
        <div class="description _offer">
            <h2 class="tit">Описание товара</h2>
            {$offer.description}
        </div>
    {/if}
    {*{$offer.description|strip_tags}*}
    {*{$offer.brief_description}*}
{/strip}