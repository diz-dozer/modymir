
{strip}

{if !$payment_methods}

<div class="error">{$smarty.const.STRING_NO_PAYMENT_METHODS_TO_SELECT}</div>
{elseif !$shippingAddressID}
<div class="error">{$smarty.const.STRING_PLEASE_SPECIFY_ADDRESS}</div>
<a href="/index.php?add_new_address=yes" title="добавить адресс доставки">Добавить новый адрес</a>

{else}


<form  id="OrderBillingForm"  method="post" action="">
    <fieldset class="radio-list ordrer-shippnig">

        <legend class="radio-list-legend"><span class="radio-list-legend-inn">{$smarty.const.STRING_SELECT_ORDER_PAYMENT_METHOD_PROMPT}</span></legend>


        {section name=i loop=i loop=$payment_methods}

        <dl class="radio-list-item">

            {assign var=methodID value="select_payment_method__`$smarty.section.i.index`"}

            {if $payment_methods_count == 1 or $smarty.section.i.first}
            {assign var=checked value='checked="checked"'}
            {else}
            {assign var=checked value=""}
            {/if}

            <dt class="radio-list-input">

            <input type="radio" id="{$methodID}" name="select_payment_method" value="{$payment_methods[i].PID}" {$checked} />
            </dt>
            <dd class="radio-list-label">
                <label class="form-label" for="{$methodID}">
                    <span class="method-list-header">{$payment_methods[i].Name}</span>
                    {if $payment_methods[i].description}
                    <span class="method-list-item">{$payment_methods[i].description}</span>
                    {/if}
                </label>
            </dd>
        </dl>
        {/section}

        <input type="hidden" id="continue_button" name="continue_button"  value="1" />
    </fieldset>

    <a href="#" onclick="select_payment_methodClickHandler(); return false;">{$smarty.const.CONTINUE_BUTTON}</a>

</form>


<script type="text/javascript">
    function select_payment_methodClickHandler()
    {ldelim}
    {if $payment_methods_count > 1}
    for( i=0; i < {$payment_methods_count}; i++ ) if (document.getElementById('select_payment_method_'+i))
        if (document.getElementById('select_payment_method_'+i).checked )
    {ldelim}
    document.getElementById('continue_button').value = 1; break;
    {rdelim}
    if (document.getElementById('continue_button').value != 2 )
    {ldelim}
    document.getElementById('OrderBillingForm').submit(); return false;
    {rdelim}else return alert('{$smarty.const.STRING_SELECT_ORDER_PAYMENT_METHOD_PROMPT}');
    {elseif $payment_methods_count eq 1}
    document.getElementById('OrderBillingForm').submit(); return false;
    {/if}
    {rdelim}
</script>

{/if}
{/strip}