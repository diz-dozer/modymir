{strip}

    {*{$smarty.const.STRING_ORDER_CONTINUE_TIP}*}

    {if $order}
        {assign var=action value="index.php?register=yes&order=yes"}
    {else}
        {assign var=action value="index.php?register=yes"}
    {/if}
    <form action="{$action}" method="post">


        {if $reg_error}{include file='mod/message.tpl' txt=$reg_error}{/if}

        {*{include file='mod/message.tpl' txt=$smarty.const.STRING_REQUIRED type='info'}*}


        <div class="col _1_3">


            <h2>{$smarty.const.STRING_REGISTER}</h2>


            <div class="field">
                <input required="required" placeholder="{$smarty.const.CUSTOMER_LOGIN}" type="text" name="login" value="{$login}"/>
            </div>


            <div class="field">
                <input required="required" placeholder="{$smarty.const.CUSTOMER_PASSWORD}" type="password" name="cust_password1" value="{$cust_password1}"/>
            </div>


            <div class="field">
                <input required="required" placeholder="{$smarty.const.CUSTOMER_CONFIRM_PASSWORD}" type="password" name="cust_password2" value="{$cust_password2}"/>
            </div>


            <div class="field _checkbox_label">
                <label>
                    <input type="checkbox" name="subscribed4news" {if $subscribed4news == 1}checked=" checked"{/if} />
                    <span>{*$smarty.const.CUSTOMER_SUBSCRIBE_FOR_NEWS*}Подписка на рассылку</span>
                </label>
            </div>

            {include file='mod/captcha.tpl'}


        </div>

        <div class="col _1_3">

            <h2>Контакты</h2>

            <div class="field">
                <input required="required" placeholder="{$smarty.const.CUSTOMER_FIRST_NAME}" type="text" name="first_name" value="{$first_name}"/>
            </div>


            <div class="field">
                <input required="required" placeholder="{$smarty.const.CUSTOMER_LAST_NAME}" type="text" name="last_name" value="{$last_name}">
            </div>


            <div class="field">
                <input required="required" placeholder="{$smarty.const.CUSTOMER_EMAIL}" type="email" name="email" value="{$email}"/>
            </div>


            {section name=i loop=$additional_fields}
                <div class="field">
                    <input {if $additional_fields[i].reg_field_required} required="required"{/if} placeholder="{$additional_fields[i].reg_field_name}" type="text" name="additional_field_{$additional_fields[i].reg_field_ID}" value="{$additional_field_values[i].reg_field_value}"/>
                </div>
            {/section}

        </div>


        <div class="col _1_3">


            <h2>Адрес доставки</h2>


            {if !$SessionRefererLogin && $smarty.const.CONF_AFFILIATE_PROGRAM_ENABLED}
                <div class="field">
                    <input placeholder=">{$smarty.const.CUSTOMER_AFFILIATION}" type="text" name="affiliationLogin" value="{$affiliationLogin}"/>
                </div>
            {/if}


            {if $order}
                <div class="field">
                    <input required="required" placeholder="{$smarty.const.STRING_RECEIVER_FIRST_NAME}" type=text name='receiver_first_name' value='{$receiver_first_name}' onblur='billingAddressCheckHandler()' onchange='billingAddressCheckHandler()'/>
                </div>
                <div class="field">
                    <input required="required" placeholder="{$smarty.const.STRING_RECEIVER_LAST_NAME}" type=text name='receiver_last_name' value='{$receiver_last_name}' onblur='billingAddressCheckHandler()' onchange='billingAddressCheckHandler()'/>
                </div>
            {/if}



            {if $countries}
                <div class="field">


                    <select required="required" name="countryID" onchange='billingAddressCheckHandler();changeCountryHandler();'>

                        <option disabled="disabled" value="false">{$smarty.const.CUSTOMER_COUNTRY}</option>

                        {section name=i loop=$countries}


                            {if $countries[i].countryID == $smarty.const.CONF_DEFAULT_COUNTRY}
                                {assign var=selected value='selected="selected"'}
                            {else}
                                {assign var=selected value=''}
                            {/if}


                            {if $countries[i].countryID == $countryID}
                                {assign var=selected value='selected="selected"'}
                            {/if}
                            <option value="{$countries[i].countryID}" {$selected}>{$countries[i].country_name}</option>
                        {/section}
                    </select>
                </div>
            {/if}


            {if $smarty.const.CONF_ADDRESSFORM_STATE ne 2}
                <div class="field">

                    {if $zones}
                        <input placeholder="{$smarty.const.CUSTOMER_STATE}" {if $smarty.const.CONF_ADDRESSFORM_STATE eq 0}required="required"{/if} type="text" name="state" value="{$state}" onchange='billingAddressCheckHandler()'/>
                    {else}
                        <select {if $smarty.const.CONF_ADDRESSFORM_STATE eq 0}required="required"{/if} name="zoneID" onchange='billingAddressCheckHandler()'>

                            <option disabled="disabled" value="false">{$smarty.const.CUSTOMER_STATE}</option>
                            {section name=i loop=$zones}
                                <option value="{$zones[i].zoneID}" {if $zones[i].zoneID == $zoneID}selected{/if}>{$zones[i].zone_name}</option>
                            {/section}
                        </select>
                    {/if}

                </div>
            {else}


                {if !$zones}
                    <input type="hidden" name="state" value=""/>
                {else}
                    <input type="hidden" name="zoneID" value="0"/>
                {/if}
            {/if}


            {if $smarty.const.CONF_ADDRESSFORM_CITY ne 2}
                <div class="field">
                    <input placeholder="{$smarty.const.CUSTOMER_CITY}" {if $smarty.const.CONF_ADDRESSFORM_CITY eq 0}required="required" {/if}type="text" name="city" value="{$city}" onblur='billingAddressCheckHandler()' onchange='billingAddressCheckHandler()'>
                </div>
            {else}
                <input type="hidden" name="city" value=""/>
            {/if}



            {if $smarty.const.CONF_ADDRESSFORM_ADDRESS ne 2}
                <div class="field">
                    <textarea placeholder="{$smarty.const.CUSTOMER_ADDRESS}" {if $smarty.const.CONF_ADDRESSFORM_ADDRESS eq 0}required="required"{/if} name="address" onchange='billingAddressCheckHandler()'>{$address}</textarea>
                </div>
            {else}
                <input type="hidden" name="address" value=""/>
            {/if}


        </div>


        <div class="buttons">

            {if $order}<input type="hidden" name="order" value="1"/>{/if}

            {if $order_without_billing_address}
                <input type="hidden" name="order_without_billing_address" value="1"/>
            {/if}


            {if $SessionRefererLogin || $smarty.const.CONF_AFFILIATE_PROGRAM_ENABLED eq 0}
                <input name="affiliationLogin" type="hidden" value="{$SessionRefererLogin}"/>
            {/if}

            {if !$countries}<input type="hidden" name="countryID" value="NULL"/>{/if}


            <button type="submit" value="1" name="save">Зарегистрироваться{if $order} и продолжить оформление{/if} </button>

        </div>



        {*{if $reg_updating}*}
            {*<a href="javascript:confirmUnsubscribe();">{$smarty.const.TERMINATE_ACCOUNT_LINK}</a>*}
        {*{/if}*}


        {*{literal}*}
            {*<script type="text/javascript">*}
                {*function billingAddressCheckHandler() {*}
                    {*return;*}
                {*}*}
                {*function changeCountryHandler() {*}
                    {*document.RegisterForm.submit();*}
                {*}*}
            {*</script>*}
        {*{/literal}*}


    </form>
{/strip}