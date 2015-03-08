{strip}
    <header id="header">
        <div class="container">
            <dl class="company">

                <dt class="logo">

                    {if $pageID eq 'home'}
                        {$site.name}
                    {else}
                        <a href="/" rel="home">{$site.name}</a>
                    {/if}

                <div class="slogan">{$site.slogan}</div>

                </dt>

                <dd><a class="phone" href="tel:{$site.phone_num}">{$site.phone}</a></dd>
                <dd><a class="phone" href="tel:{$site.phone_num2}">{$site.phone2}</a></dd>

                {if $log}
                    <dd>{include file='mod/link.tpl' link=$url.user_details rel='nofollow' class='enter'}</dd>
                {else}
                    <dd>{include file='mod/link.tpl' link=$url.login rel='nofollow' lbl='Вход' class='enter'}</dd>
                {/if}

                <dd>
                    <a href="#" rel="nofollow" class="help" data-tools="modal" data-content="/index.php?do=page&amp;id=help">Помощь</a>
                </dd>
                <dd>


                    {if $pageID eq 'shopping_cart'}
                        <div class="basket{if $sc.qty  < 1} empty{/if}" title="{$sc.title}">
                            <span class="amount">{if $sc.qty > 99}&infin;{else}{$sc.qty}{/if}</span></div>
                    {else}
                        <a rel="nofollow" class="basket{if $sc.qty < 1} empty{/if}" href="/cart.html" title="{$sc.title}"><span class="amount">{if $sc.qty > 99}&infin;{else}{$sc.qty}{/if}</span></a>
                    {/if}

                </dd>
            </dl>
        </div>
    </HEADER>
{/strip}
