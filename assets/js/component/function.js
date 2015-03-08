function cl($v) {
    console.log($v);
}

$.validator.addMethod("exactlength", function (value, element, param) {
    return this.optional(element) || value.length == param;
}, $.validator.format("Please enter exactly {0} characters."));


$.extend(
    $.validator.messages, {
        required: 'Это поле необходимо заполнить.',
        remote: 'Пожалуйста, введите правильное значение.',
        email: 'Пожалуйста, введите корректный адрес электронной почты.',
        url: 'Пожалуйста, введите корректный URL.',
        date: 'Пожалуйста, введите корректную дату. день/мес./год',
        dateISO: 'Пожалуйста, введите корректную дату в формате ISO.',
        number: 'Пожалуйста, введите число.',
        digits: 'Пожалуйста, вводите только цифры.',
        creditcard: 'Пожалуйста, введите правильный номер кредитной карты.',
        equalTo: 'Пожалуйста, введите такое же значение ещё раз.',
        extension: 'Пожалуйста, выберите файл с правильным расширением.',
        maxlength: $.validator.format('Пожалуйста, введите не больше {0} символов.'),
        minlength: $.validator.format('Пожалуйста, введите не меньше {0} символов.'),
        rangelength: $.validator.format('Пожалуйста, введите значение длиной от {0} до {1} символов.'),
        range: $.validator.format('Пожалуйста, введите число от {0} до {1}.'),
        max: $.validator.format('Пожалуйста, введите число, меньшее или равное {0}.'),
        min: $.validator.format('Пожалуйста, введите число, большее или равное {0}.'),
        exactlength: $.validator.format('Номер телефона должен быть {0} цифр.')
    }
);
