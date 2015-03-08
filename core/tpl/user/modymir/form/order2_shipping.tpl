{strip}


{if !$shipping_methods}
<div class="error">{$smarty.const.STRING_NO_SHIPPING_METHODS_TO_SELECT}</div>

{elseif !$shippingAddressID}

<div class="error">{$smarty.const.STRING_PLEASE_SPECIFY_ADDRESS}</div>
<a href="/index.php?add_new_address=yes" title="добавить адресс доставки">Добавить новый адрес</a>

{else}


<form id="OrderShippingForm"  method="post" action="">

    <fieldset class="radio-list ordrer-shippnig">
        <legend class="radio-list-legend"><span class="radio-list-legend-inn">{$smarty.const.STRING_SELECT_ORDER_SHIPPING_METHOD_PROMPT}</span></legend>
        {section name=i loop=$shipping_methods}

        <dl class="radio-list-item">

            {assign var=methodID value="select_shipping_method_`$smarty.section.i.index`"}

            {if $shipping_methods_count == 1 or $smarty.section.i.first}
            {assign var=checked value='checked="checked"'}
            {else}
            {assign var=checked value=""}
            {/if}


            {if $shipping_costs[i] ne "n/a" AND $shipping_costs[i][0].rate ne ""}

            {if $_CostsNum > 1}

            {capture assign=$costs}
            <select name="shServiceID[{$shipping_methods[i].SID}]">
                {foreach from=$shipping_costs[i] item=_Rate}
                <option value="{$_Rate.id}">{$_Rate.name} - {$_Rate.rate}</option>
                {/foreach}
            </select>
            {/capture}

            {else}
            {assign var=costs value=$shipping_costs[i][0].rate}
            {/if}
            {else}
            {assign var=costs value=$smarty.const.STRING_ZERO_SHIPPING}
            {/if}
            <dt class="radio-list-input">
            <input class="form-radio" type="radio" id="{$methodID}" name="select_shipping_method"  value="{$shipping_methods[i].SID}" {$checked}  />
            </dt>
            <dd class="radio-list-label">

                <label class="form-label" for="{$methodID}">
                    <span class="method-list-header">{$shipping_methods[i].Name}{*&nbsp;:&nbsp;<b class="ordrer-shippnig-costs">{$costs}</b>*}</span>
                    {if $shipping_methods[i].description}
                    <span class="method-list-item">{$shipping_methods[i].description}</span>
                    {/if}
                </label>
            </dd>
        </dl>
        {/section}

        <input type="hidden" id="continue_button" name="continue_button" value="2" />
    </fieldset>
</form>
<a href="#" onclick="select_shipping_methodClickHandler(); return false;">{$smarty.const.CONTINUE_BUTTON}</a>



<script type="text/javascript">
    function select_shipping_methodClickHandler()
    {ldelim}
    {if $shippingAddressID > 0}
    {if $shipping_methods_count > 1}
    for(i=0; i < {$shipping_methods_count}; i++ ) if (document.getElementById('select_shipping_method_'+i))
        if (document.getElementById('select_shipping_method_'+i).checked )
    {ldelim}
    document.getElementById('continue_button').value = 1; break;
    {rdelim}
    if (document.getElementById('continue_button').value != 2 )
    {ldelim}
    document.getElementById('OrderShippingForm').submit(); return false;
    {rdelim}else return alert('{$smarty.const.STRING_SELECT_ORDER_SHIPPING_METHOD_PROMPT}');
    {elseif $shipping_methods_count eq 1}
    document.getElementById('OrderShippingForm').submit(); return false;
    {/if}
    {/if}
    {rdelim}
</script>
{/if}
{/strip}
