{strip}
    <head>


        <meta charset="utf-8" />
        <meta name="robots" content="all" />

        <title>{$page_title}</title>

        {if $page_meta_tags eq ""}
            <meta name="description" content="{$smarty.const.CONF_HOMEPAGE_META_DESCRIPTION}" />
            <meta name="keywords" content="{$smarty.const.CONF_HOMEPAGE_META_KEYWORDS}" />
        {else}
            {$page_meta_tags}
        {/if}

        <link type="text/css" media="screen" rel="stylesheet" href="/assets/all.css" />
        <link rel="icon" href="data/favicon.png" type="image/x-icon" />
        <link rel="shortcut icon" href="data/favicon.png" type="image/x-icon" />

    </head>
{/strip}
