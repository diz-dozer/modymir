{strip}


    {include file='mod/admin_link.tpl' href="?categoryID=`$selected_category.categoryID`&amp;eaction=cat" tit=$smarty.const.ADMIN_ADMIN_MENUNEW1}

    {include file='mod/header.tpl' header=$categoryName}



   {if $selected_category.description|count_words > 3 && !$smarty.get.offset && !$smarty.get.show_all}
    <div class="description">
    {$selected_category.description}
    </div>
   {/if}

    <div class="offers">

        {section name=i loop=$products_to_show}
            {include file='mod/offer.tpl' offer=$products_to_show[i]}
        {/section}

    </div>

    {include file="mod/paginator.tpl"}



{/strip}