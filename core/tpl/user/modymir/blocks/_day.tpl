{strip}

{assign var=offers_name value="Товар дня"}

{*include file="product/offers.tpl" tit=$offers_name offers=$special_offers*}

{include file="mod/offers.tpl" tit=$offers_name offers=$t_offers eff='сarousel' id='day' vs=1}
{/strip}