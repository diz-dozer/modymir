{strip}
{if $parent_category}

{if $smarty.const.CONF_MOD_REWRITE}
{assign var=url value="category_`$parent_category.categoryID`.html"}
{else}
{assign var=url value="index.php?categoryID=`$parent_category.categoryID`"}
{/if}

<a class="parent-link" href="{$url}">{$parent_category.name}</a>

{/if}
{/strip}