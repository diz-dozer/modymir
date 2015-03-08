{strip}

    {if $offer && $all_product_pictures}

        {assign var=b_img value='/img/w1000/'}
        {assign var=x_img value='/img/w60-h60-c1x1/'}
        <ul class="thumbs">
            {section name=i loop=$all_product_pictures}
                <li class="thumb">
                    <a href="{$b_img}data/small/{$all_product_pictures[i].filename}">
                        <img src="{$x_img}data/small/{$all_product_pictures[i].filename}" alt="{$offer.name}"/>
                    </a>
                </li>
            {/section}
        </ul>
    {/if}
{/strip}
