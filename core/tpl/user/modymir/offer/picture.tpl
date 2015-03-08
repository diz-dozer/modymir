{strip}


    {if $offer}
        <div class="picture{if $offer.thumbs} with_thumbs{/if}">
            {*<div class="picture">*}
            {*{assign var=w value=450}*}
            {*{assign var=h value=450}*}

            {assign var=w value=280}
            {assign var=h value=400}


            {*{if $mode == 'look' || $offer.picture.empty}*}
            {if $offer.picture.empty}
                <div class="wrap-img">
                    {slir w=$w h=$h offer=$offer}
                </div>
            {else}

                {*{if $offer.thumbs}*}
                {*{assign var=w value=350}*}
                {*{assign var=h value=350}*}
                {*{/if}*}


                {slir w=$w h=$h b=1000 offer=$offer}
            {/if}


        </div>
    {/if}


{/strip}