{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_AFFILIATE_PROGRAM}
        </header>


        {include file='mod/menu_cabinet.tpl'}


        {include file='mod/menu_affiliate.tpl'}



        {* баланс *}

        {if $SubPage=='balance'}
            <h2>{$smarty.const.AFFP_USER_BALANCE}</h2>
            {if $smarty.const.CONF_USER_SYSTEM eq 2}
                {$smarty.const.STRING_AFFILIATE_CUSTOMERS}:
                <b>{$affiliate_customers}</b>
            {/if}


            {if $CommissionsNumber}
                <table cellspacing="0" cellpadding="0" width="100%">

                    <thead>
                    <tr>
                        <th>{$smarty.const.AFFP_STRING_TOTAL_EARNINGS}</th>
                        <th>{$smarty.const.AFFP_STRING_TOTAL_PAYMENTS}</th>
                        <th>{$smarty.const.AFFP_USER_BALANCE}</th>
                    </tr>
                    </thead>

                    <tbody>
                    {foreach from=$CurrencyISO3 item=_CurrencyISO}
                        {if $CommissionsAmount[$_CurrencyISO.currency_iso_3] or $PaymentsAmount[$_CurrencyISO.currency_iso_3]}
                            <tr>
                                <td>{$_CurrencyISO.currency_iso_3} {$CommissionsAmount[$_CurrencyISO.currency_iso_3]|string_format:"%.2f"} </td>
                                <td>{$PaymentsAmount[$_CurrencyISO.currency_iso_3]|string_format:"%.2f"} </td>
                                <td>{"`$CommissionsAmount[$_CurrencyISO.currency_iso_3]-$PaymentsAmount[$_CurrencyISO.currency_iso_3]`"|string_format:"%.2f"} </td>
                            </tr>
                        {/if}
                    {/foreach}
                    </tbody>
                </table>
            {else}

                {include file='mod/message.tpl' txt=$smarty.const.AFFP_MSG_NO_BALANCE}

            {/if}

        {/if}

        {* история выплат *}

        {if $SubPage=='payments_history'}
            <h2>{$smarty.const.AFFP_PAYMENTS_HISTORY}</h2>
            {if $PaymentsNumber}
                <table cellspacing="1" cellpadding="0" width="100%" class="gre">
                    <tr>
                        <td class="lt pad" align="left">{$smarty.const.AFFP_PAYMENT_NUMBER}</td>
                        <td class="lt pad" align="left">{$smarty.const.ADMIN_CURRENT_DATE}</td>
                        <td class="lt pad" align="left">{$smarty.const.STRING_ADMIN_COMMENT}</td>
                        <td class="lt pad" align="left">{$smarty.const.STRING_SUM}</td>
                    </tr>
                    {foreach from=$Payments item=_Payment}
                        <tr>
                            <td class="padt" align="left">P-{$_Payment.pID} </td>
                            <td class="padt" align="left">{$_Payment.xDate} </td>
                            <td class="padt" align="left">{$_Payment.Description} </td>
                            <td class="padt" align="left">{$_Payment.Amount} {$_Payment.CurrencyISO3} </td>
                        </tr>
                    {/foreach}
                </table>
                <br>
            {else}

                {include file='mod/message.tpl' txt=$smarty.const.AFFP_MSG_NO_PAYMENTS}
            {/if}

        {/if}

        {* настройки *}

        {if $SubPage=='settings'}
            <h2>{$smarty.const.STRING_MODULE_SETTING}</h2>
            {if $SettingsSaved}
                {include file='mod/message.tpl' type='sucsess' txt=$smarty.const.MSG_INFORMATION_SAVED}
            {/if}



            {if $smarty.const.CONF_AFFILIATE_EMAIL_NEW_COMMISSION or $smarty.const.CONF_AFFILIATE_EMAIL_NEW_PAYMENT}
                <form name="form_settings" action="{$REQUEST_URI}" method="POST" id="form_settings">


                    {if $smarty.const.CONF_AFFILIATE_EMAIL_NEW_COMMISSION}
                        <div class="field">
                            <label for="id_emailorders">
                                <input name="EmailOrders" value="1" type="checkbox" id="id_emailorders" {if $Settings.EmailOrders}checked="checked"{/if}/>
                                {$smarty.const.AFFP_EMAILORDERS}</label>
                        </div>
                    {/if}



                    {if $smarty.const.CONF_AFFILIATE_EMAIL_NEW_PAYMENT}
                        <div class="field">
                            <label for="id_emailpayments">
                                <input name="EmailPayments" type="checkbox" id="id_emailpayments" value="1" {if $Settings.EmailPayments}checked="checked"{/if}/>
                                {$smarty.const.AFFP_EMAILPAYMENTS}
                            </label>
                        </div>
                    {/if}


                    <div class="buttons">
                        <input name="fACTION" value="SAVE_SETTINGS" type="hidden"/>
                        <input name="fREDIRECT" value="{$REQUEST_URI}" type="hidden"/>
                        <button type="submit">{$smarty.const.SAVE_BUTTON}</button>
                    </div>

                </form>
            {/if}




        {/if}

        {* инструкции *}

        {if $SubPage=='attract_guide'}
            <h2>{$smarty.const.AFFP_ATTRACT_GUIDE}</h2>
            {$_AFFP_STRING_ATTRACT_GUIDE}

        {/if}


    </article>
{/strip}