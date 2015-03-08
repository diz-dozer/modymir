{strip}
    <article>


        <header>
            {include file='mod/admin_link.tpl' href='?dpt=conf&amp;sub=shipping'}
            {include file='mod/header.tpl' header=$smarty.const.STRING_ORDER_SHIPPING}
        </header>


        {if $shipping_methods}
            <form id="MainForm" method="post" action="#">

                <div class="radio_tap">
                    <legend class="legend">{$smarty.const.STRING_SELECT_ORDER_SHIPPING_METHOD_PROMPT}</legend>


                    {if $shippingAddressID==0}
                        {include file='mod/message.tpl' txt=$smarty.const.STRING_PLEASE_SPECIFY_ADDRESS}
                    {/if}


                    {section name=i loop=$shipping_methods}

                        {if $shipping_costs[i] ne 'n/a'}

                            {count item=_CostsNum array=$shipping_costs[i]}
                            <dl>
                                <dt>
                                    <input type="radio" name="select_shipping_method" id="ssm_{$smarty.section.i.index}" value="{$shipping_methods[i].SID}"{if $shipping_methods_count == 1} checked="checked"{/if}/>
                                </dt>
                                <dd>
                                    <label for="ssm_{$smarty.section.i.index}">

                                        <div class="inner">

                                            <div class="name">{$shipping_methods[i].Name}</div>

                                            <div class="description">{$shipping_methods[i].description}</div>

                                            <div class="rate">


                                                {if $shipping_costs[i][0].rate ne ''}

                                                    {if $_CostsNum > 1}
                                                        <select name="shServiceID[{$shipping_methods[i].SID}]">
                                                            {foreach from=$shipping_costs[i] item=_Rate}
                                                                <option value="{$_Rate.id}">{$_Rate.name} - {$_Rate.rate}</option>
                                                            {/foreach}
                                                        </select>
                                                    {else}
                                                        <b class="price">{$shipping_costs[i][0].rate}</b>
                                                    {/if}

                                                {else}
                                                    <b class="rate _free">{$smarty.const.STRING_ZERO_SHIPPING}</b>
                                                {/if}

                                            </div>
                                        </div>
                                    </label>
                                </dd>
                            </dl>
                        {/if}


                    {/section}

                </div>

                <div class="buttons">
                    <input id="continue_button" type="hidden" name="continue_button" value="2"/>
                    <button type="submit" onclick="ssm_ClickHandler(); return false;">{$smarty.const.CONTINUE_BUTTON}</button>
                </div>

            </form>
        {else}
            {include file='mod/message.tpl' txt=$smarty.const.STRING_NO_SHIPPING_METHODS_TO_SELECT}
        {/if}

    </article>
{/strip}


<script type="text/javascript">
    function ssm_ClickHandler() {ldelim}

        {if $shippingAddressID > 0}
        {if $shipping_methods_count > 1}

        for (i = 0; i <{$shipping_methods_count}; i++)
            if (document.getElementById('ssm_' + i))
                if (document.getElementById('ssm_' + i).checked)
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
        }{/literal} else return alert('{$smarty.const.STRING_SELECT_ORDER_SHIPPING_METHOD_PROMPT}');

        {elseif $shipping_methods_count eq 1}
        document.getElementById('MainForm').submit();
        return false;
        {/if}
        {/if}

        {rdelim}
</script>
