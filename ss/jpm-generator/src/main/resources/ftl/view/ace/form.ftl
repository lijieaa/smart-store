<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout" layout:decorate="~{layout}">
<body layout:fragment="content">
<div class="page-header" class="editCom">
    <div class="float-left">
        <span class="header-list"></span><span class="header-font-style">{{userTitle}}</span>
    </div>
    <div class="float-right">
        <a href="@{list}" class="add-style color-white"></i>返回</a>
    </div>
</div><!-- /.page-header -->
<div class="row" class="editCom">
    <div class="col-xs-12">
        <div class="row">
            <form class="form-horizontal" id="validation-form">

            <#list table.cols as c>
                <#if c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks')>
                    <#if c.showType == "input">
                        <div class="form-group">
                            <label class="control-label col-xs-12 col-sm-3 no-padding-right" >${c.comments}:</label>
                            <div class="col-xs-12 col-sm-9">
                                <div class="clearfix">
                                    <input type="text" name="${c.javaFieldId}" id="${c.javaFieldId}" v-model="rslt.${c.javaFieldId}"
                                           class="col-xs-12 col-sm-8" >
                                </div>
                            </div>
                        </div>
                    </#if>
                </#if>
            </#list>
                <div class="space-4"></div>
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" id="submit">
                            <i class="ace-icon fa fa-check bigger-110"></i>
                            提交
                        </button>

                        &nbsp; &nbsp; &nbsp;
                        <button class="btn" type="reset">
                            <i class="ace-icon fa fa-undo bigger-110"></i>
                            重置
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <!-- PAGE CONTENT ENDS -->
    </div>
    <!-- /.col -->
</div>
<script th:inline="javascript">
    var id=[[${"$"}{${"#"}request.getParameter('id')}]];
    //validate验证
    $(document).ready(function(){

        var vue = new Vue({
            el: '.wrapper',
            data: {
                userTitle: '',
                rslt:{
                   <#list table.cols as c>
                       <#if c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks')>
                           ${c.javaFieldId}:"",
                       </#if>
                   </#list>
    },
    },
        mounted:function () {
            let _this = this;
            if(id){
                _this.userTitle = '编辑${functionNameSimple}';
                $.ajax({
                    url: ctx + "api/${moduleName}/${class_name}/"+id,
                    method: "get",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (data) {
                        if(data.errcode==0){
                            _this.rslt=data.rslt;
                        }else{
                            alert("加载数据出错！");
                        }
                    },
                    error: function () {
                        console.log("error");
                    }
                })
            }
            else {
                _this.userTitle = '新增${functionNameSimple}';
            }

            $("#form").validate({
                rules:{
<#list table.cols as c>
    <#if c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks')>
        ${c.javaFieldId}:{
        <#if c.isNull?? && c.isNull == "1">
            required:true,
                    maxlength:${c.dataLength},
        </#if>
        <#if c.isPk?? && c.name != "id" && c.isPk=="1">
            remote: function() {
                var ${c.javaFieldId} = vue.$data.rslt.${c.javaFieldId};
                var remote = {
                    url: ctx+"api/${moduleName}/${class_name}/${c.javaFieldId}",
                    data: "${c.javaFieldId}="+${c.javaFieldId}+"&id="+(id?id:'')
                };
                return remote;
            },
        </#if>
             <#list c.validator as vv>
                 <#if vv?? && vv!= "">
                     <#if vv == "email">
                         checkEmail:true,
                     <#elseif vv == "url">
                             checkUrl:true,
                     <#elseif vv == "date">
                      checkDate:true,
                     <#elseif vv == "number">
                      checkNumber:true,
                     <#elseif vv == "integer">
                        checkInteger:true,
                     <#elseif vv == "digits">
                      checkDigits:true,
                     <#elseif vv == "userName">
                      checkUserName:true,
                     <#elseif vv == "realName">
                      checkRealName:true,
                     <#elseif vv == "abc">
                        checkAbc:true,
                     <#elseif vv == "simplePhone">
                        checkSimplePhone:true,
                     <#elseif vv == "phone">
                        checkPhone:true,
                     <#elseif vv == "zipCode">
                        checkZipCode:true,
                     <#elseif vv == "ipv4">
                        checkIPv4:true,
                     <#elseif vv == "ipv6">
                        checkIPv6:true,
                     <#elseif vv == "qq">
                        checkQQ:true,
                     <#elseif vv == "idcard">
                        checkIdcard:true,
                     </#if>
                 </#if>
             </#list>
    },
    </#if>
</#list>
        },
            //是否在获取焦点时验证
            //onfocusout:false,
            //是否在敲击键盘时验证
            //onkeyup:false,
            //提交表单后，（第一个）未通过验证的表单获得焦点
            focusInvalid:true,
                    //当未通过验证的元素获得焦点时，移除错误提示
                    focusCleanup:true,

                    submitHandler: function (form) {

                if(id){
                    var data = $(form).serializeObject();
                    data.id=id;
                    $.ajax({
                        url: ctx + "api/${moduleName}/${class_name}/",
                        method: "put",
                        contentType: "application/json",
                        data: JSON.stringify(data),
                        dataType: "json",
                        success: function (data) {
                            location.href="list";
                        },
                        error: function () {
                            console.log("error");
                        }
                    })
                }else{
                    var data = $(form).serializeObject();
                    $.ajax({
                        url: ctx + "api/${moduleName}/${class_name}/",
                        method: "post",
                        contentType: "application/json",
                        data: JSON.stringify(data),
                        dataType: "json",
                        success: function (data) {
                            location.href="list";
                        },
                        error: function () {
                            console.log("error");
                        }
                    })
                }


            },
            invalidHandler: function (form) {

            }

        });


        }
    })

    });
</script>
</body>
</html>