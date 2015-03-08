{strip}
{if $cats_tree}

<div class="w_showcase">


    {section name=a loop=$cats_tree}


    {if $smarty.const.CONF_MOD_REWRITE}


    {if $cats_tree[a].alias}
    {assign var=url value="/`$cats_tree[a].alias`/"}
    {else}
    {assign var=url value="category_`$cats_tree[a].categoryID`.html"}
    {/if}

    {else}
    {assign var=url value="index.php?categoryID=`$cats_tree[a].categoryID`"}
    {/if}



    <div class="itm">


        <div class="w_showcase_cat">


            {*
            <a class="picture" href="{$url}">
                {if $cats_tree[a].picture}
                {assign var=x_img value="/img/w238-h150/"}
                <img src="{$x_img}data/category/{$cats_tree[a].picture}" alt="{$cats_tree[a].name}" />
                {/if}
            </a>
            *}

            <a class="lnk" href="{$url}" >{$cats_tree[a].name}</a>



            {if $cats_tree[a].children}

            {assign var=children value=$cats_tree[a].children}



            {section name=b loop=$children}

            {if $smarty.const.CONF_MOD_REWRITE}
            {assign var=url value="category_`$children[b].categoryID`.html"}
            {else}
            {assign var=url value="index.php?categoryID=`$children[b].categoryID`"}
            {/if}




            <div class="w_showcase_wrap">
                <dl class="w_showcase">
                    <dd class="w_showcase_name"><a href="{$url}">{$children[b].name}</a></dd>
                    <dd class="w_showcase_price">от <span class="price">{$children[b].min}</span></dd>
                </dl>
            </div>







            {/section}

            {/if}

        </div>
    </div>


    {/section}
</div>
{/strip}
{/if}