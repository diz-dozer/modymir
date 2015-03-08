{strip}
    <div id="content"{if $pageID eq 'feedback'} class="with_map"{/if}>

        <div class="container">
            {include file='widget/breadcrumb.tpl'}
            {include file='mod/blocks.tpl' binfo=$top_blocks}

            {if $pageID|in_array:$has_aside}


            <div class="with_aside">
                <aside id="aside">
                    {include file='mod/blocks.tpl' binfo=$left_blocks}
                    {include file='mod/aside_menu.tpl'}
                    {include file='mod/blocks.tpl' binfo=$right_blocks}
                </aside>
                {/if}



                <main id="main" role="main">
                    {include file=$main_content_template}
                </main>


                {if $pageID|in_array:$has_aside}</div>{/if}

            {include file='mod/blocks.tpl' binfo=$bottom_blocks}

        </div>
    </div>
{/strip}