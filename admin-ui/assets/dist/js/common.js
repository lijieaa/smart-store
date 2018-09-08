$(".rest-drop>a").click(function () {
    $(this).next().slideToggle();
})

jQuery.validator.addMethod("isMobile", function(value, element) {
    var length = value.length;
    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(19[0-9]{9})|(16[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
    return this.optional(element) || (length == 11 && mobile.test(value));
}, "请正确填写您的手机号码");

$.extend($.validator.messages, {
    required: "这是必填字段",
    digits: '只能输入数字'

})