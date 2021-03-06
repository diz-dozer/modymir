{strip}
{if $smarty.const.CONF_PRODUCT_MAIL eq 1} <a name="inquiry"></a> {include file="header.tpl" header=$smarty.const.STRING_FEEDBACK_PRODUCT_HEADER}
<table cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="cbt" align="left">{$smarty.const.STRING_FEEDBACK_PRODUCT_DESCRIPTION}</td>
    </tr>
</table>
{if $sent eq NULL}
<table cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="hdbtop" align="left" valign="top"> {if $error ne NULL}
            <table cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td class="error cattop" align="center">{if $error eq 7}{$smarty.const.ERR_WRONG_CCODE}{else}{$smarty.const.FEEDBACK_ERROR_FILL_IN_FORM}{/if}</td>
                </tr>
            </table>
            {/if}
            <form name="form1post" id="form1post" method="post" action="index.php#inquiry">
                <table cellspacing="0" cellpadding="0" align="left">
                    <tr>
                        <td align="left">{$smarty.const.FEEDBACK_CUSTOMER_NAME}</td>
                    </tr>
                    <tr>
                        <td style="height: 2px;"></td>
                    </tr>
                    <tr>
                        <td align="left"><input name="customer_name" type="text" style="width: 220px;" value="{$customer_name|replace:"\"":"&quot;"}"></td>
                    </tr>
                    <tr>
                        <td style="height: 6px;"></td>
                    </tr>
                    <tr>
                        <td align="left">{$smarty.const.CUSTOMER_EMAIL}</td>
                    </tr>
                    <tr>
                        <td style="height: 2px;"></td>
                    </tr>
                    <tr>
                        <td align="left"><input name="customer_email" type="text" style="width: 220px;" value="{$customer_email|replace:"\"":"&quot;"}"></td>
                    </tr>
                    <tr>
                        <td style="height: 6px;"></td>
                    </tr>
                    <tr>
                        <td align="left">{$smarty.const.STRING_FEEDBACK_PRODUCT_INQUIRY_EXPLANATION}</td>
                    </tr>
                    <tr>
                        <td style="height: 2px;"></td>
                    </tr>
                    <tr>
                        <td align="left"><input name="message_subject" type="hidden" value="{$product_info.name|replace:"\"":"&quot;"}">
                            <textarea name="message_text" style="width: 360px; height: 100px;">{$message_text|replace:"<":"&lt;"}</textarea>
                            <input type="hidden" name="request_information" value="yes">
                            <input type="hidden" name="productID" value="{$product_info.productID}"></td>
                    </tr>
                    {if $smarty.const.CONF_ENABLE_CONFIRMATION_CODE eq 1}
                    <tr>
                        <td style="height: 6px;"></td>
                    </tr>
                    <tr>
                        <td align="left"><img src="index.php?do=captcha&amp;{php}echo session_name();{/php}={php}echo session_id();{/php}" alt="code"></td>
                    </tr>
                    <tr>
                        <td style="height: 2px;"></td>
                    </tr>
                    <tr>
                        <td align="left"><input name="fConfirmationCode" value="{$smarty.const.STR_ENTER_CCODE}" type="text" style="width: 220px; color: #aaaaaa;" onfocus="if(this.value=='{$smarty.const.STR_ENTER_CCODE}')
                      {literal}
                      {this.style.color='#000000';this.value='';}
                      {/literal}" onblur="if(this.value=='')
                      {literal}{{/literal}this.style.color='#aaaaaa';this.value='{$smarty.const.STR_ENTER_CCODE}'{literal}}{/literal}"></td>
                    </tr>
                    {/if}
                </table>
            </form></td>
    </tr>
</table>
<div class="fil"></div>
<table cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="hdbot"><a href="#" onclick="document.getElementById('form1post').submit(); return false">{$smarty.const.OK_BUTTON3}</a></td>
    </tr>
</table>
{else}
<table cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="oki cattop" align="center">{$smarty.const.FEEDBACK_SENT_SUCCESSFULLY}</td>
    </tr>
</table>
<table cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="hdbot">&nbsp;</td>
    </tr>
</table>
{/if}
{/if}
{/strip}