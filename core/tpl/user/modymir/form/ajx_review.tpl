{strip}

<div id="ajxReview" class="w_ajx_form">


    <form id="ajxReviewForm" class="ajx_form" method="post" action="/index.php?mail=review">

        <fieldset>

            <div class="tit">Оставить отзыв</div>


            <div class="row">
                <input class="placeholder input"  title="* Ваше Имя ..." type="text" name="name" value=""  />
            </div>

            <div class="row">
                <input class="placeholder input"  title="* Фамилия ..." type="text" name="lastname" value=""  />
            </div>

            <div class="row">
                <input class="placeholder input"  title="Контактный телефон ..." type="text" name="phone" value="" />
            </div>
            <div class="row">
                <input class="placeholder input"  title="* E-mail ..." type="text" name="mail" value=""  />
            </div>


            <div class="row">
                <textarea class="placeholder textarea"  title="* Ваш отзыв ..." name="review" cols="40" rows="3"></textarea>
            </div>


            <input type="hidden" name="g" value="review" />

            <div class="row hint">
                * Поля обязательны для заполнения
            </div>

            <div class="row battons">
                <button class="_btn _red" type="submit">Отправить</button>
            </div>

        </fieldset>
    </form>

</div>


{/strip}