<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout" layout:decorate="~{layout}">
<body layout:fragment="content">
<div class="page-header">
    <div class="float-left">
        <span class="header-list"></span><span class="header-font-style">${functionName}</span>
    </div>
    <div class="float-right">
        <a th:href="@{add_form}" class="add-style color-white">
            <i class="ace-icon glyphicon glyphicon-plus"></i>
            新增</a>
    </div>
</div><!-- /.page-header -->
<form action="" id="searchForm">
    <div class="search-list">
        <#list table.cols as c>
            <#if c.isQuery?? && c.isQuery == "1">
                <div class="float-left">
                    <label for="${c.simpleJavaField}" >${c.comments}：</label>
                    <input type="text" id="${c.simpleJavaField}" name="${c.simpleJavaField}">
                </div>
            </#if>
        </#list>
        <span class="search float-left" id="search">
                            <i class="ace-icon glyphicon glyphicon-search margin-right-10"></i>搜索
                        </span>

    </div>
</form>
<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->


        <div class="hr hr-18 dotted hr-double"></div>

        <div class="row">
            <div class="col-xs-12">
                <div>
                    <table id="dynamicTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <#list table.cols as c>
                                <#if c.isList?? && c.isList == "1">
                                        <th>${c.comments}</th>
                                </#if>
                            </#list>
                            <th>操作功能</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>


        <!-- PAGE CONTENT ENDS -->
    </div><!-- /.col -->
</div><!-- /.row -->
<script type="text/javascript" th:inline="javascript">
    jQuery(function($) {
        var myTable =
                $('#dynamicTable')
                        .DataTable( {
                            bAutoWidth: false,
                            "language": {
                                "url": "../assets/js/zh_CN.json"
                            },
                            'order': [],
                            "ordering": true,
                            "processing": true,
                            'paging': true,
                            "serverSide": true,
                            'searching': false,
                            "ajax": function (data,callback,setting) {
                                var formData = $("#searchForm").serialize();
                                var pageNum=data.start/data.length+1;
                                var pageSize=data.length;
                                var draw=data.draw;

                                var orderByClause="";
                                var param="?pageNum="+pageNum+"&pageSize="+pageSize+"&"+formData+"&draw="+draw+"&od="+orderByClause;
                                $.ajax({
                                    "url": ctx + "api/${moduleName}/${class_name}/datatables"+param,
                                    "type": "get",
                                    dataType:"json",
                                    contentType:'application/json',
                                    "success": function (json) {
                                        if (json.errcode == 0) {
                                            var data = {};
                                            data.recordsTotal = json.rslt.recordsTotal;
                                            data.recordsFiltered = json.rslt.recordsFiltered;
                                            data.data = json.rslt.data;
                                            callback(data);
                                        }
                                    },
                                    "error": function (XMLHttpRequest, textStatus, errorThrown) {
                                        // console.log(errorThrown);
                                    }
                                });
                            },
                            "columns": [
                                 <#list table.cols as c>
                                     <#if c.isList?? && c.isList == "1">
                                        { "data": "${c.comments}" },
                                     </#if>
                                 </#list>
                                {"data": null}
                            ],
                            "columnDefs": [
                                 <#list table.cols as c>
                                     <#if c.isList?? && c.isList == "1">
                                       {
                                           "targets": 0,
                                           'searchable': true,
                                           'orderable': true,
                                           "data": null,
                                           "render": function (data, type, row) {
                                               return '<td>' + data + '</td>';
                                           },
                                       },
                                     </#if>
                                 </#list>
                                {
                                    "targets": -1,
                                    'searchable': false,
                                    "orderable": false,
                                    // "data": null,
                                    "render": function (data, type, row) {
                                        var div = '<div style="text-align: center">' +
                                                '<a class="padding-left-5" id="edit" href="edit_form/?id='+data.id+'">编辑</a>' +
                                                '<a class="padding-left-5" id="delBusiness" data-id="'+data.id+'">删除</a></div>'
                                        return div;
                                    }
                                }
                            ],
                            select: {
                                style: 'multi'
                            }
                        } );

        $("#search").on("click",function(e){
            // alert(0);
            myTable.draw();
        });


        //删除
        $(document).on("click","#delBusiness", function () {
            var id = $(this).attr('data-id');
            bootbox.confirm( {
                message: "您真的要删除吗?",
                buttons: {
                    confirm: {
                        label: '确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if(result){
                        $.ajax({
                            url:  ctx + "api/${moduleName}/${class_name}/"+id,
                            method: "delete",
                            success: function (data) {
                                if(data.errcode==0){
                                    myTable.draw();
                                }else{
                                    alert("删除数据出错！");
                                }
                            },
                            error: function (data) {
                                //console.log(data);
                            }
                        })
                    }
                }
            });
        })

    })
</script>
</body>
</html>