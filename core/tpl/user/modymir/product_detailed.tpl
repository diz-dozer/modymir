{strip}

    {if $product}
        <article class="product">


            <div class="product_picture">
                {include file='offer/picture.tpl' offer=$product}
                {include file='offer/thumbs.tpl' offer=$product}
            </div>


            <div class="product_info">

                <div class="wrap">

                    <form class="offer-form" action="#" method="post" {$product.data}>

                        <div class="row">
                            <header>
                                {include file='mod/admin_link.tpl' href="?productID=`$product.productID`&amp;eaction=prod"}
                                <h1 class="name">
                                    {*<div class="category">{$selected_category.name}</div>*}
                                    <span class="type">{$product.name}</span>
                                </h1>

                                {if $smarty.const.CONF_DISPLAY_PRCODE && $product.product_code}
                                    <div class="code">Код товара: {$product.product_code}</div>
                                {/if}

                            </header>

                        </div>



                        {if $product.variants_count}
                            <div class="row">

                                {include file='offer/variants.tpl' offer=$product}
                                {*{include file='offer/extra.tpl' offer=$product wide=1}*}

                                {*<dl>*}
                                {*<dt>{$product.param.brand.label}</dt>*}
                                {*<dd>{$product.param.brand.value}</dd>*}
                                {*<dt>{$product.param.color.label}</dt>*}
                                {*<dd>{$product.param.color.value}</dd>*}
                                {*<dt>{$product.param.size.label}</dt>*}
                                {*<dd>{$product.param.size.value}</dd>*}
                                {*</dl>*}

                            </div>
                        {/if}

                        <div class="row">


                            <div class="price">{$product.PriceWithUnit}</div>
                            {if $product.profit}
                                <del class="old-price">{$product.list_priceWithUnit}</del>
                            {/if}


                            <div class="buttons">
                                {include file='offer/to_cart.tpl' offer=$product}
                            </div>

                        </div>


                        <div class="row _ft">
                            Бесплатная доставка по Москве при покупке от 3х позиций
                        </div>

                        <div class="row _ft">
                            Напиши <a href="#comments">комментарий</a> и получи скидку 100 рублей!
                        </div>
                        <div class="row _badges">
                            <ul class="badges">
                                <li>Доставка по всей России</li>
                                <li>Удобная форма оплаты</li>
                            </ul>
                        </div>

                    </form>
                </div>

                {if $product.description}
                    <div class="description wrap">
                        <div class="row">
                            <h2 class="tit">Описание товара</h2>

                            <p>
                                {$product.description|strip_tags|trim}
                            </p>
                        </div>
                    </div>
                {/if}


            </div>


        </article>
    {/if}



    <div id="comments"></div>




{/strip}

{*{assign var=offers_name value='Рекомендации'}*}
{*include file="product/offers.tpl" tit=$offers_name offers=$special_offers*}
{*{include file="mod/offers.tpl" tit=$offers_name offers=$n_offers eff='сarousel'  id='stock'}*}
{*{include file="mod/offers.tpl" tit='С этим товаром часто покупают' offers=$related}*}
{*{include file='widget/social.tpl' id="ysOffer"}*}