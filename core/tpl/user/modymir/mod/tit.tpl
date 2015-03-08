{strip}


    <{$tag|default:'h2'}{if $id} id="{$id}"{/if} class="{$cls|default:'tit _page'}{if $mod} {$mod}{/if}">
    {* <span class="ico_tit {$cls|default:'_gray'}"><i class="ico {$nm|default:'_catalog'}">&nbsp;</i></span> *}
    {$txt}
    </{$tag|default:'h2'}>


{/strip}