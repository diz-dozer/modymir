{strip}

{if $log}

<form id="DiscussForm" method="post" action="">
    
    {* {if $error ne NULL}
    <div class="error">Комментарий пуст</div>
    {/if}
    *}
    <fieldset>



        <div class="textarea-wrap">
            <textarea id="discuss-body" class="placeholder" title="{$smarty.const.DISCUSSION_BODY}"  name="body" rows="4" cols="30">{$dis_text}</textarea>
            <input type="hidden" name="topic" value="" />
            <input type="hidden" name="add_topic" value="yes" />
            <input type="hidden" name="productID" value="{$productID}" />
            <input type="hidden" name="nick" value="{$log_name}" />
        </div>


        <button type="submit" class="button" name="discuss" value="yes">{$smarty.const.POST_COMMENT_BUTTON}</button>
    </fieldset>
</form>

{/if}


{/strip}
