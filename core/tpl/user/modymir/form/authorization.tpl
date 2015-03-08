{strip}


{if $isadmin}


<a href="{$smarty.const.ADMIN_FILE}">{$smarty.const.ADMINISTRATE_LINK}</a>
<div class="fil1"></div>
<a href="index.php?user_details=yes">{$smarty.const.MY_ACCOUNT_LINK}</a>
<div class="fil1"></div>
<a href="index.php?logout=yes">{$smarty.const.LOGOUT_LINK}</a>
{elseif $log ne ""}
<a href="index.php?user_details=yes">{$smarty.const.MY_ACCOUNT_LINK}</a>
<div class="fil1"></div>
<a href="index.php?logout=yes">{$smarty.const.LOGOUT_LINK}</a>


{else}



<form class="form" id="formAuthorization" method="post"  action="/index.php">

    <fieldset>
        <legend>Авторизация</legend>

        <dl>

            <dt class="form-label"><label for="authorization-login">{$smarty.const.ADMIN_CUSTOMER_LOGIN}:</label></dt>
            <dd class="form-item"><input type="text" class="input" id="authorization-login" name="user_login" /></dd>
            <dt class="form-label"><label for="authorization-pass">{$smarty.const.CUSTOMER_PASSWORD}:</label></dt>
            <dd class="form-item"><input type="password" class="input" id="authorization-pass" name="user_pw" /></dd>


        </dl>


        <input type="hidden" name="login" value="1" />

        <button class="btn btn_enter">{$smarty.const.BUTTON_ENTER_AUTH}</button>
    </fieldset>



</form>


{/if}

{/strip}