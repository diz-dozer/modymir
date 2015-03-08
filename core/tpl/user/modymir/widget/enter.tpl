{strip}
<div class="w_enter">
    {if $log}
        <ul class="is-log">
            {if $isadmin}
                <li>
                    <a class="lnk" href="{$smarty.const.ADMIN_FILE}" rel="nofollow">{$smarty.const.ADMINISTRATE_LINK}</a>
                </li>
            {/if}
            <li><a class="lnk" href="/index.php?user_details" rel="nofollow">{$smarty.const.MY_ACCOUNT_LINK}</a></li>
            <li><a class="lnk" href="/index.php?logout" rel="nofollow">{$smarty.const.LOGOUT_LINK}</a></li>
        </ul>
    {else}
    <ul class="no-log">
        <li><a class="lnk ajx" data-tpl="login" href="/index.php?register_authorization" rel="nofollow"><i class="fa fa-key"></i>&nbsp;Личный кабинет</a></li>
        {*<li> <a class="lnk" href="/index.php?register" rel="nofollow">Регистрация</a></li>*}
    </ul>
    {/if}
</div>
{/strip}

{*<li><a class="lnk enter" href="#"><i class="fa fa-key"></i>&nbsp;Личный кабинет</a></li>*}

