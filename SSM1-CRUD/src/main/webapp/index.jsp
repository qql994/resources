<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 2020/7/15
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="static/jquery/js/jquery.min.js"></script>
    <script src="static/bootstrap/js/bootstrap.min.js"></script>
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <title>员工列表</title>
</head>
<body>
<!-- 员工新增的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <%--设置字体，text框占格--%>
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_add_empname" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="emp_add_email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--设置内联单选框--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                        </label>
                    </div>
                    <%--部门信息下拉框--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--员工编辑的模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">员工信息编辑</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <%--设置字体，text框占格--%>
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="emp_update_email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--设置内联单选框--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="F"> 女
                        </label>
                    </div>
                    <%--部门信息下拉框--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_edit_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3>SSM-CRUD</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" data-toggle="modal" id="empAddModel_btn">新增</button>

            <button class="btn btn-danger" data-toggle="modal" id="delAll_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="emps_table" class="table table-hover">
                <thead >
                <tr>
                    <td><input type="checkbox" id="check_all"></td>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                </tbody>

            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script>

    var totalRecord;
    var currentRecord;
    //清除表单数据(数据和样式)
    function reset_form(ele){
        //清除表单数据
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //编辑按钮单击,click是在按钮创建之前就绑定上了。所以不能用click绑定。
    //旧版的jquery中有一个方法叫做live，可以在ajax操作生效之后绑定，但是新版本中被删除了。
    //使用on来代替,第一个参数是绑定的方法，第二个是选择器
    $(document).on("click",".edit_btn",function () {
        //清除表单数据(数据和样式)
        // reset_form("#empUpdateModel form");
        //查询员工信息
        getEmp($(this).attr("edit-id"));
        //获取部门信息
        getDepts("#empUpdateModel select");
        //把员工的id传给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框，点击模态框之外不会消失
        $('#empUpdateModel').modal({
            backdrop:"static"
        });
    });



    //更新按钮
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#emp_update_email").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            show_validate_msg("#emp_update_email","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#emp_update_email","success","");
        }
        $.ajax({
            url:"emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
                alert(result.msg);
                //关闭模态框
                $('#empUpdateModel').modal('hide');
                //跳转到最后一页
                to_page(totalRecord);
            }
        })
    });
    //根据主键id查询，将获取的员工数据存到编辑模态框中
    function getEmp(id){
        $.ajax({
            url:"emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#emp_update_email").val(empData.email);
                $("#empUpdateModel input[name=gender]").val([empData.gender]);
                $("#empUpdateModel select").val([empData.dId]);
            }
        })
    }
    //新增按钮点击
    $("#empAddModel_btn").click(function () {
        //清除表单数据(数据和样式)
        reset_form("#empAddModel form");
        //获取部门信息
        getDepts("#empAddModel select");
        //弹出模态框，点击模态框之外不会消失
        $('#empAddModel').modal({
            backdrop:"static"
        });
    });
    //获取部门信息使其显示在下拉框中
    //遍历添加
    function getDepts(ele){
        $(ele).empty();
        $.ajax({
            url:"depts",
            type:"GET",
            success:function (result) {
                //console.log(result);
                //{"code":100,"msg":"处理成功","extend":{"departments":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"开发部"},{"deptId":3,"deptName":"测试部"}]}}
                $.each(result.extend.departments,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    };
    //页面加载完成，直接发送ajax请求，要到分页信息
    $(function () {
        $.ajax({
            url: "emps",
            data: "pn=1",
            type: "GET",
            success: function (result) {
                console.log(result);
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    });
    // $(function () {
    //     to_page(1);
    // });
    function to_page(pn) {
        $.ajax({
            url: "emps",
            data: "pn="+pn,
            type: "GET",
            success: function (result) {
                console.log(result);
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }
    //解析显示员工信息
    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.PageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="1"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var bjTd = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            bjTd.attr("edit-id",item.empId);
            var scTd = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            scTd.attr("delete-id",item.empId);
            var btnTd = $("<td></td>").append(bjTd).append(" ").append(scTd)
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");

        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.PageInfo.pageNum+"页,总共"+result.extend.PageInfo.pages+"页,总共"+result.extend.PageInfo.total+"条记录");
        totalRecord = result.extend.PageInfo.total;
        currentRecord = result.extend.PageInfo.pageNum;
    }
    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var nav = $("<nav></nav>")

        var ul = $("<ul></ul>").addClass("pagination");
        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        //末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        //前一页
        var preLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        //后一页
        var nextLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        //前面或者后面没有页数时，无法点击。
        //有页数时，点击首页跳转到第一页。点击末页跳转到最后一页。
        //点击前一页跳转。后一页跳转。
        if(result.extend.PageInfo.hasPreviousPage == false){
            preLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        }else {
            preLi.click(function () {
                to_page(result.extend.PageInfo.pageNum-1);
            });
            firstPageLi.click(function () {
                to_page(1);
            });
        }
        if(result.extend.PageInfo.hasNextPage == false){
            nextLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextLi.click(function () {
                to_page(result.extend.PageInfo.pageNum+1)
            });
            lastPageLi.click(function () {
                to_page(result.extend.PageInfo.pages)
            });
        }
        //先添加首页和前一页
        ul.append(firstPageLi).append(preLi);
        $.each(result.extend.PageInfo.navigatepageNums,function (index,item){
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            //如果现在遍历的pageNum与result中的pageNum相同，那么给当前的页码添加一个类active，使得页码上显示为深色。
            if(result.extend.PageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item)
            });
            //遍历添加每一页的页码
            ul.append(numLi);
        });
        //添加后一页和末页
        ul.append(nextLi).append(lastPageLi);
        nav.append(ul).appendTo("#page_nav_area");
    }
    //数据校验
    function validate_add_form(){
        //先得到校验数据，使用正则表达式进行校验
        var empName = $("#emp_add_empname").val();
        var regEmpName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regEmpName.test(empName)){
            //alert("111");
            show_validate_msg("#emp_add_empname","error","用户名应为2-5位中文或是6-16位英文")
            return false;
        }else{
            show_validate_msg("#emp_add_empname","success","")
        };
        var email = $("#emp_add_email").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            //alert("1111");
            show_validate_msg("#emp_add_email","error","邮箱格式不正确")
            return false;
        }else{
            show_validate_msg("#emp_add_email","success","")
        };
        return true;
    }

    function show_validate_msg(ele,status,msg){
        //清空这个元素之前的样式
        $(ele).parent().removeClass("has-success has-error")
        $(ele).next("span").text("");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验姓名是否可用，数据库中是否存在

    $("#emp_add_empname").change(function () {
        var empName = this.value;
        $.ajax({
            url:"checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 100){
                    show_validate_msg("#emp_add_empname","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#emp_add_empname","error",result.extend.va_Msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //点击保存信息
    $("#emp_save_btn").click(function () {
        //模态框中填写的数据提交给服务器进行保存
        //先对提交上的数据进行前端校验
        if(!validate_add_form()){
            return false;
        }
        //判断之前的ajax用户名是否校验成功，如果失败
        if ($(this).attr("ajax-va")=="error"){
            return false;
        }
        $.ajax({
            url:"emp",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function (result) {
                if (result.code == 100){
                    //显示处理成功
                    alert(result.msg);
                    //关闭模态框
                    $('#empAddModel').modal('hide');
                    //跳转到最后一页
                    to_page(totalRecord);
                }else {
                    //显示失败信息
                    //有哪个字段是错误的就显示哪个字段
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#emp_add_email","error",result.extend.errorFields.email)
                    }if(undefined != result.extend.errorFields.empName){
                        //显示用户名错误信息
                        show_validate_msg("#emp_add_empname","error",result.extend.errorFields.empName)
                    }
                }
            }
        });
    });
    //删除按钮deleteModal_btn
    //currentRecord回到本页，全局定义
    //var currentRecord;
    //currentRecord = result.extend.PageInfo.pageNum;
    $(document).on("click",".delete_btn",function () {
        var empId = $(this).attr("delete-id")
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        //alert();
        //确认框confirm
        if(confirm("确认删除【"+empName+"】")){
            $.ajax({
                url:"emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentRecord);
                }
            });
        };
    });
    //全选&全不选
    $("#check_all").click(function () {
        //$(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function () {
       //判断当前选中的元素是否与当前页面单选框数量一致
        var flag = $(".check_item:checked").length == $(".check_item").length;
        //若是五个，则将全选按钮选上
        $("#check_all").prop("checked",flag);
    });
    //批量删除
    $("#delAll_btn").click(function () {
        var empNames = "";
        var del_idstr ="";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+ ",";
            //组装员工id的字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+ "-";
        });
        //去除多余的，
        empNames = empNames.substring(0,empNames.length-1);
        //去除多余的-
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除【"+empNames+"】吗?")){
            $.ajax({
                url:"emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentRecord);
                }
            });
        };
    });
</script>
</body>
</html>
