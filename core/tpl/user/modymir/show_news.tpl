{strip}
    <article>


        <header>


            {include file='mod/admin_link.tpl' href="?dpt=modules&amp;sub=news"}
            {include file='mod/header.tpl' header=$smarty.const.STRING_NEWS_TITLE}

        </header>

        {if $news_array}

            {section name=i loop=$news_array}

                {if $smarty.const.CONF_MOD_REWRITE}
                    {assign var=url value="/show_news_`$news_array[i].NID`.html"}
                {else}
                    {assign var=url value="/index.php?fullnews=`$news_array[i].NID`"}
                {/if}

                <dl>
                    <dt><a class="lnk" href="{$url}">{$news_array[i].title}</a></dt>
                    <dd class="date">{$news_array[i].add_date|date_format:'%m/%d/%Y'}</dd>
                    <dd class="entry">{$news_array[i].textToPrePublication}</dd>
                </dl>
            {/section}

        {else}

            <div class="message error">{$smarty.const.STRING_NO_NEWS}</div>
        {/if}


    </article>
{/strip}