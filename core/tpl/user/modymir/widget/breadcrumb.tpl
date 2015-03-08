{strip}

    {if $breadcrumb}
        <nav class="breadcrumbs">
            <ul>
                {section name=i loop=$breadcrumb}
                    <li class="itm">
                        {if $smarty.section.i.last}
                            <b class="active">{$breadcrumb[i].name}</b>
                        {else}
                            <a href="{$breadcrumb[i].url}">{$breadcrumb[i].name}</a>
                        {/if}
                    </li>
                {/section}
            </ul>
        </nav>
    {/if}

{/strip}