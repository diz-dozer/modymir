{strip}
    <article>

        <header>
            {include file='mod/admin_link.tpl' href='?dpt=conf&amp;sub=payment'}
            {include file='mod/header.tpl' header=$smarty.const.STRING_SELECT_ORDER_PAYMENT_METHOD_PROMPT}
        </header>


        {if $payment_methods}
            <form class="form" id="MainForm" method="post" action="#">

                <div class="radio_tap">
                    <legend>{$smarty.const.STRING_ORDER_PAYMENT}</legend>


                    {if $billingAddressID > 0 || $smarty.const.CONF_ORDERING_REQUEST_BILLING_ADDRESS == '0'}
                    {else}
                        {include file='mod/message.tpl' txt=$smarty.const.STRING_PLEASE_SPECIFY_ADDRESS}
                    {/if}


                    {section name=i loop=i loop=$payment_methods}
                        <dl>
                            <dt>
                                <input type="radio" name="select_payment_method" id="spm_{$smarty.section.i.index}"
                                        {if $smarty.section.i.index == 0} checked="checked"{/if} value="{$payment_methods[i].PID}"/>
                            </dt>
                            <dd>
                                <label for="spm_{$smarty.section.i.index}">
                                    <div class="inner">
                                        <div class="name">{$payment_methods[i].Name}</div>
                                        <div class="description">{$payment_methods[i].description}</div>
                                    </div>
                                </label>

                            </dd>
                        </dl>
                    {/section}

                </div>


                <div class="buttons">
                    {if $billingAddressID > 0 || $smarty.const.CONF_ORDERING_REQUEST_BILLING_ADDRESS == '0'}
                        <input type="hidden" name="continue_button" id="continue_button" value="2"/>
                    {/if}
                    <button type="submit" onclick="select_payment_methodClickHandler();return false;">{$smarty.const.CONTINUE_BUTTON}</button>
                </div>

            </form>
        {else}
            {include file='mod/message.tpl' txt=$smarty.const.STRING_NO_PAYMENT_METHODS_TO_SELECT}

        {/if}

    </article>
{/strip}


<script type="text/javascript">

    function select_payment_methodClickHandler() {ldelim}
        {if $payment_methods_count > 1}
        for (i = 0; i <{$payment_methods_count}; i++)
            if (document.getElementById('spm_' + i))
                if (document.getElementById('spm_' + i).checked)
                        {literal}
                {
                    document.getElementById('continue_button').value = 1;
                    break;

                }
        {/literal}
        if (document.getElementById('continue_button').value != 2)
                {literal}
        {
            document.getElementById('MainForm').submit();
            return false;
        }{/literal} else return alert('{$smarty.const.STRING_SELECT_ORDER_PAYMENT_METHOD_PROMPT}');

        {elseif $payment_methods_count eq 1}
        document.getElementById('MainForm').submit();
        return false;
        {/if}

        {rdelim}
</script>
