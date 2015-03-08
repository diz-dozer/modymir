{strip}
    {if $offer}
        {section name=e loop=$offer.extra}
            {if $offer.extra[e].option_type eq 1 && $offer.extra[e].values_to_select_count}
                {if $offer.extra[e].values_to_select_count eq 1}
                    <input class="surplus" data-surplus="{$offer.extra[e].values_to_select[0].price_surplus}" type="hidden" name="opt_{$offer.extra[e].optionID}" value='{$offer.extra[e].values_to_select[0].variantID}'/>
                {else}
                    {section name=j loop=$offer.extra[e].values_to_select}
                        {if $offer.extra[e].values_to_select[j].variantID eq $offer.extra[e].variantID}
                            <input class="surplus" data-surplus="{$offer.extra[e].values_to_select[j].price_surplus}" type="hidden" name="opt_{$offer.extra[e].optionID}" value='{$offer.extra[e].values_to_select[j].variantID}'/>
                        {/if}
                    {/section}
                {/if}
            {/if}
        {/section}
    {/if}
{/strip}