{strip}
<div class="article b_authorization">


    {if $log}
    <h3 class="tit">Ваш Аккаунт</h3>
    <div class="b_authorization_inner">
        <ul class="mnu">
            {if $isadmin}<li><a href="{$smarty.const.ADMIN_FILE}">{$smarty.const.ADMINISTRATE_LINK}</a></li>{/if}
            <li><a href="index.php?user_details=yes">{$smarty.const.MY_ACCOUNT_LINK}</a></li>
            <li><a href="index.php?logout=yes">{$smarty.const.LOGOUT_LINK}</a></li>
        </ul>
    </div>
    {else}



    <form id="formAuthorization" method="post"  action="/index.php">

        <fieldset>

            <legend class="tit">Авторизация</legend>

            <div class="b_authorization_inner">

                <div class="f_row">
                    <label for="authorizationLogin">{$smarty.const.ADMIN_CUSTOMER_LOGIN}:</label>
                    <input title="Ваш логин..." type="text" class="placeholder" id="authorizationLogin" name="user_login" />
                </div>

                <div class="f_row">
                    <label for="authorizationPass">{$smarty.const.CUSTOMER_PASSWORD}:</label>
                    <input title="Ваш пароль..." type="password" class="placeholder" id="authorizationPass" name="user_pw" />
                </div>

                <div class="f_row btn_row cf">

                    <button class="btn btn_enter" type="submit" name="login" value="1">{$smarty.const.BUTTON_ENTER_AUTH}</button>
                    <div class="registr_lnk_wrap"><a class="registr_lnk" href="/">Регистрация</a></div>

                </div>

            </div>

        </fieldset>



    </form>


    {/if}


</div>
{/strip}