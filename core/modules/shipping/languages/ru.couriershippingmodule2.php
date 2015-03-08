<?php
define('COURIER2_TTL', 'Курьер (расчет стоимости доставки по весу)');
define('COURIER2_DSCR', 'Модуль позволяет определить стоимость доставки внутри какой-либо страны и/или области в зависимости от веса заказа');

define('COURIER2_CFG_COUNTRY_TTL', 'Страна');
define('COURIER2_CFG_COUNTRY_DSCR', 'Выберите страну, на территории которой возможна доставка курьером и, соответственно, расчет стоимости доставки данным модулем.');

define('COURIER2_CFG_ZONE_TTL', 'Область');
define('COURIER2_CFG_ZONE_DSCR', 'Выберите область, на территории которой возможна доставка курьером и, соответственно, расчет стоимости доставки данным модулем.');

define('COURIER2_CFG_RATES_TTL', 'Стоимость доставки');
define('COURIER2_CFG_RATES_DSCR', 'В форме справа определите пары [вес_заказа, стоимость_доставки]. Каждая пара определяет "стоимость_доставки" для заказов, вес которых ниже чем "вес_заказа". Для заказов, вес которых выше максимального указанного, стоимость доставки считается нулевой');

define('COURIER2_TXT_AMOUNT', 'Вес заказа');

define('COURIER2_TXT_COST', 'Стоимость доставки для заказов, вес которых менее указанного. <br>Вы можете указать фиксированную стоимость доставки (в у.е.) или в процентах от суммы заказа. <br>Например, значение "10" обозначает фиксированную стоимость доставки 10 у.е., <br>значение "10%" рассчитает стоимость доставки как 10% от сумма заказа.');
?>