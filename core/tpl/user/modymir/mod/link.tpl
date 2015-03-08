{strip}

    {if $link}
        <a href="{$link.url}" {if $class}class="{$class}"{/if}{if $class} rel="{$rel}"{/if}>{if $lbl}{$lbl}{else}{$link.lbl}{/if}</a>
    {/if}

{/strip}
