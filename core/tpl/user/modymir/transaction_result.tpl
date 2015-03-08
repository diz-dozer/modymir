{strip}
    <article class="_tc">

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_TRANSACTRESULT}
        </header>


        {if $TransactionResult eq 'success'}
            {$smarty.const.STRING_TRANSACTION_RESULT_SUCCESS}
        {elseif  $TransactionResult eq 'failure'}
            {$smarty.const.STRING_TRANSACTION_RESULT_FAILURE}
        {/if}


        {if $log  && $orderID}
            <div class="buttons">
                {$smarty.const.STRING_TRANSACTRESULT_REDIRECT}
                <a classs="button" href="index.php?p_order_detailed={$orderID}">{$smarty.const.STRING_TRANSACTRESULT_GO}</a>
            </div>
        {/if}


    </article>
{/strip}