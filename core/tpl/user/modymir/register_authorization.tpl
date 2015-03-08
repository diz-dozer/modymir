{strip}
    {*<article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_REGISTER_AUTH}
        </header>
    </article>*}

    {*{$smarty.const.STRING_I_AM_REGISTERED_CUSTOMER}*}
    <div class="col _1_2">

        <h2>Вход на сайт</h2>


        <form action="index.php?register_authorization=yes" method="post">


            <div class="field">
                <input placeholder="{$smarty.const.CUSTOMER_LOGIN}" required="required" type="text" name="user_login"/>
            </div>

            <div class="field">
                <input placeholder="{$smarty.const.CUSTOMER_PASSWORD}" required="required" name="user_pw" type="password"/>
                <input type="hidden" name="login" value="1"/>
            </div>

            <div class="field">
                <a href="/index.php?logging" rel="nofollow">Забыли пароль?</a>
            </div>

            <div class="buttons">
                <button type="submit">{$smarty.const.BUTTON_ENTER_AUTH}</button>
            </div>


        </form>


    </div>
    <div class="col _1_2">


        <h2>Новый пользователь</h2>


        {*{$smarty.const.STRING_AM_NEW_CUSTOMER}*}

        {*{$smarty.const.STRING_QUICK_ORDERING}*}

        {*{$smarty.const.STRING_REGISTER}*}

        {if $smarty.const.CONF_ORDERING_REQUEST_BILLING_ADDRESS == '1'}
            {assign var=reg_link value='register=yes&amp;order=yes'}

        {/if}

        {if $smarty.const.CONF_ORDERING_REQUEST_BILLING_ADDRESS == '0'}
            {assign var=reg_link value='register=yes&amp;order_without_billing_address=yes'}
        {/if}

        {*{if $smarty.const.CONF_USER_SYSTEM < 2}*}
        {*{assign var=reg_link value='quick_register=yes'}*}
        {*{/if}*}

        <p class="hint">
            Зарегистрируйся и получи скидку 5%<br/>
            Это займет пару минут
        </p>

        <p>
            <a rel="nofollow" class="button _green" href="index.php?{$reg_link}">Зарегистрироваться</a>
        </p>


    </div>
{/strip}
