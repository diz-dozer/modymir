{strip}
    <!doctype html>
    <html lang="ru" class="no-js">
    {include file='layout/head.tpl'}

    <body>

    {if $smarty.const.CONF_SHOP_BILD and !$isadmin}
        {include file='layout/maintenance.tpl'}
    {else}
        <div id="fixed">
            {include file='layout/messages.tpl'}
            {include file='layout/header.tpl'}
            {include file='layout/nav.tpl'}
        </div>
        {include file='layout/map.tpl'}

        {include file='layout/content.tpl'}
        {include file='layout/additional.tpl'}
        {include file='layout/footer.tpl'}


    {/if}

    {*{include file="layout/ajx_forms.tpl"}*}
    {include file="layout/js.tpl"}

    </body>
    </html>
{/strip}