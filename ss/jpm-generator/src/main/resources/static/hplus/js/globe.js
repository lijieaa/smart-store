//把表单序列化为对象
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};


function ajax(url,data, type, dataType, async,contentType,success, error) {
    var success = success || function (data) {
            /*console.log('请求成功');*/
            setTimeout(function () {
                layer.msg(data.msg);//通过layer插件来进行提示信息
            },500);
            if(data.status){//服务器处理成功
                setTimeout(function () {
                    if(data.url){
                        location.replace(data.url);
                    }else{
                        location.reload(true);
                    }
                },1500);
            }else{//服务器处理失败
                if(alone){//改变ajax提交状态
                    ajaxStatus = true;
                }
            }
        };
    var error = error || function (data) {
            /*console.error('请求成功失败');*/
            /*data.status;//错误状态吗*/
            layer.closeAll('loading');
            setTimeout(function () {
                if(data.rslt.status == 404){
                    alert(1);
                    layer.msg('请求失败，请求未找到');
                }else if(data.status == 503){
                    layer.msg('请求失败，服务器内部错误');
                }else {
                    layer.msg('请求失败,网络连接超时');
                }
            },500);
        };
    /*正常情况下1秒后可以再次多个异步请求，为true时只可以有一次有效请求（例如添加数据）*/
    $.ajax({
        'url': url+"?"+Math.random()+"",
        'data': data,
        'type': type || 'post',//请求类型,
        'dataType': dataType || 'json',
        'async': async || true,
        'contentType': contentType || 'application/json',
        'success': success,
        'error': error,
        'jsonpCallback': 'jsonp' + (new Date()).valueOf().toString().substr(-4),
        'beforeSend': function () {
            layer.msg('加载中', {
                icon: 16,
                shade:.5
            });
        }
    });
}

//判断当前是什么类型
function flagType(value){
    if(value.substr(1,1) == 'W'){
        return 'int'
    }
    else if(value.substr(1,1) == 'D') {
        return 'float'
    }
    else {
        return 'bool'
    }
}