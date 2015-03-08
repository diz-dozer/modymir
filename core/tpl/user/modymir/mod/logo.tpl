{strip}

{assign var=logo value='all-accessorize.ru'}

<div class="w_logo">

    {if $pageID eq 'home'}
    <h1 class="logo">{$logo}</h1>
    {else}
    <a class="logo" href="/">{$logo}</a>
    {/if}

</div>
{/strip}