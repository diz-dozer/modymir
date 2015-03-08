{strip}
    {if $follow}
        <ul class="follow{$mode}">
            {section name=i loop=$follow}
                <li>
                    <div title="Следите за нами в {$follow[i].lbl}" class="ico {$follow[i].cls}"><span>{$follow[i].lbl}</span></div>
                    {*<a title="Следите за нами в {$follow[i].lbl}" class="ico {$follow[i].cls}" href="{$follow[i].url}"><span>{$follow[i].lbl}</span></a>*}
                </li>
            {/section}
        </ul>
    {/if}
{/strip}