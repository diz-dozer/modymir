{strip}

    {include file='header.tpl' header=$categoryName}

    {if $products_to_show}

        {include file='mod/paginator.tpl'}
        <div class="offers">


            {section name=i loop=$products_to_show}
                {include file='offer/brief.tpl' product_info=$products_to_show[i]}
            {/section}


        </div>
        {include file='mod/paginator.tpl'}

    {else}
        {if $search_with_change_category_ability}
            <div class="error">{$smarty.const.STRING_EMPTY_SEARCH_RESULT}</div>
        {/if}

    {/if}
{/strip}