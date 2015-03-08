{strip}

    {if $login_was_found}


        {include file='mod/message.tpl' type='success' txt=$smarty.const.STRING_PASSWORD_SENT}

        {*<div class="buttons">*}
        {*{include file='mod/link.tpl' link=$url.login rel='nofollow' lbl='Войти' class='button'}*}
        {*</div>*}

    {else}



        {if !$login_wasnt_found && !$wrongLoginOrPw}
            {include file='mod/message.tpl' type='info' txt='С помощью функции восстановления пароля забытый пароль придет к вам на e-mail'}
        {/if}

        {if $login_wasnt_found}
            {include file='mod/message.tpl' txt="`$smarty.const.STRING_CANT_FIND_USER_IN_DB` ( `$forgotpw` )"}
        {/if}

        {if $wrongLoginOrPw}
            {include file='mod/message.tpl' txt=$smarty.const.ERROR_WRONG_PASSWORD}
        {/if}

        <form method="post" action="/">

            <div class="field">
                {*<label>{$smarty.const.STRING_FORGOT_PASSWORD_FIX}</label>*}
                <input required="required" placeholder="Ведите ваш логин" type="text" name="forgotpw" value=""/>
            </div>

            <div class="buttons">
                <button type="submit">Восстановить</button>
            </div>
        </form>
    {/if}
{/strip}