{strip}
    {if $product}


        {if $isadmin}
            {assign var=admin_url value="`$smarty.const.ADMIN_FILE`?productID=`$product.productID`&amp;eaction=prod"}
            {assign var=admin_tit value="`$smarty.const.STRING_EDITPR`"}
            {assign var=a_lnk value="<a class='a_lnk' href='`$admin_url`' title='`$admin_tit`'>+</a>"}
        {/if}

        {if $smarty.const.CONF_MOD_REWRITE}
            {assign var=url value="/product_`$product.productID`.html"}
        {else}
            {assign var=url value="/index.php?productID=`$product.productID`"}
        {/if}
        <div class="product _look">


            <section class="product_picture">
                {include file='offer/picture.tpl' offer=$product mode='look'}
            </section>


            <section class="product_info">

                <div class="wrap">

                    <form class="offer-form" action="#" method="post" {$product.data}>

                        <div class="row">


                            <header>

                                {$a_lnk}


                                <h1 class="name">
                                    {*<div class="category">{$selected_category.name}</div>*}
                                    <div class="type">{$product.name}</div>
                                </h1>

                                {if $product.product_code}
                                    <div class="code">Код товара: {$product.product_code}</div>
                                {/if}


                            </header>


                        </div>



                        {if $product.variants_count}
                            <div class="row">
                                {include file='offer/variants.tpl' offer=$product}
                            </div>
                        {/if}

                        <div class="row">


                            <div class="price">{$product.PriceWithUnit}</div>
                            {if $product.profit}
                                <del class="old-price">{$product.list_priceWithUnit}</del>
                            {/if}


                            <div class="buttons">
                                <div class="col _1_2">
                                    {include file='offer/to_cart.tpl' offer=$product}
                                </div>

                                <div class="col _1_2">
                                    <a class="button _dark" href="{$url}">Подробнее о товаре</a>
                                </div>
                            </div>

                        </div>


                        <div class="row _ft">
                            Бесплатная доставка по москве при покупке от 3х позиций
                        </div>

                        <div class="row _ft">
                            Напиши отзыв и получи скидку 100 рублей!
                        </div>

                        <div class="row _badges">
                            <ul class="badges">
                                <li>Доставка по всей России</li>
                                <li>Удобная форма оплаты</li>
                            </ul>
                        </div>

                    </form>
                </div>

                {*{if $product.description}*}
                {*<div class="description wrap">*}
                {*<div class="row">*}
                {*<h2 class="tit">Описание товара</h2>*}

                {*<p>*}
                {*{$product.description|strip_tags|trim}*}
                {*</p>*}
                {*</div>*}
                {*</div>*}
                {*{/if}*}


            </section>


        </div>
    {/if}
{/strip}