{strip}
{$smarty.const.STRING_SELECT_CURRENCY_TYPE}<div class="fil"></div>
<form method="post" action="" name='ChangeCurrencyForm' id='ChangeCurrencyForm'>
<select name='current_currency' onchange='_changeCurrency()'>
{section name=d loop=$currencies}
<option value='{$currencies[d].CID}' {if $currencies[d].CID eq $current_currency} selected {/if}>{$currencies[d].Name}</option>
{/section}
</select>
{if $order}<input type="hidden" name="InvId" value="{$order.orderID}">{/if}
</form>
{/strip}