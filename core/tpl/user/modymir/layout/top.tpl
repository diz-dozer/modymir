{strip}
    <aside id="top">


        <div class="container">


            {*{include file='widget/enter.tpl'}*}


            <ul class="contacts">
                <li><a href="/">обратный звонок</a></li>
                <li>{$site.phone}</li>
                <li>{$site.phone2}</li>


                {if $log}

                    {if $isadmin}
                        <li><a href="{$smarty.const.ADMIN_FILE}" rel="nofollow">{$smarty.const.ADMINISTRATE_LINK}</a>
                        </li>
                    {/if}
                    <li><a href="/index.php?user_details" rel="nofollow">{$smarty.const.MY_ACCOUNT_LINK}</a></li>
                    <li><a href="/index.php?logout" rel="nofollow">{$smarty.const.LOGOUT_LINK}</a></li>
                {else}
                    <li><a class="lnk" href="/index.php?register" rel="nofollow">Регистрация</a></li>
                    <li><a href="/index.php?register_authorization">Вход</a></li>
                {/if}
            </ul>

        </div>

    </aside>
{/strip}



