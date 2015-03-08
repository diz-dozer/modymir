{strip}
    <div id="ajxOneClick" class="w_ajx_form">

        <form id="ajxOneClickForm" class="ajx_form" method="post" action="">

            <fieldset>


                <div class="tit">Купить быстро в 1 клик!</div>



                <div class="row">
                    {include file='product/product_info.tpl' product=$product_info}


                </div>


                <div class="row">
                    <input class="placeholder input"  title="Ваше имя..." type="text" name="name" value=""  />
                </div>

                <div class="row">
                    <input class="placeholder input"  title="* Контактный телефон..." type="text" name="phone" value=""  />
                </div>

                <div class="row hint">
                    * Поля обязательны для заполнения
                </div>

                <div class="row battons">
                    <input type="hidden" name="g" value="oneclick" />
                    <input type="hidden" name="productID" value="{$product_info.productID}" />
                    <input type="hidden" name="referrer" value="{$smarty.server.REQUEST_URI}" />
                    <button class="_btn _red" type="submit">Купить</button>

                </div>

            </fieldset>
        </form>
    </div>
{/strip}