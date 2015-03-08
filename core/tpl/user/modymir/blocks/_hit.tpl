{strip}

    {assign var=offers_name value="Выгодная цена"}

    {*include file="product/offers.tpl" tit=$offers_name offers=$special_offers*}


    {include file="mod/offers.tpl" tit=$offers_name offers=$s_offers eff='сarousel' id='hit'}

{/strip}