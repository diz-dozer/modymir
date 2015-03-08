{strip}
    <article class="page_cabinet">
        <header>

                <span class="rnav">
                    {if $isadmin}{include file='mod/link.tpl' link=$url.admin rel='nofollow' class='enter button'}{/if}
                    {include file='mod/link.tpl' link=$url.logout rel='nofollow' class='logout button'}
                </span>

            {*{include file='mod/header.tpl' header="Добро пожаловать (`$log`)"}*}
            {include file='mod/header.tpl' header="`$smarty.const.STRING_ACC_USER` (`$log`)"}

        </header>

        {include file='mod/menu_cabinet.tpl'}

        <div class="row">


            <section class="col _1_2">

                <header>
                    <h2 class="h4">{$smarty.const.STRING_CONTACT_INFORMATION_DOWN_CASE}</h2>
                </header>

                <table cellspacing="0" cellpadding="0">
                    <tr>
                        <td>{$smarty.const.CUSTOMER_FIRST_NAME}:&nbsp;</td>
                        <th>{$first_name}</th>
                    </tr>

                    <tr>
                        <td>{$smarty.const.CUSTOMER_LAST_NAME}:&nbsp;</td>
                        <th>{$last_name}</th>
                    </tr>

                    <tr>
                        <td>{$smarty.const.CUSTOMER_EMAIL}:&nbsp;</td>
                        <th>{$Email}</th>
                    </tr>

                    <tr>
                        <td>{$smarty.const.CUSTOMER_LOGIN}:&nbsp;</td>
                        <th>{$login}</th>
                    </tr>

                    {section name=i loop=$additional_field_values}
                        <tr>
                            <td>{$additional_field_values[i].reg_field_name}:&nbsp;</td>
                            <th>{$additional_field_values[i].reg_field_value}</th>
                        </tr>
                    {/section}


                    {if $custgroup_name}
                        {if $discount}
                            <tr>
                                <td>{$smarty.const.STRING_DISCOUNT}:&nbsp;</td>
                                <th{$discount}%</th>
                            </tr>
                        {/if}

                        {if $min_discount}
                            <tr>
                                <td>{$smarty.const.STRING_MIN_DISCOUNT}:&nbsp;</td>
                                <th>{$min_discount}%</th>
                            </tr>
                        {/if}
                    {/if}


                </table>

                <a href="/index.php?contact_info=yes" rel="nofollow">{$smarty.const.EDIT_BUTTON}</a>

            </section>


            <section class="col _1_2">

                <header>
                    <h2 class="h4">{$smarty.const.STRING_ADDRESS_BOOK}</h2>
                </header>


                {if $addressStr}
                    <div>
                        {$smarty.const.STRING_DEFAULT_ADDRESS}:<b>{$addressStr}</b>
                    </div>
                {/if}

                <div>
                    <a href="index.php?address_book=yes">{$smarty.const.STRING_ADDRESSES}</a>
                </div>
            </section>

        </div>

        <div class="row">

            <section class="col _1_2">

                <header>
                    <h2 class="h4">{$smarty.const.STRING_ORDER_HISTORY}</h2>
                </header>


                <table cellspacing="0" cellpadding="0">
                    {section name=i loop=$status_distribution}
                        <tr>
                            <td align="left">{if $status_distribution[i].count != 0}{$status_distribution[i].count} {$smarty.const.STRING_COUNT_ORDER_IN_STATUS}
                                    <b>'{$status_distribution[i].status_name}'</b>{/if}</td>
                        </tr>
                    {/section}
                </table>


                <div>
                    {include file='mod/link.tpl' link=$url.cabinet_orders rel='noffolow'}
                </div>

            </section>


            <section class="col _1_2">

                <header>
                    <h2 class="h4">{$smarty.const.STRING_VISIT_LOG}</h2>
                </header>


                <div>
                    {$visits_count} {$smarty.const.STRING_RECORDS}
                </div>

                <div>
                    {include file='mod/link.tpl' link=$url.cabinet_visits rel='noffolow'}
                </div>

            </section>
        </div>

        {if $smarty.const.CONF_AFFILIATE_PROGRAM_ENABLED}
            <section>

                <header>
                    <h2 class="h4">{$smarty.const.STRING_AFFILIATE_PROGRAM}</h2>
                </header>


                {if $affiliate_customers}
                    {include file='mod/message.tpl' txt="`$smarty.const.STRING_AFFILIATE_CUSTOMERS`: <b>`$affiliate_customers`</b>"}
                {else}
                    {include file='mod/message.tpl' txt=$smarty.const.STRING_AFFILIATE_NO_CUSTOMERS}
                {/if}

                <div>
                    {include file='mod/link.tpl' link=$url.affiliate_balance rel='noffolow'}
                </div>

            </section>
        {/if}

    </article>
{/strip}