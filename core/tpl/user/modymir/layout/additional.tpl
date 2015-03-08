{strip}
    <aside id="additional">

        <div class="container">



            <dl class="col">
                <dt>О магазине</dt>
                {include file='mod/menu.tpl' menu=$menu.company tag='dd'}
            </dl>


            <dl class="col">
                <dt>Покупателю</dt>
                {include file='mod/menu.tpl' menu=$menu.client tag='dd'}
            </dl>


            <div class="col">

                <dl class="schedule">
                    <dt>Режим работы:</dt>
                    <dd>(пн.-пт.) с 10.00 до 19.00</dd>
                    <dd>(суббота) с 11.00 до 17.00</dd>
                </dl>
                <dl class="pickup">
                    <dt>Адрес для самовывоза:</dt>
                    <dd>Волгоградский пр-т дом 32 стр 8</dd>
                </dl>
            </div>


            <div class="col _follow">
                {include file='widget/follow.tpl' mode=' _vert'}
            </div>


            <dl class="col _contacts">
                <dt class="hidden">Контакты</dt>
                <dd><a class="phone" href="tel:{$site.phone_num}">{$site.phone}</a></dd>
                <dd><a class="phone" href="tel:{$site.phone_num2}">{$site.phone2}</a></dd>
                <dd>

                    <a href="#" rel="nofollow" class="help" data-tools="modal" data-cn="_fn" data-title="Обратный звонок" data-content="/index.php?do=ajax&amp;g=callback">Заказать обратный звонок</a>

                </dd>
                <dd><a href="mailto:{$site.email}">{$site.email}</a></dd>
            </dl>

        </div>


    </aside>
{/strip}



