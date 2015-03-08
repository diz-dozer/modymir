{strip}
    <article>

        {if $pages}
            <div class="page_help">
                <div class="row">

                    {*{foreach from=$pages item=page}*}
                    {*<div class="col _1_3">*}
                    {*<header>*}
                    {*<h2 class="tit">{$page.name}</h2>*}
                    {*</header>*}
                    {*<div class="content">{$page.body}</div>*}
                    {*</div>*}
                    {*{/foreach}*}


                    <div class="col _1_3">
                        <h2 class="tit">Как заказать?</h2>
                        <ol>
                            <li>Выбрать интересующую вас модель</li>
                            <li>Добавить в корзину</li>
                            <li>Оформить заказ</li>
                            <li>После оформление МЫ свяжемся с Вами и уточним детали</li>
                        </ol>
                    </div>
                    <div class="col _1_3">
                        <h2 class="tit">Как оплатить?</h2>

                        <ol>
                            <li>Наличными, курьеру при получении заказа</li>
                            <li>Банковской картой, например при доставке заказа Почтой России</li>
                        </ol>
                    </div>

                    <div class="col _1_3">
                            <h2 class="tit">Как получить?</h2>
                            <ol>
                                <li>Доставка по Москве от <b>300 руб</b></li>
                                <li>Отправка почтой России, стоимость - зависит от региона</li>
                                <li>При покупке на сумму более 8000 руб, <b>доставка по Москве - бесплатно</b></li>
                            </ol>
                    </div>



                </div>
                <div class="row buttons">
                    <div class="col _1_3">
                        <a class="button" href="{$url.how.url}">Узнать больше</a>
                    </div>
                    <div class="col _1_3">
                        <a class="button" href="{$url.payment.url}">Узнать больше</a>
                    </div>
                    <div class="col _1_3">
                        <a class="button" href="{$url.delivery.url}">Узнать больше</a>
                    </div>
                </div>
            </div>
        {else}
            <header>
                <h1>{$page.name}</h1>
            </header>
            <div class="content">{$page.body}</div>
        {/if}

    </article>
{/strip}