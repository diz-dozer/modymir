{strip}

    {if $p_offers || $s_offers || $n_offers}
        <div class="tabs spec_tabs">

            <div class="tabs_nav_wrap">
                <ul class="tabs_nav">

                    {if $p_offers}
                        <li>
                            <a href="#tab_1">Подарки к празднику</a>
                        </li>
                    {/if}
                    {if $s_offers}
                        <li>
                            <a href="#tab_2">Специальные предложения</a>
                        </li>
                    {/if}
                    {if $n_offers}
                        <li>
                            <a href="#tab_3">Новинки каталога</a>
                        </li>
                    {/if}

                </ul>
            </div>


            {if $p_offers}
                <div id="tab_1" class="tab">
                    <div class="offers">
                        {section name=i loop=$p_offers}
                            {include file='mod/offer.tpl' offer=$p_offers[i]}
                        {/section}
                    </div>

                </div>
            {/if}


            {if $s_offers}
                <div id="tab_2" class="tab">
                    <div class="offers">
                        {section name=i loop=$s_offers}
                            {include file='mod/offer.tpl' offer=$s_offers[i]}
                        {/section}
                    </div>
                </div>
            {/if}

            {if $n_offers}
                <div id="tab_3" class="tab">
                    <div class="offers">
                        {section name=i loop=$n_offers}
                            {include file='mod/offer.tpl' offer=$n_offers[i]}
                        {/section}
                    </div>
                </div>
            {/if}
        </div>
    {/if}

{/strip}