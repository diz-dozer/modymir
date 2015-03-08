{strip}
    <ul class="c_mnu">


        {if $cats_tree}

            {section name=h loop=$cats_tree}


                {if $smarty.const.CONF_MOD_REWRITE}
                    {assign var=lnk value="/category_`$cats_tree[h].categoryID`.html"}
                {else}
                    {assign var=lnk value="/index.php?categoryID=`$cats_tree[h].categoryID`"}
                {/if}


                {if $selected_category.categoryID eq $cats_tree[h].categoryID}
                    {assign var=class value='active'}
                {else}
                    {assign var=class value=''}
                {/if}

                <li class="itm {$class}">

                    <a href="{$lnk}" class="lnk">{$cats_tree[h].name}</a>

                    {*{if $cats_tree[h].subcount > 0}
                        {assign var=sub_tree value=$cats_tree[h].sub}
                        <ul class="c_mnu_sub">

                            {section name=s loop=$sub_tree}

                                {if $smarty.const.CONF_MOD_REWRITE}
                                    {assign var=sub_lnk value="/category_`$sub_tree[s].categoryID`.html"}
                                {else}
                                    {assign var=sub_lnk value="/index.php?categoryID=`$sub_tree[s].categoryID`"}
                                {/if}
                                <li class="sub_itm">
                                    <a class="sub_lnk" href="{$sub_lnk}">{$sub_tree[s].name}</a>
                                </li>
                            {/section}

                        </ul>
                    {/if}*}
                </li>
            {/section}
        {/if}


    </ul>
{/strip}