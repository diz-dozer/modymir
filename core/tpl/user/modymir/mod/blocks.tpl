{strip}


    {section name=b loop=$binfo}


        {if $isadmin}
            {assign var=admin_url value="`$smarty.const.ADMIN_FILE`?dpt=conf&amp;sub=blocks_edit&amp;edit=`$binfo[b].bid`"}
            {assign var=admin_tit value="`$smarty.const.EDIT_BUTTON`"}
            {assign var=a_lnk value="<a class='a_lnk' href='`$admin_url`' title='`$admin_tit`'>+</a>"}
        {/if}

        {if $binfo[b].html}
            {assign var=modd value=$binfo[b].url|replace:'.tpl':''}
        {/if}


        <div class="block _{$modd}">

            {*$a_lnk*}

            {if $binfo[b].html}
                {include file="blocks/`$binfo[b].url`"}
            {else}
                {$binfo[b].content}
            {/if}


        </div>
    {/section}



{/strip}