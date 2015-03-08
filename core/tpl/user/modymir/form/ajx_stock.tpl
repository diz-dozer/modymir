{strip}

<div id="ajxStock" class="w_ajx_form">


    <form id="ajxStockForm" class="ajx_form" method="post" action="/index.php?do=ajax">



        <fieldset>

            <div class="tit">Оповестить о наличие другого размера</div>


            <div class="row">
                {include file="widget/product_info.tpl"}
            </div>




            <div class="row">
                <input class="placeholder input"  title="* E-mail ..." type="text" name="mail" value=""  />
            </div>


            <div class="row hint">
                * Поля обязательны для заполнения
            </div>

            <div class="row battons">

                <input type="hidden" name="g" value="stock" />
                <input type="hidden" name="productID" value="{$product_info.productID}" />
                <input type="hidden" name="referrer" value="{$smarty.server.REQUEST_URI}" />

                <button class="_btn _red" type="submit">Сообщить о поступлении</button>
            </div>

        </fieldset>
    </form>

</div>


{/strip}