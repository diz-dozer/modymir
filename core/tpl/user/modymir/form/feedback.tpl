{strip}
    {if $sent}

        {include file='mod/message.tpl' type='success' txt=$smarty.const.FEEDBACK_SENT_SUCCESSFULLY}

    {else}
        <form method="post" action="/">

            {if $error}
                {if $error eq 2}
                    {include file='mod/message.tpl' txt=$smarty.const.ERR_WRONG_CCODE}
                {elseif $error eq 3}
                    {include file='mod/message.tpl' txt=$smarty.const.ERR_WRONG_POST}
                {else}
                    {include file='mod/message.tpl' txt=$smarty.const.FEEDBACK_ERROR_FILL_IN_FORM}
                {/if}
            {/if}


            <div class="field">
                <input placeholder="{$smarty.const.FEEDBACK_CUSTOMER_NAME}" required="required" type="text" maxlength="80" name="customer_name" value="{$customer_name}"/>
            </div>

            <div class="field">
                <input placeholder="{$smarty.const.CUSTOMER_EMAIL}" required="required" type="email" maxlength="80" name="customer_email" value="{$customer_email}"/>
            </div>

            {*<div class="field">*}
                {*<input placeholder="{$smarty.const.FEEDBACK_CUSTOMER_MESSAGE_SUBJ}" type="text" maxlength="200" name="message_subject" value="{$message_subject}"/>*}
            {*</div>*}

            <div class="field">
                <textarea placeholder="Как мы можем вам помочь?{*$smarty.const.FEEDBACK_CUSTOMER_MESSAGE_TEXT*}" name="message_text" required="required">{$message_text}</textarea>
            </div>


            {include file='mod/captcha.tpl'}


            <div class="buttons">

                <input type="hidden" name="message_subject" value="Обратная связь"/>
                <input type="hidden" name="feedback" value="yes"/>
                <button type="submit" name="send" value="yes">Отправить</button>
            </div>
        </form>
    {/if}
{/strip}