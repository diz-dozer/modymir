{strip}

    {if $offer.extra}

        <div class="extra-line">
            {section name=i loop=$offer.extra}

                {if $offer.extra[i].option_type eq 0 }
                    <div class="itm">
                        <b class="lbl">{$lbl} {$offer.extra[i].name}</b>
                        <span class="variant">{$offer.extra[i].option_value}</span>
                    </div>
                {/if}

                {if $offer.extra[i].option_type eq 1 && $offer.extra[i].values_to_select_count}


                    {if $offer.extra[i].values_to_select_count > 1}
                        {assign var=lbl value='Выберите '}
                        {assign var=cls value='itm'}
                        {assign var=for value=" for=\"os`$offer.extra[i].optionID`\""}
                    {else}
                        {assign var=for value=''}
                        {assign var=cls value='itm _lonely'}
                        {assign var=lbl value=''}

                    {/if}
                    <div class="{$cls}">


                        <label class="lbl"{$for}>{$lbl}{$offer.extra[i].name}</label>

                        {if $offer.extra[i].values_to_select_count eq 1}
                            <span class="variant">{$offer.extra[i].values_to_select[0].option_value}</span>
                            <input class="surplus" data-surplus="{$offer.extra[i].values_to_select[0].price_surplus}" type="hidden" name="opt_{$offer.extra[i].optionID}" value='{$offer.extra[i].values_to_select[0].variantID}'/>
                        {else}
                            <select class="variant extra surplus" id="os{$offer.extra[i].optionID}" name="opt_{$offer.extra[i].optionID}">

                                {if $offer.extra[i].variantID eq 0}
                                    <option data-surplus="0" selected="selected">{$smarty.const.NOT_DEFINED}</option>
                                {/if}


                                {section name=j loop=$offer.extra[i].values_to_select}

                                    {if $offer.extra[i].values_to_select[j].variantID eq $offer.extra[i].variantID}
                                        {assign var=selected value=' selected="selected"'}
                                    {else}
                                        {assign var=selected value=''}
                                    {/if}
                                    <option data-surplus="{$offer.extra[i].values_to_select[j].price_surplus}" value="{$offer.extra[i].values_to_select[j].variantID}"{$selected}>{$offer.extra[i].values_to_select[j].option_value}</option>
                                {/section}


                            </select>
                        {/if}


                    </div>
                {/if}

            {/section}
        </div>
    {/if}


{/strip}