{strip}

    {if $data}
        <div>
            <dl>
                <dt>Обработано:</dt>
                <dd><strong>Категорий:</strong> {$data.count_categories}</dd>
                <dd><strong>Товаров:</strong> {$data.count_offers}</dd>

                <dd><strong>Время обработки:</strong> {$data.exec_time}</dd>
            </dl>
            {*<form method="post" action="{$smarty.const.ADMIN_FILE}">*}
            {*<p>*}
            {*<input type="hidden" name="import" value="1"/> <input type="hidden" name="dpt" value="catalog"/>*}
            {*<input type="hidden" name="sub" value="yml_import"/>*}
            {*<button type="submit">Импортировать</button>*}
            {*</p>*}
            {*</form>*}
        </div>
    {else}
        <form name="form" id="form" enctype="multipart/form-data" method="post" action="{$smarty.const.ADMIN_FILE}">


            <table class="adn">

                <tr class="lineb">
                    <td align="center">{$smarty.const.ADMIN_ON2}</td>
                    <td align="left">&nbsp;</td>
                    <td align="left" width="90%">{$smarty.const.ADMIN_XML_SPECIFY_FILE}</td>
                </tr>

                <tr>
                    <td height="4" colspan="3"></td>
                </tr>

                <tr class="liney">

                    <td align="center">
                        <input type="radio" name="mode" value="0" checked="checked"/>
                    </td>
                    <td align="left" class="toph3">{$smarty.const.ADMIN_XML_UPDATE_DB}</td>
                    <td align="left">
                        <input type="file" class="file" name="xml"/>
                    </td>

                </tr>


                <tr class="liney">
                    <td align="center">
                        <input type="radio" name="mode" value="2"/>
                    </td>
                    <td colspan="2">{$smarty.const.ADMIN_XML_CLEAR_DB_DESC}</td>
                </tr>

                <tr>
                    <td height="4" colspan="3">

                        <input type="hidden" name=proceed value="1"/> <input type="hidden" name=dpt value="catalog"/>
                        <input type="hidden" name=sub value="xml_import"/>

                    </td>
                </tr>

            </table>


        </form>
        <table class="adn">
            <tr>
                <td class="separ"><img src="data/admin/pixel.gif" alt="" class="sep"></td>
            </tr>
            <tr>
                <td class="se5"></td>
            </tr>
        </table>
        <a href="#" onclick="document.getElementById('form').submit(); return false"
           class="inl">{$smarty.const.OK_BUTTON3}</a>
        <table class="adn">
            <tr>
                <td class="se6"></td>
            </tr>
        </table>
        <table class="adn">
            <tr>
                <td class="help"><span class="titlecol2">{$smarty.const.USEFUL_FOR_YOU}</span>

                    <div class="helptext">

                        <p>Импорт прайса xml</p>

                    </div>
                </td>
            </tr>
        </table>
        {if $yml_import_result eq "upload_file_error"}
            <script type="text/javascript" defer>alert('{$smarty.const.ERROR_FAILED_TO_UPLOAD_FILE}')</script>
        {/if}
        {if $yml_import_result eq "update_column_error"}
            <script type="text/javascript" defer>alert('{$smarty.const.ERROR_UPDATE_COLUMN_IS_NOT_SET}')</script>
        {/if}
    {/if}
{/strip}