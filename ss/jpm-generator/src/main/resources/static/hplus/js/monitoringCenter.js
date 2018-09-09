var vue1 = new Vue({
    el: '#wrapper',
    data: {
        procedureList: {},
        temperature: '12.3',
        pid: '0:1245.6',
        date: '2018/08/22 WED 15:24:55',
        alterList: {
            totalSegmentNumber: '4',
        },
        tableList: [
            {
                circulate: 1,
                start: '00',
                end: '3',
                alreadyCirculate: '000'
            },
            {
                circulate: 1,
                start: '00',
                end: '3',
                alreadyCirculate: '000'
            },
            {
                circulate: 1,
                start: '00',
                end: '3',
                alreadyCirculate: '000'
            }, {
                circulate: 1,
                start: '00',
                end: '3',
                alreadyCirculate: '000'
            }
            , {
                circulate: 1,
                start: '00',
                end: '3',
                alreadyCirculate: '000'
            }
        ],
        titleId: '1',
        address: '',
        loopList: []
    },
    computed: {
    },
    watch: {
        "procedureList": function (value) {
            var _this = this;
            console.log(value);

        }
    },
    methods: {

    }
});

$(document).ready(function() {
    var num = Math.random();
    client = new Paho.MQTT.Client("192.168.30.3", 61614, "web-monitor-center"+num+"");
    function popContent(val,min,max) {
        $("input").focus();
        var div = '<form id="totalNumber" class="pop-form">' +
            '<div class="m-t-lg">' +
            '<label for="">请输入数值：</label>' +
            '<input type="text" class="pop-style" name="num" id="num" value='+val+'>' +
            '</div>' +
            '<div class="m-t-xs m-b-xs">' +
            '<div class="font m-b-lg">MIN:'+min+' MAX:'+max+'</div>' +
            '<button type="submit" class="back-green m-r-lg" id="sure">确认</button>' +
            '<span class="back-red cancel">取消</span></div></form>';
        return div
    }
    $(function(){
        //val 当前程序的值
        // address 当前对象的地址编号
        //flagNotice 是否开启了通知
        //Order 写入前还是写入后 0 是写入前 1 是写入后
        //Address 开启通知对应的地址
        //Value 通知是On还是Off 0是off 1是on

        var postData = function (val,deviceAdd,flagNotice,Order,Address, Value,flagInvalid) {
            var data = {
                "Num": vue1.$data.procedureList.num,
                "Item": {
                    "Value": val,
                    "Address": deviceAdd,
                    "Type": flagType(deviceAdd)
                }
            };
            if(flagNotice){
                data.Item.Notify = {
                    Order: Order,
                    Address: Address,
                    Value: Value,
                    Type: flagType(Address)
                }
            }
            console.log(data);
            message = new Paho.MQTT.Message(JSON.stringify(data));
            message.destinationName = "MqttWrite";
            client.send(message);

        }
        $(document).on("click", '.cancel', function(){
            layer.closeAll(); //疯狂模式，关闭所有层
        });



        $(document).on("click", '.color-g', function() {
            var id = $(this).attr('dataId');
            var text = $(this).text();
            //var div = '<form id="totalNumber" class="pop-form">' +
            //    '<div class="m-t-lg">' +
            //    '<label for="">请输入数值：</label>' +
            //    '<input type="text" class="pop-style" name="num"/>' +
            //    '</div>' +
            //    '<div class="m-t-xs m-b-xs">' +
            //    '<div class="font m-b-lg">MIN:1 MAX:25</div>' +
            //    '<button type="submit" class="back-green m-r-lg" id="sure">确认</button>' +
            //    '<span class="back-red cancel">取消</span></div></form>'
            vue1.$data.titleId = id;
            vue1.$data.address = $(this).attr("data-Address");
            //console.log(vue1.$data.address);

            if (id == 1) {
                layer.open({
                    type: 1,
                    //skin: 'layui-layer-rim', //加上边框
                    area: ['420px', '240px'], //宽高
                    title: '段/总段数',
                    shadeClose: true,
                    content: popContent(text, 1, 25)
                });
            } else if (id == 2) {
                layer.open({
                    type: 1,
                    //skin: 'layui-layer-rim', //加上边框
                    area: ['420px', '240px'], //宽高
                    title: '总循环/已循环',
                    shadeClose: true,
                    content: popContent(text, 0, 9999)
                });
            }else {
                layer.open({
                    type: 1,
                    //skin: 'layui-layer-rim', //加上边框
                    area: ['420px', '240px'], //宽高
                    title: '循环/已循环',
                    shadeClose: true,
                    content: popContent(text, 0, 9999)
                });
            }
        })

        $(document).on('click', '#sure', function() {
            var val = $(this).parent().siblings(".m-t-lg").find("#num").val()
            //console.log()
        if(vue1.$data.titleId == 1){
            $("#totalNumber").validate({
                rules:{
                    num:{
                        required:true,
                        range: [1, 25],
                        digits: true
                    }
                },
                messages: {
                    num:{
                        required: "必填",
                        range: "范围在1-25之间",
                        digits: "请输入整数"
                    }
                },
                //focusInvalid:true,
                //当未通过验证的元素获得焦点时，移除错误提示
                //focusCleanup:true,
                errorElement: 'div',
                submitHandler: function (form) {
                    postData(val, vue1.$data.address,
                        true, 1, "V6406.7", 1);
                },
                invalidHandler: function (form) {

                }
            })
        }
        else if(vue1.$data.titleId == 2) {
            $("#totalNumber").validate({
                rules:{
                    num:{
                        required:true,
                        range: [0, 9999],
                        digits:true
                    }
                },
                messages: {
                    num:{
                        required: "必填",
                        range: "范围在0-9999之间",
                        digits: "请输入整数"
                    }
                },
                //focusInvalid:true,
                //当未通过验证的元素获得焦点时，移除错误提示
                //focusCleanup:true,
                errorElement: 'div',
                submitHandler: function (form) {
                    postData(val, vue1.$data.address);
                },
                invalidHandler: function (form) {

                }
            })
        }
        else {
            $("#totalNumber").validate({
                rules:{
                    num:{
                        required:true,
                        range: [0, 9999],
                        digits:true
                    }
                },
                messages: {
                    num:{
                        required: "必填",
                        range: "范围在0-9999之间",
                        digits: "请输入整数"
                    }
                },
                //focusInvalid:true,
                //当未通过验证的元素获得焦点时，移除错误提示
                //focusCleanup:true,
                errorElement: 'div',
                submitHandler: function (form) {

                },
                invalidHandler: function (form) {

                }
            })
        }
    });



        // set callback handlers
        client.onConnectionLost = onConnectionLost;
        client.onMessageArrived = onMessageArrived;

        // connect the client
        client.connect({onSuccess:onConnect});


        // called when the client connects
        function onConnect() {
            // Once a connection has been made, make a subscription and send a message.
            console.log("onConnect");
            client.subscribe("MqttRead");
            //client.subscribe("MqttWrite");
            //message = new Paho.MQTT.Message("Hello");
            //message.destinationName = "MqttWrite";
            //client.send(message);
            //client.publish("MqttWrite", "fdfasfdsa")
            //client.publish()
        }

        // called when the client loses its connection
        function onConnectionLost(responseObject) {
            if (responseObject.errorCode !== 0) {
                console.log("onConnectionLost:"+responseObject.errorMessage);
            }
        }

        // called when a message arrives
        function onMessageArrived(message) {
            //console.log(message);
            if(message.destinationName == 'MqttRead'){
                var str = JSON.parse(message.payloadString);
                vue1.$data.procedureList = str;
            }
        }
})


})



