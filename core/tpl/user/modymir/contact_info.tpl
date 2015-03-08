{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header="`$smarty.const.STRING_USER_DATA_ALL` (`$log`)"}
        </header>

        {include file='mod/menu_cabinet.tpl'}



        <form action="index.php?contact_info=yes" method="post">


            {if $error}
                {include file='mod/message.tpl' txt=$error}
            {/if}
            
            {*{include file='mod/message.tpl' type='info' txt=$smarty.const.STRING_REQUIRED}*}

            <div class="col _1_3">

                <div class="field">
                    <label>{$smarty.const.CUSTOMER_LOGIN}</label>
                    <input required="required" type="text" placeholder="{$smarty.const.CUSTOMER_LOGIN}" name="login" value="{$login}"/>
                </div>
                <div class="field">
                    <label>{$smarty.const.CUSTOMER_PASSWORD}</label>
                    <input required="required" type="password" name="cust_password1" value="{$cust_password1}"/>
                </div>

                <div class="field">
                    <label>{$smarty.const.CUSTOMER_CONFIRM_PASSWORD}</label>
                    <input type="password"  name="cust_password2" value="{$cust_password2}">
                </div>





                {*{include file='mod/captcha.tpl'}*}

            </div>

            <div class="col _1_3">
                <div class="field">
                    <label>{$smarty.const.CUSTOMER_FIRST_NAME}</label>
                    <input required="required" type="text"  name="first_name" value="{$first_name}">
                </div>

                <div class="field">
                    <label>{$smarty.const.CUSTOMER_LAST_NAME}</label>
                    <input required="required" type="text"  name="last_name" value="{$last_name}">
                </div>

                <div class="field _checkbox_label">
                    <label>
                        <input type="checkbox" name="subscribed4news"{if $subscribed4news} checked=" checked"{/if} />
                        <span>Подписка на рассылку</span>
                    </label>
                </div>

            </div>

            <div class="col _1_3">
                <div class="field">
                    <label>{$smarty.const.CUSTOMER_EMAIL}</label>
                    <input required="required" type="email" name="email" value="{$email}">
                </div>


                {section name=i loop=$additional_fields}
                    <div class="field">
                        <label>{$additional_fields[i].reg_field_name}</label>
                        <input {if $additional_fields[i].reg_field_required} required="required" {/if}type="text" name='additional_field_{$additional_fields[i].reg_field_ID}' value='{section name=j loop=$additional_field_values}{if $additional_field_values[j].reg_field_ID == $additional_fields[i].reg_field_ID}{$additional_field_values[j].reg_field_value}{/if}{/section}'/>
                    </div>
                {/section}
            </div>

            <div class="buttons">
                <button type="submit" name="save" value="1">{$smarty.const.SAVE_BUTTON}</button>
            </div>

        </form>


    </article>
{/strip}