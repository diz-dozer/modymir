{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_VISIT_LOG}
        </header>


        {include file='mod/menu_cabinet.tpl'}

        {if $visits}

            <table cellpadding="0" width="100%">
                <caption>{$smarty.const.STRING_VISIT_LOG}</caption>
                <tbody>
                {section name=i loop=$visits}
                    <tr>
                        <td>{$visits[i].customer_logtime}</td>
                    </tr>
                {/section}
                </tbody>

            </table>
        {else}
            {include file='mod/message.tpl' txt=$smarty.const.STRING_EMPTY_LIST}
        {/if}

    </article>
{/strip}
