<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入C标签库  -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工管理系统</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
 -->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
	<!-- 修改员工的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名:</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱:</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control" id="email_update_input"
									placeholder="email@qq.com">
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别:</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M">男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F">女
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label">部门名:</label>
							<div class="col-sm-4">
							    <!-- 只需要提交部门的id即可 -->
								<select class="form-control" name="dId">
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
	


	<!-- 添加员工的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名:</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input"
									placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱:</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control" id="email_add_input"
									placeholder="email@qq.com">
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别:</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M" checked="checked">男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F">女
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label">部门名:</label>
							<div class="col-sm-4">
							    <!-- 只需要提交部门的id即可 -->
								<select class="form-control" name="dId">
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

	<!-- 显示页面 -->
	<div class="container">

		<!--标题  -->
		<div class="row">
			<div class="col-md-12">
				<h1>员工列表</h1>
			</div>
		</div>

		<!-- 按钮 -->
		<div class="row">
			<div>
				<div class="col-md-4 col-md-offset-8">
					<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
					<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
				</div>
			</div>
		</div>

		<!-- 显示表格数据  -->
		<div class="row">
			<div class="col-md-12">
				<!-- 使用table显示表格 -->
				<table class="table table-hover" id="emps_tables">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>员工姓名</th>
							<th>员工性别</th>
							<th>电子邮箱</th>
							<th>部门名</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条信息,在bootstrap组件右菜单栏右分页显示 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>

	<!-- 使用ajax的请求方式获取数据发送至页面  -->
<script type="text/javascript">
//总记录数
var totalRecord, currentPage;

// 1.页面加载完成以后,直接发送ajax请求,拿到分页数据
$(function() {
	// 去首页
	to_page(1);
});
function to_page(pn) {
	$.ajax({
		url : "${APP_PATH}/emps",
		data : "pn=" + pn,
		type : "GET",
		success : function(result) {
			// console.log(result);
			// 1.解析显示员工信息
			build_emps_table(result);
			// 2.解析显示分页信息
			build_page_info(result)
			// 3.解析显示分页条数据
			build_emps_nav(result)
		}
	});
}

