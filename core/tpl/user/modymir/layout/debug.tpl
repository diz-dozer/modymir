{strip}
    <div id="debug">
    <table class="w_debug" cellspacing="0" cellpadding="0">
        <tr>
            <td class="first">{$smarty.const.STRING_EXE_DATA}:&nbsp;<span id="tgenexe">{$smarty.session.tgenexe}</span>&nbsp;{$smarty.const.TIME_SEK}</td>
            <td>{$smarty.const.STRING_PREEXE_DATA}:&nbsp;<span id="tgencompile">{$smarty.session.tgencompile}</span>&nbsp;{$smarty.const.TIME_SEK}</td>
            <td>{$smarty.const.BD_DO_TIME}:&nbsp;<span id="tgendb">{$smarty.session.tgendb}</span>&nbsp;{$smarty.const.TIME_SEK}</td>
            <td>{$smarty.const.STRING_ALL_EXETIME}:&nbsp;<span id="tgenall">{$smarty.session.tgenall}</span>&nbsp;{$smarty.const.TIME_SEK}</td>
            <td class="last">{$smarty.const.STRING_DO_COUNT}:&nbsp;<span id="tgensql">{$smarty.session.tgensql}</span></td>
        </tr>
    </table>
    </div>
{/strip}
