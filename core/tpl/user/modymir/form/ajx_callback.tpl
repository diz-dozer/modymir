{strip}

<div id="ajxCallBack" class="w_ajx_form">


    <form id="ajxCallBackForm" class="ajx_form" method="post" action="#">

        <fieldset>

            <div class="tit">Заказать обратный звонок</div>


            <div class="row">
                <input class="placeholder input"  title="Ваше имя..." type="text" name="name" value=""  />
            </div>

            <div class="row">
                <input class="placeholder input"  title="* Ваш контактный телефон ..." type="text" name="phone" value="" />
            </div>


            <input type="hidden" name="callback" value="callback" />
            <input type="hidden" name="g" value="callback" />
            <input type="hidden" name="sloop" value="callback" />

            <div class="row hint">
                * Поля обязательны для заполнения
            </div>

            <div class="row battons">
                <button class="_btn _red" type="submit">Заказать звонок</button>
            </div>

        </fieldset>
    </form>

</div>


{/strip}