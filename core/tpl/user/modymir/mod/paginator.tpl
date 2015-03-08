{strip}


{if $catalog_navigator}
{assign var=pager value=$catalog_navigator}
{/if}

{if $search_navigator}
{assign var=pager value=$search_navigator}
{/if}


{$pager}

{/strip}