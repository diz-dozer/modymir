{strip}
    <article>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_ADDRESS_BOOK}
        </header>

        {include file='mod/menu_cabinet.tpl'}

        <form action="index.php?address_book=yes" method="post">


            {if $addresses}
                <table cellspacing="0" cellpadding="0" width="100%">

                    <thead>
                    <tr>
                        <th nowrap="nowrap">{$smarty.const.STRING_DEFAULT}</th>
                        <th>{$smarty.const.STRING_SHIPPING_ADDRESS}</th>
                        <th>{$smarty.const.STRING_DO_BLOCK}</th>
                    </tr>
                    </thead>

                    <tbody>

                    {section name=i loop=$addresses}
                        <tr>
                            <td>
                                <input type="radio" name="DefaultAddress" {if $defaultAddressID == $addresses[i].addressID} checked="checked"{/if} value="{$addresses[i].addressID}"/>
                            </td>

                            <td>{$addresses[i].addressStr}</td>

                            <td>
                                <ul>
                                    <li>
                                        <a href="index.php?address_editor={$addresses[i].addressID}">{$smarty.const.EDIT_BUTTON}</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="confirmDelete({$addresses[i].addressID},'{$smarty.const.QUESTION_DELETE_CONFIRMATION}','index.php?address_book=yes&amp;delete=');">{$smarty.const.DELETE_BUTTON}</a>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    {/section}

                    </tbody>
                </table>
            {else}

                {include file='mod/message.tpl' txt=$smarty.const.STRING_EMPTY_LIST}

            {/if}


            <div class="buttons">


                {if $addresses|@count > 0}
                    <button type="submit" value="submit" name="save"/>{$smarty.const.SAVE_BUTTON}</button>
                    &nbsp;&nbsp;&nbsp;
                {/if}
                <a class="button" href="index.php?add_new_address=yes">{$smarty.const.STRING_ADD_NEW_ADDRESS}</a>
            </div>

        </form>
    </article>
{/strip}