{strip}

    {if $add_new_address}
        {assign var=action value='/index.php?add_new_address=yes'}
    {elseif $address_editor}
        {assign var=action value="/index.php?address_editor=`$address_editor`"}
    {/if}
    <article>

        <a href="/index.php?address_book=yes">{$smarty.const.STRING_GO_TO_ADDRESS_LIST}</a>

        <header>
            {include file='mod/header.tpl' header=$smarty.const.STRING_ADDRESS_BOOK}
        </header>


        <form action="{$action}" method="post">

            {if $error}
                {include file='mod/message.tpl' txt=$error}
            {else}
                {*{include file='mod/message.tpl' type='info' txt=$smarty.const.STRING_REQUIRED}*}
            {/if}

            {if $zones && $select_zone_statement ne NULL}
                {include file='mod/message.tpl' txt=$select_zone_statement}
            {/if}

            <div class="row">

                <div class="col _1_3">

                    <div class="field">
                        <label>{$smarty.const.CUSTOMER_FIRST_NAME}</label>
                        <input required="required" type="text" name="first_name" value='{$first_name}'/>
                    </div>


                    <div class="field">
                        <label>{$smarty.const.CUSTOMER_LAST_NAME}</label>
                        <input required="required" type="text" name="last_name" value='{$last_name}'/>
                    </div>

                </div>

                <div class="col _1_3">
                    {if $smarty.const.CONF_ADDRESSFORM_ADDRESS ne 2}
                        <div class="field">
                            <label>
                                {if $smarty.const.CONF_ADDRESSFORM_ADDRESS eq 0}

                                {/if}
                                {$smarty.const.CUSTOMER_ADDRESS}
                            </label>
                            <textarea name="address">{$address}</textarea>
                        </div>
                    {else}
                        <input type="hidden" name="address" value=""/>
                    {/if}


                    {if $smarty.const.CONF_ADDRESSFORM_CITY ne 2}
                        <div class="field">
                            <label>{if $smarty.const.CONF_ADDRESSFORM_CITY eq 0}

                                {/if}{$smarty.const.CUSTOMER_CITY}</label>
                            <input type="text" name="city" value='{$city}'/>
                        </div>
                    {else}
                        <input type="hidden" name="city" value=""/>
                    {/if}

                    {if $smarty.const.CONF_ADDRESSFORM_STATE ne 2}
                        <div class="field">
                            <label>{if $smarty.const.CONF_ADDRESSFORM_STATE eq 0}

                                {/if}
                                {$smarty.const.CUSTOMER_STATE}
                            </label>

                            {if $zones}
                                <select name="zoneID">
                                    {section name=i loop=$zones}
                                        <option {if $zones[i].zoneID == $zoneID}selected="selected"{/if} value="{$zones[i].zoneID}">{$zones[i].zone_name}</option>
                                    {/section}
                                </select>
                            {else}
                                <input type=text value="{$state}" name="state"/>
                            {/if}
                        </div>
                    {else}

                        {if $zones}
                            <input type="hidden" name="zoneID" value="0"/>
                        {else}
                            <input type="hidden" name="state" value=""/>
                        {/if}

                    {/if}

                    {if $countries}
                        <div class="field">

                            <label> {$smarty.const.CUSTOMER_COUNTRY}</label>
                            <select name="countryID" onchange="changeCountryHandler();">

                                {section name=i loop=$countries}

                                    {assign var=selected value=false}

                                    {if $countryID ne NULL}
                                        {if $countryID == $countries[i].countryID}
                                            {assign var=selected value='selected="selected"'}
                                        {/if}
                                    {else}
                                        {if $smarty.const.CONF_DEFAULT_COUNTRY == $countries[i].countryID}
                                            {assign var=selected value='selected="selected"'}
                                        {/if}
                                    {/if}
                                    <option value="{$countries[i].countryID}"{$selected}>{$countries[i].country_name}</option>
                                {/section}

                            </select>
                        </div>
                    {else}
                        <input type="hidden" name="countryID" value="NULL"/>
                    {/if}
                </div>

            </div>

            <div class="buttons">
                <button type="submit" name="save" value="save">{$smarty.const.SAVE_BUTTON}</button>
            </div>

        </form>

    </article>
{/strip}