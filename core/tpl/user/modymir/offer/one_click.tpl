{strip}


    {if !$smarty.const.CONF_CHECKSTOCK AND $offer.in_stock >= 0}
        <button class="btn _gray ajx" value="ajxOneClick">{$smarty.const.ONE_CLICK_STRING}</button>
    {/if}

{/strip}