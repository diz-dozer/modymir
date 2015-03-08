{strip}

{if $offer.product_code}

<div class="product_code">

    {if $show_label}
    <span class="lbl">{*$smarty.const.STRING_PRODUCT_CODE*}Артикул:</span>&nbsp;
    {/if}

    <b>{$product_info.product_code}</b>

</div>
{/if}

{/strip}