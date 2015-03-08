{strip}

    {if $menu}

        {foreach from=$menu item=i}

        <{$tag|default:'li'}>
        <a href="{$i.url}">{$i.lbl}</a>
        </{$tag|default:'li'}>
        {/foreach}


    {/if}

{/strip}