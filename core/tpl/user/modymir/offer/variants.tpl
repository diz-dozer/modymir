{strip}

    {if $offer.variants}
        <div class="variants">

            {*{if $variants_count > 1}*}
                {*<input class="surplus" data-surplus="{$offer.variants[0].values_to_select[0].price_surplus}" type="hidden" name="opt_{$offer.variants[0].optionID}" value='{$offer.variants[0].values_to_select[0].variantID}'/>*}
            {*{else}*}
            {*{/if}*}

                {foreach from=$offer.variants item=extra}
                    <div class="variant">

                        {*<dt><label for="os{$extra.optionID}">Выберите {$extra.name|lower}</label></dt>*}

                            <select id="os{$extra.optionID}" name="opt_{$extra.optionID}">

                                {if $extra.variantID eq 0}
                                    <option data-surplus="0" value="" disabled selected>{$extra.name}{*$smarty.const.NOT_DEFINED*}</option>
                                {/if}


                                {section name=j loop=$extra.values_to_select}

                                    {if $extra.values_to_select[j].variantID eq $extra.variantID}
                                        {assign var=selected value=' selected="selected"'}
                                    {else}
                                        {assign var=selected value=''}
                                    {/if}

                                    <option data-surplus="{$extra.values_to_select[j].price_surplus}" value="{$extra.values_to_select[j].variantID}" {$selected}>{$extra.values_to_select[j].option_value}</option>


                                {/section}

                            </select>

                    </div>
                {/foreach}


        </div>
    {/if}


{/strip}