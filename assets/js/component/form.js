(function ($) {

    $.fn.uForm = function (options) {

        var val = [];
        var args = Array.prototype.slice.call(arguments, 1);

        if (typeof options === 'string') {
            this.each(function () {
                var instance = $.data(this, 'form');
                if (typeof instance !== 'undefined' && $.isFunction(instance[options])) {
                    var methodVal = instance[options].apply(instance, args);
                    if (methodVal !== undefined && methodVal !== instance) val.push(methodVal);
                }
                else return $.error('No such method "' + options + '" for Form');
            });
        }
        else {
            this.each(function () {
                $.data(this, 'form', {});
                $.data(this, 'form', uForm(this, options));
            });
        }

        if (val.length === 0) return this;
        else if (val.length === 1) return val[0];
        else return val;
    };

    // Initialization
    function uForm(el, options) {
        return new uForm.prototype.init(el, options);
    }

    $.uForm = uForm;
    $.uForm.NAME = 'uForm';
    $.uForm.VERSION = '1.0';
    $.uForm.opts = {
        debug: true,
        errorClass: 'invalid',
        validClass: 'valid',
        errorElement: 'small',
        formOpts: {
            type: 'post',
            dataType: 'json',
            data: {'response': 'ajax'}
        }

    };


    // Functionality
    uForm.fn = $.uForm.prototype = {

        // Initialization
        init: function (el, options) {

            this.$element = el !== false ? $(el) : false;
            this.loadOptions(options);
            this.load();

        },

        loadOptions: function (options) {
            this.opts = $.extend({}, $.extend(true, {}, $.uForm.opts), this.$element.data(), options);
        },

        setCallback: function (type, e, data) {
            var events = $._data(this.$element[0], 'events');
            if (events && typeof events[type] != 'undefined') {
                var value = [];
                var len = events[type].length;
                for (var i = 0; i < len; i++) {
                    var namespace = events[type][i].namespace;
                    if (namespace == 'tools.' + $.uForm.NAME || namespace == $.uForm.NAME + '.tools') {
                        var callback = events[type][i].handler;
                        value.push((typeof data == 'undefined') ? callback.call(this, e) : callback.call(this, e, data));
                    }
                }

                if (value.length == 1) return value[0];
                else return value;
            }

            return (typeof data == 'undefined') ? e : data;

        },
        load: function () {


            this.opts.formOpts.success = this.response;
            this.opts.submitHandler = this.submit;


            this.validate();
            this.setRules();
            //this.enableEvents();
            //this.setTitle();
            //this.setDraggable();
            //this.setContent();


        },

        setRules: function () {
            this.validator.elements().each(function () {
                var $this = $(this);
                var data = $this.data('rules');
                if (data) {
                    var rules = {};
                    $.each(data.split('|'), function (k, v) {
                        var rule = v.split(',');
                        switch (rule[0]) {
                            case 'required':
                                rules.required = true;
                            case 'min_len':
                                rules.minlength = rule[1];
                                break;
                            case 'max_len':
                                rules.maxlength = rule[1];
                                break;
                            case 'numeric':
                                rules.number = true;
                                break;
                            case 'exactlength':
                                rules.exactlength = rule[1];
                                break;
                        }

                    });
                    $this.rules('add', rules);
                }
            });
        },

        validate: function () {
            this.validator = this.$element.validate(this.opts);
        },

        submit: function (form) {
            $(form).ajaxSubmit(this.settings.formOpts);
        },


        response: function (response, status, xhr, form) {

            var $el = $(form).parent('section');
            var tpl = '<div class="response ' + response.status + '">';
            tpl += '<div class="tit">' + response.tit + '</div>';
            tpl += '<div  class="txt">' + response.txt + '</div>';
            tpl += '</div>';
            $el.slideUp(function () {
                $el.html(tpl);
            }).slideDown();


        }
    };


    $(window).on('load.tools.form', function () {
        $('[data-tools="form"]').uForm();
    });

    uForm.prototype.init.prototype = uForm.prototype;

})(jQuery);