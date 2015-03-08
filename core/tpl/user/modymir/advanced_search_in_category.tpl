{strip}
    {if $categories_to_select}
        <form id="AdvancedSearchInCategory" method="get" action="index.php">
            <fieldset>
                <ul>
                    <li>
                        <label for="category-select">{$smarty.const.STRING_CATEGORY}:</label>
                        <select id="category-select" name="categorySelect">
                            {if !$categoryID}
                                <option value='0'>{$smarty.const.ADMIN_PROMPT_TO_SELECT}</option>
                            {/if}
                            {section name=i loop=$big_categories_tree}
                                {if $big_categories_tree[i].categoryID == $smarty.get.selectCategoryID}
                                    {assign var=cat_selected value="selected=\"selected\""}
                                {elseif $big_categories_tree[i].categoryID == $smarty.get.categorySelect}
                                    {assign var=cat_selected value="selected=\"selected\""}
                                {else}
                                    {assign var=cat_selected value=""}
                                {/if}
                                <option value="{$big_categories_tree[i].categoryID}"{$cat_selected}>&nbsp;{section name=j loop=$big_categories_tree[i].level}&nbsp;&nbsp;{/section}{$big_categories_tree[i].name}&nbsp;</option>
                            {/section}
                        </select>
                    </li>
                    {if $categoryID}
                        <li>
                            <label for="search-name">{$smarty.const.STRING_NAME}:</label>
                            <input id="search-name" type="text" name="search_name" value="{$search_name}"/>
                        </li>
                    {/if}
                    <li>
                        {if $categoryID}
                        <input type="hidden" value="yes" name="advanced_search_in_category"/>
                        {if $show_subcategory_checkbox}
                            {if $show_subcategories_products}
                                <input type=hidden value="1" name="search_in_subcategory"/>
                            {else}
                                <input type="checkbox" value="1" id="search_in_subcategory" name="search_in_subcategory" {if $search_in_subcategory} checked="cheked"{/if} />
                                <label for="search_in_subcategory">{$smarty.const.STRING_SEARCH_IN_SUBCATEGORIES}</label>
                            {/if}
                        {/if}
                        <input type="hidden" name="categoryID" value="{$categoryID}"/>
                        <input type="hidden" name="search_with_change_category_ability" value="yes"/>
                        <input type="hidden" name="advanced_search_in_category" value="on"/>
                    </li>
                </ul>
                <button type="submit">найти</button>
            </fieldset>
            {/if}
        </form>
    {else}
        <div class="error">{$smarty.const.STRING_NO_CATEGORIES}</div>
    {/if}

{/strip}