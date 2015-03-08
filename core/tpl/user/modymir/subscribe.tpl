{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_NEWS_SUBSCRIBE}
        </header>


        {if $subscribe == NULL}
            {if $error_message}
                {$error_message}
            {/if}
        {else}
           {$smarty.const.STRING_THANK_YOU_NEWS}
        {/if}

        {if $un_pol}
            {if $un_pol == 1}
              {$smarty.const.STRING_DESUBS_OK}
            {else}
               {$smarty.const.STRING_DESUBS_NO}
            {/if}
        {/if}

    </article>
{/strip}