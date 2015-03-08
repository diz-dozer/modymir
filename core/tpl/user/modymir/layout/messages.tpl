{if $smarty.const.CONF_DISPLAY_INFO and $isadmin}{include file='layout/debug.tpl'}{/if}

{if $exploerrors}
    <div class="error">{$exploerrors}</div>
{/if}