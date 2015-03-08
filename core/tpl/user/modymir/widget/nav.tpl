{strip}
<ul class="nav _main">
    {section name=i loop=$site_mnu}
        <li class="itm">
            {if $site_mnu[i].cls}
                <b class="lnk active">{$site_mnu[i].lbl}</b>
            {else}
                <a class="lnk" href="{$site_mnu[i].url}">{$site_mnu[i].lbl}</a>
            {/if}
        </li>
    {/section}
</ul>
{/strip}