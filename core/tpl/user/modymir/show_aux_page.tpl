{strip}
    <article>

        <header>
            {include file='mod/admin_link.tpl' href="?dpt=custord&amp;sub=aux_pages&amp;edit=`$show_aux_page`"}
            {include file='mod/header.tpl' header=$aux_page_name}
        </header>

        <div class="content">
            {$page_body}
        </div>

    </article>
{/strip}