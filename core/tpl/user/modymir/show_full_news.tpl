{strip}
    <article>

        {*{include file='mod/header.tpl' header="`$news_full_array.title``$a_lnk`"}*}
        {*$smarty.const.ADMIN_FILE*}

        <header>
            {include file='mod/header.tpl' header=$news_full_array.title}
            <div class="date">{$news_full_array.add_date|date_format:'%m/%d/%Y'}</div>
        </header>

        {*<div class="tit"><a class="lnk" href="{$url}">{$news_full_array.title}</a></div>*}

        <div class="entry">
            {$news_full_array.textToPublication}
        </div>

    </article>
{/strip}