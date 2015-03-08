{strip}
    <article>

        <header>

            {include file='mod/header.tpl' header="Результаты поиска по запросу «`$searchstring`»"}
            {if $products_to_show_count > 0}
            <h2 class="tit">{$smarty.const.STRING_FOUND} <b>{$products_found}</b> {$smarty.const.STRING_PRODUCTS}</h2>
            {/if}

        </header>


        {if $products_to_show_count > 0}

            <section class="offers">
                {section name=i loop=$products_to_show}
                    {include file='mod/offer.tpl' offer=$products_to_show[i]}
                {/section}

            </section>
            {include file="mod/paginator.tpl"}


        {else}

            {include file='mod/message.tpl' txt=$smarty.const.STRING_NO_MATCHES_FOUND}

        {/if}


    </article>
{/strip}