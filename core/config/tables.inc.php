<?php

if (!defined('SYSTEM_TABLE')) {
    define('SYSTEM_TABLE', 'shp_system');
}
if (!defined('SESSION_TABLE')) {
    define('SESSION_TABLE', 'shp_session');
}
if (!defined('BLOCKS_TABLE')) {
    define('BLOCKS_TABLE', 'shp_blocks');
}
if (!defined('RELATED_CONTENT_CAT_TABLE')) {
    define('RELATED_CONTENT_CAT_TABLE', 'shp_related_content_cat');
}
if (!defined('RELATED_CONTENT_TABLE')) {
    define('RELATED_CONTENT_TABLE', 'shp_related_content');
}
if (!defined('ONLINE_TABLE')) {
    define('ONLINE_TABLE', 'shp_online');
}
if (!defined('SURVEY_TABLE')) {
    define('SURVEY_TABLE', 'shp_survey');
}
if (!defined('ERROR_LOG_TABLE')) {
    define('ERROR_LOG_TABLE', 'shp_error_log');
}
if (!defined('MYSQL_ERROR_LOG_TABLE')) {
    define('MYSQL_ERROR_LOG_TABLE', 'shp_mysql_error_log');
}
if (!defined('COUNTER_TABLE')) {
    define('COUNTER_TABLE', 'shp_counter');
}
if (!defined('DUMP_TABLE')) {
    define('DUMP_TABLE', 'shp_dump');
}
if (!defined('ORDERS_TABLE')) {
    define('ORDERS_TABLE', 'shp_orders');
}
if (!defined('ORDER_STATUES_TABLE')) {
    define('ORDER_STATUES_TABLE', 'shp_order_status');
}
if (!defined('ORDERED_CARTS_TABLE')) {
    define('ORDERED_CARTS_TABLE', 'shp_ordered_carts');
}
if (!defined('PRODUCTS_TABLE')) {
    define('PRODUCTS_TABLE', 'shp_products');
}
if (!defined('CATEGORIES_TABLE')) {
    define('CATEGORIES_TABLE', 'shp_categories');
}
if (!defined('CATEGORIY_PRODUCT_TABLE')) {
    define('CATEGORIY_PRODUCT_TABLE', 'shp_category_product');
}
if (!defined('SHOPPING_CARTS_TABLE')) {
    define('SHOPPING_CARTS_TABLE', 'shp_shopping_carts');
}
if (!defined('NEWS_TABLE')) {
    define('NEWS_TABLE', 'shp_news_table');
}
if (!defined('DISCUSSIONS_TABLE')) {
    define('DISCUSSIONS_TABLE', 'shp_discussions');
}
if (!defined('MAILING_LIST_TABLE')) {
    define('MAILING_LIST_TABLE', 'shp_subscribers');
}
if (!defined('RELATED_PRODUCTS_TABLE')) {
    define('RELATED_PRODUCTS_TABLE', 'shp_related_items');
}
if (!defined('PRODUCT_OPTIONS_TABLE')) {
    define('PRODUCT_OPTIONS_TABLE', 'shp_product_options');
}
if (!defined('PRODUCT_OPTIONS_VALUES_TABLE')) {
    define('PRODUCT_OPTIONS_VALUES_TABLE', 'shp_product_options_values');
}
if (!defined('PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE')) {
    define('PRODUCTS_OPTIONS_VALUES_VARIANTS_TABLE', 'shp_products_opt_val_variants');
}
if (!defined('PRODUCTS_OPTIONS_SET_TABLE')) {
    define('PRODUCTS_OPTIONS_SET_TABLE', 'shp_product_options_set');
}
if (!defined('CUSTOMERS_TABLE')) {
    define('CUSTOMERS_TABLE', 'shp_customers');
}
if (!defined('CUSTGROUPS_TABLE')) {
    define('CUSTGROUPS_TABLE', 'shp_custgroups');
}
if (!defined('COUNTRIES_TABLE')) {
    define('COUNTRIES_TABLE', 'shp_countries');
}
if (!defined('ZONES_TABLE')) {
    define('ZONES_TABLE', 'shp_zones');
}
if (!defined('CUSTOMER_LOG_TABLE')) {
    define('CUSTOMER_LOG_TABLE', 'shp_customer_log');
}
if (!defined('CUSTOMER_ADDRESSES_TABLE')) {
    define('CUSTOMER_ADDRESSES_TABLE', 'shp_customer_addresses');
}
if (!defined('CUSTOMER_REG_FIELDS_TABLE')) {
    define('CUSTOMER_REG_FIELDS_TABLE', 'shp_customer_reg_fields');
}
if (!defined('CUSTOMER_REG_FIELDS_VALUES_TABLE')) {
    define('CUSTOMER_REG_FIELDS_VALUES_TABLE', 'shp_customer_reg_fields_values');
}
if (!defined('CUSTOMER_REG_FIELDS_VALUES_TABLE_QUICKREG')) {
    define('CUSTOMER_REG_FIELDS_VALUES_TABLE_QUICKREG', 'shp_customer_reg_fields_values_quickreg');
}
if (!defined('SHIPPING_METHODS_TABLE')) {
    define('SHIPPING_METHODS_TABLE', 'shp_shipping_methods');
}
if (!defined('PAYMENT_TYPES_TABLE')) {
    define('PAYMENT_TYPES_TABLE', 'shp_payment_types');
}
if (!defined('SHIPPING_METHODS_PAYMENT_TYPES_TABLE')) {
    define('SHIPPING_METHODS_PAYMENT_TYPES_TABLE', 'shp_payment_types__shipping_methods');
}
if (!defined('CURRENCY_TYPES_TABLE')) {
    define('CURRENCY_TYPES_TABLE', 'shp_currency_types');
}
if (!defined('SPECIAL_OFFERS_TABLE')) {
    define('SPECIAL_OFFERS_TABLE', 'shp_special_offers');
}
if (!defined('SHOPPING_CART_ITEMS_TABLE')) {
    define('SHOPPING_CART_ITEMS_TABLE', 'shp_shopping_cart_items');
}
if (!defined('SHOPPING_CART_ITEMS_CONTENT_TABLE')) {
    define('SHOPPING_CART_ITEMS_CONTENT_TABLE', 'shp_shopping_cart_items_content');
}
if (!defined('PRODUCT_PICTURES')) {
    define('PRODUCT_PICTURES', 'shp_product_pictures');
}
if (!defined('AUX_PAGES_TABLE')) {
    define('AUX_PAGES_TABLE', 'shp_aux_pages');
}
if (!defined('SETTINGS_GROUPS_TABLE')) {
    define('SETTINGS_GROUPS_TABLE', 'shp_settings_groups');
}
if (!defined('SETTINGS_TABLE')) {
    define('SETTINGS_TABLE', 'shp_settings');
}
if (!defined('CATEGORY_PRODUCT_OPTIONS_TABLE')) {
    define('CATEGORY_PRODUCT_OPTIONS_TABLE', 'shp_category__product_options');
}
if (!defined('CATEGORY_PRODUCT_OPTION_VARIANTS')) {
    define('CATEGORY_PRODUCT_OPTION_VARIANTS', 'shp_category_product_options__variants');
}
if (!defined('TAX_CLASSES_TABLE')) {
    define('TAX_CLASSES_TABLE', 'shp_tax_classes');
}
if (!defined('TAX_RATES_TABLE')) {
    define('TAX_RATES_TABLE', 'shp_tax_rates');
}
if (!defined('TAX_RATES_ZONES_TABLE')) {
    define('TAX_RATES_ZONES_TABLE', 'shp_tax_rates__zones');
}
if (!defined('TAX_ZIP_TABLE')) {
    define('TAX_ZIP_TABLE', 'shp_tax_zip');
}
if (!defined('MODULES_TABLE')) {
    define('MODULES_TABLE', 'shp_modules');
}
if (!defined('ORDER_PRICE_DISCOUNT_TABLE')) {
    define('ORDER_PRICE_DISCOUNT_TABLE', 'shp_order_price_discount');
}
if (!defined('ORDER_STATUS_CHANGE_LOG_TABLE')) {
    define('ORDER_STATUS_CHANGE_LOG_TABLE', 'shp_order_status_changelog');
}
if (!defined('LINK_EXCHANGE_CATEGORIES_TABLE')) {
    define('LINK_EXCHANGE_CATEGORIES_TABLE', 'shp_linkexchange_categories');
}
if (!defined('LINK_EXCHANGE_LINKS_TABLE')) {
    define('LINK_EXCHANGE_LINKS_TABLE', 'shp_linkexchange_links');
}
if (!defined('AFFILIATE_COMMISSIONS_TABLE')) {
    define('AFFILIATE_COMMISSIONS_TABLE', 'shp_aff_commissions');
}
if (!defined('AFFILIATE_PAYMENTS_TABLE')) {
    define('AFFILIATE_PAYMENTS_TABLE', 'shp_aff_payments');
}
?>