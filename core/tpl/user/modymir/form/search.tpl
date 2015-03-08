{strip}

    {if $smarty.get.search_name}
        {assign var=search_string value=`$smarty.get.search_name`}
    {else}
        {assign var=search_string value=`$searchstring`}
    {/if}

    <div class="search">
    <form id="search" class=" s-wrap" method="get" action="/index.php">

            <input required class="s-input"  name="searchstring" value="{$search_string}" placeholder="Поиск по сайту..."/>
            <button class="s-btn" type="submit" title="Найти"><i class="fa fa-search"></i></button>
    </form>
    </div>

{/strip}