{strip}

<div id="ajxWantGift" class="w_ajx_form">

    <form id="ajxWantGiftForm" class="ajx_form"  method="post" action="">

        <fieldset>

            <div class="tit">Хочу в подарок</div>


            <div class="row">
                {include file="widget/product_info.tpl"}
            </div>

            <div class="row">
                <input class="placeholder input"  title="* Имя дарителя..." type="text" name="nameTo" value=""  />
            </div>

            <div class="row">
                <input class="placeholder input _email"  title="* Его e-mail..." type="text" name="emailTo" value=""  />
            </div>


            <div class="row">
                <textarea class="placeholder textarea"  title="Сообщение ..." name="message" cols="40" rows="3"></textarea>
            </div>


            <div class="row">
                <input class="placeholder input"  title="* Ваше имя..." type="text" name="nameFrom" value=""  />
            </div>

            <div class="row">
                <input class="placeholder input _email"  title="* Ваш email..." type="text" name="emailFrom" value=""  />
            </div>




            <div class="row hint">
                * Поля обязательны для заполнения
            </div>

            <div class="row battons">
                <input type="hidden" name="g" value="gift" />
                <input type="hidden" name="productID" value="{$product_info.productID}" />
                <button class="_btn _red" type="submit">Намекнуть</button>
            </div>

        </fieldset>
    </form>

</div>

{/strip}
