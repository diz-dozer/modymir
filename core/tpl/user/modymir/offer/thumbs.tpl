{strip}
    {if $offer.thumbs}
        <ul class="thumbs">
            {section name=i loop=$offer.thumbs}
                <li class="thumb">
                    {slir w=80 h=90 b=1000 offer=$offer t=$smarty.section.i.index}
                </li>
            {/section}
        </ul>
    {/if}
{/strip}
