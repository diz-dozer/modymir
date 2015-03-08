{strip}
    <dl class="w_logo">

        <dt class="logo">
        {if $pageID eq 'home'}
            {$site.name}
        {else}
            <a href="/" rel="home">{$site.name}</a>
        {/if}
        </dt>
        {if $site.slogan}
            <dd class="slogan">{$site.slogan}</dd>
        {/if}
    </dl>
{/strip}