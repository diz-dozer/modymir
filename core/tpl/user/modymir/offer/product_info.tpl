{strip}

    {if $product}

        <div class="product_info">



            {if $product.picture}
                <div class="pic">
                    <img  class="img" src="/img/w80-h80/data/small/{$product.picture}" alt="{$product.name}"  />
                </div>
            {else}
                <div class="pic">
                    <img class="img" src="/img/w80-h80/data/test_b.jpg" alt="{$product.name}"  />
                </div>
            {/if}


            <div class="name_wrap">

                <div class="name">{$product.name}</div>


                {if $product.Price > 0}
                    <div class="price_line">
                        {if $product.list_price > $product.Price}


                            {math assign=profit equation="((x-y) / x ) * 100" x= $product.list_price y=$product.Price}

                            <div class="old_price_wrap">
                                <del class="old_price">{$product.list_price}{*<small>руб.</small>*}</del>&nbsp;
                                <span class="profit">-{$profit|string_format:'%d'}%</span>
                            </div>

                        {/if}
                        <div class="price">{$product.PriceWithUnit}</div>
                    </div>


                {/if}

                <br/>
                <div class="hint">
                    Мы заботимся  о вас, поэтому вы можете заказать быстро, просто отправив свое имя и телефон. Мы сами перезвоним вам и совершим заказ.
                </div>

            </div>


        </div>
    {/if}
{/strip}