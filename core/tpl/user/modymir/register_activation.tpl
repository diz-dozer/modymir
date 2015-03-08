{strip}

    {if $smarty.const.CONF_ENABLE_REGCONFIRMATION}
        <article class="_tc">

            <header>
                {include file='mod/header.tpl' header='Подтверждение регистрации'}
            </header>



            {if $ActOk}

                {include file='mod/message.tpl' type='success' txt=$smarty.const.REGCONFIRM_SUCCESS}

                <div class="buttons">
                    <a class="button" href="/index.php?user_details=yes">Перейти в кабинет</a>
                </div>

            {else}
                <form method="get" action="/">

                    {$smarty.const.REGCONFIRM_TYPE_CODE}

                    {if $ActErr}
                        {include file='mod/message.tpl' txt=$smarty.const.REGCONFIRM_WRONG_ACTCODE}
                    {/if}

                    {if $NoAct}
                        {include file='mod/message.tpl' txt=$smarty.const.REGCONFIRM_NOTACTIVATED}
                    {/if}


                    <div class="field">

                        <input required="required" type="text" name="act_code" value="{$ActCode}"/>

                    </div>

                    <div class="buttons">
                        {if $smarty.get.order2}
                            <input type="hidden" name="order2" value="{$smarty.get.order2}"/>
                        {/if}
                        <button type="submit" name="act_customer" value="1">{$smarty.const.ACTIVATE_BUTTON}</button>

                    </div>

                </form>
            {/if}

        </article>
    {/if}

{/strip}
