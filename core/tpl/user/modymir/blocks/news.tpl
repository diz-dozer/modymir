{strip}
    {if $news_array}


        {include file='mod/tit.tpl' txt='Новости'}

        {section name=i loop=$news_array}

            {if $smarty.const.CONF_MOD_REWRITE}
                {assign var=url value="/show_news_`$news_array[i].NID`.html"}
            {else}
                {assign var=url value="/index.php?fullnews=`$news_array[i].NID`"}
            {/if}
            <article class="news">


                <div class="date">{$news_array[i].add_date|date_format:'%m/%d/%Y'}</div>

                <div class="tit"><a class="lnk" href="{$url}">{$news_array[i].title}</a></div>

                <div class="entry">
                    {$news_array[i].textToPrePublication}
                </div>

            </article>
        {/section}
        <div class="w_show-news">
            <a href="/news.html" class="show-news">Архив новостей</a>
        </div>
    {/if}
{/strip}