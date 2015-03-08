{strip}

<div id="ajxFeedBack" class="w_ajx_form">


    <form id="ajxFeedBackForm" class="ajx_form" method="post" action="/index.php?mail=review">

        <fieldset>

            <div class="tit">Форма обратной связи</div>


            <div class="row">
                <input class="placeholder input"  title="Ваше имя..." type="text" name="name" value=""  />
            </div>

            {*
            <div class="row">
                <input class="placeholder input"  title="Ваш контактный телефон ..." type="text" name="phone" value="" />
            </div>
            *}

            <div class="row">
                <input class="placeholder input _email"  title="* Ваш e-mail ..." type="text" name="email" value="" />
            </div>


            <div class="row">
                <textarea class="placeholder textarea"  title="* Ваш вопрос ..." name="message" cols="40" rows="3"></textarea>
            </div>


            <div class="row hint">
                * Поля обязательны для заполнения
            </div>

            <div class="row battons">

                <input type="hidden" name="g" value="feedback" />
                <input type="hidden" name="referrer" value="{$smarty.server.REQUEST_URI}" />
                <button class="_btn _red" type="submit">Отправить</button>

            </div>

        </fieldset>
    </form>

</div>


{/strip}