// 解析显示员工信息
function build_emps_table(result) {
	// 在构建元素之前,清空table中的数据,否则新请求页面会append在原有的页面上
	$("#emps_tables tbody").empty();
	var emps = result.extend.pageInfo.list;
	$.each(emps, function(index, item) {
		// alert(item.empName);
		// 将员工的信息添加到页面表格中
		var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
		var empIdTd = $("<td></td>").append(item.empId);
		var empNameTD = $("<td></td>").append(item.empName);
		var genderTD = $("<td></td>").append(
				item.gender == "M" ? "男" : "女");
		var emailTD = $("<td></td>").append(item.email);
		var deptNameTd = $("<td></td>")
				.append(item.department.deptName);
		// 添加按钮,调用jQuery的addclass方法添加
		var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append(
				$("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
		// 给编辑按钮添加自定义属性表示员工的id
		editBtn.attr("edit-id",item.empId);
		var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append(
				$("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
		// 给编辑按钮添加自定义属性表示当前删除员工的id
		delBtn.attr("del_id",item.empId);
		var btnId = $("<td></td>").append(editBtn).append(" ").append(
				delBtn)
		// append方法执行完成后要返回原来的数据
		$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTD).append(
				genderTD).append(emailTD).append(deptNameTd).append(
				btnId).appendTo("#emps_tables tbody");
	});
}

// 解析显示分页信息
function build_page_info(result) {
	// 在新请求完成后清空原有的分页
	$("#page_info_area").empty();
	$("#page_info_area").append(
			"当前" + result.extend.pageInfo.pageNum + "页,总"
					+ result.extend.pageInfo.pages + "页,总"
					+ result.extend.pageInfo.total + "条记录");
	totalRecord = result.extend.pageInfo.total;
	currentPage = result.extend.pageInfo.pageNum;
}

// 解析显示分页条数据
function build_emps_nav(result) {
	// 在新请求完成后清空原有的分页条
	$("#page_nav_area").empty();
	// 连续显示首页,尾页,上一页,下一页
	var ul = $("<ul></ul>").addClass("pagination");

	var firstPageLi = $("<li></li>").append(
			$("<a></a>").append("首页").attr("href", "#"));
	var perPageLi = $("<li></li>").append(
			$("<a></a>").append("&laquo;"));
	// 判断页数中是否首页和上一页(这里表示没有首页和上一页,因此箭头指向不能点击)
	if (result.extend.pageInfo.hasPreviousPage == false) {
		firstPageLi.addClass("disabled");
		perPageLi.addClass("disabled")
	} else {
		// 为元素添加点击翻页的事件
		firstPageLi.click(function() {
			to_page(1);
		});
		perPageLi.click(function() {
			to_page(result.extend.pageInfo.pageNum - 1);
		});
	}

	var nextPageLi = $("<li></li>").append(
			$("<a></a>").append("&raquo;"));
	var lastPageLi = $("<li></li>").append(
			$("<a></a>").append("尾页").attr("href", "#"));
	// 判断是否有尾页和下一页(这里表示没有下一页和尾页)
	if (result.extend.pageInfo.hasNextPage == false) {
		nextPageLi.addClass("disabled");
		lastPageLi.addClass("disabled");
	} else {
		// 绑定事件
		nextPageLi.click(function() {
			to_page(result.extend.pageInfo.pageNum + 1);
		});
		lastPageLi.click(function() {
			to_page(result.extend.pageInfo.pages);
		});
	}

	// 添加首页和前一页的提示
	ul.append(firstPageLi).append(perPageLi);
	// 1,2,3,遍历给ul中添加页码提示
	$.each(result.extend.pageInfo.navigatepageNums, function(index,item) {
		var numLi = $("<li></li>").append($("<a></a>").append(item));
		if (result.extend.pageInfo.pageNum == item) {
			numLi.addClass("active");
		}
		numLi.click(function() {
			to_page(item);
		});
		ul.append(numLi);

	});
	// 添加下一页和尾页的提示
	ul.append(nextPageLi).append(lastPageLi);
	// 吧ul加入到nav元素中
	var navEle = $("<nav></nav>").append(ul);
	navEle.appendTo("#page_nav_area");

}

// 绑定添加员工事件,点击新增,弹出模态框
$("#emp_add_modal_btn").click(function() {
	// 发送ajax请求,查出部门名
	$("#empAddModal form")[0].reset();
	getDepts("#empAddModal select");
	// 弹出模态框
	$("#empAddModal").modal({
		backdrop : "static"
	});
});

// 查出所有的部门信息显示在下拉菜单
function getDepts(ele) {
	// 清空下拉列表重复信息
	$(ele).empty();
	$.ajax({
		url: "${APP_PATH}/depts",
		type: "GET",
		success: function(result) {
			console.log(result)
			// 显示部门信息在下拉列表中
			// $("#empAddModal select").append("")
			$.each(result.extend.depts,function() {
				var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
				optionEle.appendTo(ele)
			});
		}
	});
}

// 校验表单数据
function validate_add_form() {
	// 1.校验的数据,使用正则表达式 ---->姓名
	var empName = $("#empName_add_input").val();
	var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	if (!regName.test(empName)) {
		//alert输入错误的信息提示
		show_validate_msg("#empName_add_input","error","请输入2-5位中文用户名或6-16;位英文用户名");
		return false;
	} else {
		show_validate_msg("#empName_add_input","success","");
	}
	// 校验邮箱数据
	var email = $("#email_add_input").val();
	var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	if (!regEmail.test(email)) {
		// alert输入错误的邮箱格式提示信息,数据校验正确后清空之前的错误提示
		show_validate_msg ("#email_add_input","error","您输入的邮箱格式不正确");
		return false;
	} else {
		show_validate_msg ("#email_add_input","success","");
	}
	return true;
}

// 抽取校验成功后清空之前错误的提示
function show_validate_msg (ele,status,msg) {
	// 清除当前元素的数据状态
	$(ele).parent().removeClass("has-success has-error");
	$(ele).next("span").text("");
	if ("success" == status) {
		$(ele).parent().addClass("has-success");
		$(ele).next("span").text(msg);
	} else if("error" == status) {
		$(ele).parent().addClass("has-error");
		$(ele).next("span").text(msg);
	}
}

// 校验用户名是否可用
$("#empName_add_input").change(function(){
	// 发送ajax请求校验用户名是否可用
	var empName = this.value;
	$.ajax({
		url: "${APP_PATH}/checkuser",
		data: "empName = " + empName,
		type: "POST",
		success: function(result) {
			if(result.code == 100) {
				show_validate_msg ("#empName_add_input","success","");
				$("#emp_save_btn").attr("ajax-va","success");
			} else {
				show_validate_msg ("#empName_add_input","error","您输入的姓名不可用");
				$("#emp_save_btn").attr("ajax-va","error");
			}
		}
	});
});


// 绑定保存员工的方法事件
$("#emp_save_btn").click(function(){
	// 1.模态框中填写表单数据交给服务器保存,-->首先要对提交的数据进行及校验
	if (!validate_add_form()) {
		return false;
	}
	
	// 排除重复员工的表单提交
	if($(this).attr("ajax-va") == "error") {
		return false;
	}
	// 2.发送ajax请求保存员工
	$.ajax({
		url: "${APP_PATH}/emp",
		type: "POST",
		// alert($("#empAddModal form").serialize());打印要保存给服务器的序列化格式数据
		data: $("#empAddModal form").serialize(), 
		success: function(result) {
			// alert(result.msg); 显示保存成功
			// 1.关闭模态框
			$("#empAddModal").modal('hide');
			// 2.来到最后一页显示刚插入的数据,发送ajax显示最后一页
			to_page(totalRecord);
		}
	});
});

// 给更新按钮绑定事件
$(document).on("click",".edit_btn",function(){
	//alert("edit");
	// 弹出模态框,查出部门信息,显示部门列表
	getDepts("#empUpdateModal select");
	// 查出员工信息,
	getEmp($(this).attr("edit-id"));
	// 将员工的id传递给模态框的更新按钮
	$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
	$("#empUpdateModal").modal({
		backdrop : "static"
	});
});

/*
   按照id查找员工
 */
function getEmp(id) {
	$.ajax({
		url: "${APP_PATH}/emp/"+id,
		type: "GET",
		success: function(result) {
			//console.log(result); 控制台打印结果
			var empData = result.extend.emp;
			$("#empName_update_static").text(empData.empName);
			$("#email_update_input").val(empData.email);
			$("#empUpdateModal input[name=gender]").val([empData.gender]);
			$("#empUpdateModal select").val([empData.dId]);
		}
	});
}

/*为更新按钮绑定事件*/
$("#emp_update_btn").click(function(){
	// 验证邮箱是否合法
	var email = $("#email_update_input").val();
	var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	if (!regEmail.test(email)) {
		// alert输入错误的邮箱格式提示信息,数据校验正确后清空之前的错误提示
		show_validate_msg ("#email_update_input","error","您输入的邮箱格式不正确");
		return false;
	} else {
		show_validate_msg ("#email_update_input","success","");
	}
	// 保存更新的员工数据
	$.ajax({
		url: "${APP_PATH}/emp/"+ $(this).attr("edit-id"),
		type: "PUT",
		data: $("#empUpdateModal form").serialize(), // 支持put请求
		success: function(result) {
			 // alert(result.msg);
			 // 关闭修改对话框,回到本页面
			 $("#empUpdateModal").modal('hide');
			 // 返回到修改页面
			 to_pag(currentPage);
			 
		}
	});
	
});


/*
    单个删除员工
*/
$(document).on("click",".delete_btn",function(){  
	// 弹出是否确认删除对话框
	// alert($(this).parents("tr").find("td:eq(1)").text());
	var empId = $(this).attr("del_id");
	var empName = ($(this).parents("tr").find("td:eq(2)").text());
	if (confirm("确认要删除【"+empName+"】吗?")) {
		// 确认后发送ajax请求删除
		$.ajax({
			url:"${APP_PATH}/emp/"+ empId,
			type: "DELETE",	
			success: function(result) {
				// alert(result.msg);
				to_pag(currentPage);
			}
		});
		
	}
});
// 批量删除点击全选
$("#check_all").click(function(){
	// alert($(this).attr("checked"));
	$(".check_item").prop("checked",$(this).prop("checked"));
});

// 绑定单机事件
$(document).on("click",".check_item",function(){
	var flag = $(".check_item:checked").length==$(".check_item").length;
	$("#check_all").prop("checked",flag);
});

// 点击批量删除
$("#emp_delete_all_btn").click(function(){
	//$(".check_item:checked")
	var empNames = "";
	var del_idstr = "";
	$.each($(".check_item:checked"),function(){
		empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
		del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
	});
	// 去除删除员工的,和-
	empNames = empNames.substring(0, empNames.length-1);
	del_idstr = del_idstr.substring(0, empNames.length-1);
	if (confirm("确认删除【"+empNames+"】吗?")) {
		$.ajax({
			url: "${APP_PATH}/emp/"+ del_idstr,
			type: "DELETE",
			success: function(result) {
				//alert(result.msg);
				to_page(currentPage);
			}
		});
	}
});

</script>
</body>
</html>