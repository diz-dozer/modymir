{strip}
    <article class="_tc">

        <header>

            {include file='mod/header.tpl' header='dss'}
        </header>




        {if $reg_terminated}

            {include file='mod/message.tpl' txt=$smarty.const.STRING_SUCCESSFUL_ACCOUNT_TERMINATION}

        {else}
            {if $reg_updating}

                {include file='mod/message.tpl' type='success' txt=$smarty.const.STRING_ACOOUNT_UPDATE_SUCCESSFUL}


            {else}



                {if $smarty.const.CONF_ENABLE_REGCONFIRMATION}
                    {$smarty.const.REGACTIVATION}
                {/if}

                {include file='mod/message.tpl' type='success' txt=$smarty.const.STRING_REGISTRATION_SUCCESSFUL}


                {if $smarty.const.CONF_ENABLE_REGCONFIRMATION}
                    <form method="get" action="/">

                        <div class="field">
                            <input placeholder="{$smarty.const.REGCONFIRM_TYPE_CODE}" type="text" name="act_code" value="{$ActCode}"/>
                        </div>

                        <div class="buttons">

                            <button type="submit" name="act_customer" value="1">{$smarty.const.ACTIVATE_BUTTON}</button>
                        </div>

                    </form>
                {/if}
            {/if}
        {/if}


    </article>
{/strip}
