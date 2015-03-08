{if $smarty.const.CONF_ENABLE_CONFIRMATION_CODE}
    <div class="field">
        <div>
        <img src="index.php?do=captcha&amp;{php}echo session_name();{/php}={php}echo session_id();{/php}" alt="code"/>
        </div>
        <input required="required" name="fConfirmationCode" placeholder="{$smarty.const.STR_ENTER_CCODE}" value=""/>
    </div>
{/if}