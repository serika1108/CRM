<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<%--加载bootstrap的日历的插件--%>
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<%--注意必须先加载jQuery和bootstrap，再加载日历，否则会出错，因为日历是基于jQuery和bootstrap写成的--%>
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>


<script type="text/javascript">

	$(function(){

		//日历的jQuery框架选择框
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,  //关闭的按钮
			todayBtn: true,  //显示今天的日期
			pickerPosition: "bottom-left"
		});
		
		//为创建按钮绑定事件，为添加操作绑定模态窗口
		$("#addBtn").click(function () {

			//对于需要操作的模态窗口的jquery对象，调用model方法，为该方法传递参数
			//show是打开，hide是关闭
			//$("#createActivityModal").modal("show");

			//通过后台，取得用户信息列表，为所有者创建下拉框
			$.ajax({
				url : "workbench/activity/getUserList.do",
				data : {
					/*查所有人名信息，不需要额外参数传递给后台*/
				},
				type : "get",
				dataType:"json",
				success : function (data){

					/*
					date
						[{用户1}，{用户2}，...]
					*/
					let html = "<option></option>";
					//遍历json数组，每一个n都是每一个user对象
					$.each(data, function (i,n){
						html += "<option value='" + n.id + "'>"+ n.name +"</option>";
					});

					//通过id找到select复选框，在里面添加拼接好的option选项
					$("#create-owner").html(html);

					//将当前登录的用户设置为下拉框的默认选项
					//option标签的value属性用于指定唯一的option，相当于id
					//jquery提供了.val()方法，可以获取当前指定标签的内容，这个内容是可读可写的
					//在.val()中传入指定option的value即可完成默认值的选择

					//获取当前用户id，但是注意在js中使用el表达式，el表达式一定要套用在字符串中
					let id = "${sessionScope.user.id}";
					$("#create-owner").val(id)

					//处理完下拉框打开模态窗口
					$("#createActivityModal").modal("show");
				}
			})
		})

		//为保存按钮绑定事件执行添加操作
		$("#saveBtn").click(function () {
			$.ajax({
				url: "workbench/activity/save.do",
				data: {
					"owner" : $.trim($("#create-owner").val()),
					"name" : $.trim($("#create-name").val()),
					"startDate" : $.trim($("#create-startDate").val()),
					"endDate" : $.trim($("#create-endDate").val()),
					"cost" : $.trim($("#create-cost").val()),
					"description" : $.trim($("#create-description").val()),
				},
				type: "post",
				dataType: "json",
				success(data){
					/*
					data
						{"success":true/false}
					*/
					if(data.success){
						//添加成功
						//局部刷新市场活动列表

						/*
						清空添加操作模态窗口中上次的残留数据
						需要注意的是，表单的jQuery对象在idea里提供了重置reset方法，但这个方法是无效的
						$("#activityAddForm").reset();
						但是jQuery没有提供重置方法，原生dom对象提供了重置方法

						jQuery转dom：jQuery对象[下标]
						dom转jQuery：$(dom)

						*/
						$("#activityAddForm")[0].reset();

						//关闭添加操作的模态窗口
						$("#createActivityModal").modal("hide");

						/*
						页码组件中，每页的记录数的可以更改的
						需要注意，添加后的分页应该不是从第一页开始，并且每页保持两条记录
						应该停留在当前页码，而且每页的记录数保持不变，因此像下面这样把分页信息写死
							pageList(1,2);

						使用bootstrap提供的框架：
						pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
								,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

						$("#activityPage").bs_pagination('getOption', 'currentPage')
							表示操作后停留在当前页码
						$("#activityPage").bs_pagination('getOption', 'rowsPerPage')
							表示操作后维持已经设置好的每页记录数
						这两个参数是bootstrap框架为我们提供的，直接使用即可

						添加操作执行后，应该停留在第一页，并且每页的数据条数保持不变
						*/
						pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

					}
					else{
						alert("添加市场活动失败");
					}
				}
			})
		})

		//为查询按钮绑定事件，触发pageList方法
		$("#searchBtn").click(function () {

			/*
            每次点击查询按钮，应该将搜索框信息保存到隐藏域中
             */
			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-startDate").val($.trim($("#search-startDate").val()));
			$("#hidden-endDate").val($.trim($("#search-endDate").val()));

			pageList(1, 2);

		})

		//页面加载完毕后触发分页方法
		pageList(1, 2);

		//为全选框绑定事件，触发全选操作
		$("#qx").click(function () {
			//选择所有name是xz的input框
			//prop函数有两个参数，第一个参数用于指定属性，第二个参数指定为这个属性赋予的值
			$("input[name=xz]").prop("checked", this.checked);
		})

		/*
		应该有反向操作，即两个选项被选中时，全选框也被选中
		以下做法是错误的，因为动态生成的元素是不能够以普通绑定事件的形式来进行操作
		$("input[name=xz]").click(function () {})
		动态生成元素用on方法来触发事件
		语法：
			$(需要绑定元素的有效外层元素，即静态标签).on(绑定事件的方式，需要绑定元素的jquery对象，回调函数)
		 */
		$("#activityBody").on("click",$("input[name=xz]"),function () {
			//当所有单选框的数量等于被选中的单选框的数量时，勾选全选框
			//为选择框的checked赋予布尔值即可达到选择的效果
			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
		})

		//为删除按钮绑定事件，执行市场活动的删除操作
		$("#deleteBtn").click(function () {

			//找到选中的jquery对象
			let $xz =  $("input[name=xz]:checked");
			if($xz.length==0) {
				alert("请选择需要删除的记录");
			}
			//如果选中了则可能是一条，可能是多条,jquery对象是dom对象的数组，需要遍历jquery对象
			else{

				if(confirm("你要删除所删除的记录吗 ? "))
				{
					//拼接要删除的id参数
					let param = "";
					for(let i=0; i<$xz.length; i++)
					{
						param += "id="+$($xz[i]).val();

						//如果不是最后一个元素则需要在后面追加一个 &
						if(i<$xz.length-1){
							param+="&";
						}
					}

					//alert(param);
					$.ajax({
						url: "workbench/activity/delete.do",
						data: param,
						type: "post",
						dataType: "json",
						success: function (data) {

							/*
                            data
                                {"success":true/false}
                             */
							if(data.success){
								//删除成功后应该停留在第一页并维持当前页的记录数
								pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

							}
							else{
								alert("删除市场活动失败")
							}
						}
					})
				}
			}
		})

		//为修改按钮绑定事件，打开修改操作的模态窗口
		$("#editBtn").click(function () {

			let $xz = $("input[name=xz]:checked");

			if($xz.length == 0){
				alert("请选择需要的修改记录");
			}
			else if($xz.length > 1){
				alert("只能同时修改一条记录")
			}
			else{
				//分支到达这里则一定只选中了一条记录，因此直接取值即可
				let id = $xz.val();

				$.ajax({
					url: "workbench/activity/getUserListAndActivity.do",
					data: {
						"id": id
					},
					dataType: "json",
					type: "get",
					success: function (data) {
						/*
						data
							用户列表
							市场活动对象

							{"uList":[{用户1}，{用户2}，...]，"a":市场活动记录}
						 */
						//处理所有者下拉框
						let html = "<option></option>";
						$.each(data.uList, function (i,n) {

							html += "<option value='" + n.id + "'>" + n.name + "</option>";

						})
						$("#edit-owner").html(html);

						//处理单条activity
						$("#edit-id").val(data.a.id);
						$("#edit-name").val(data.a.name);
						$("#edit-owner").val(data.a.owner);
						$("#edit-startDate").val(data.a.startDate);
						$("#edit-endDate").val(data.a.endDate);
						$("#edit-cost").val(data.a.cost);
						$("#edit-description").val(data.a.description);

						//所有值填写完成后打开模态窗口
						$("#editActivityModal").modal("show");
					}
				})
			}

		})

		//为更新按钮绑定事件，执行市场活动修改操作
		$("#updateBtn").click(function () {

			$.ajax({
				url: "workbench/activity/update.do",
				data: {
					"id" : $.trim($("#edit-id").val()),
					"owner" : $.trim($("#edit-owner").val()),
					"name" : $.trim($("#edit-name").val()),
					"startDate" : $.trim($("#edit-startDate").val()),
					"endDate" : $.trim($("#edit-endDate").val()),
					"cost" : $.trim($("#edit-cost").val()),
					"description" : $.trim($("#edit-description").val()),
				},
				type: "post",
				dataType: "json",
				success: function (data){
					/*
					data
						{"success":true/false}
					*/
					if(data.success){
						//修改成功，局部刷新市场活动列表
						/*
						修改操作后应该停留在当前页并且维持每页的记录数
						pageList(1,2);
						 */
						pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
								,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
						//关闭添加操作的模态窗口
						$("#editActivityModal").modal("hide");
					}
					else{
						alert("修改市场活动失败");
					}
				}
			})
		})

	});



	/*

	对于所有的关系型数据库，做前端分页操作的基础组件是pageNo和pageSize，分别表示页码和每页的记录数

	pageList方法发出ajax请求到后台，从后台取得最新的市场活动信息列表数据
	通过响应回来的数据进行局部刷新活动信息列表

	我们在哪些情况下需要分页刷新列表？
		点击左侧菜单中市场活动超链接时
		添加、修改、删除市场活动后，需要刷新市场活动列表
		点击查询按钮时需要刷新列表
		点击分页组件时需要刷新

		以上定义了六个操作，这六种操作执行完后都要刷新列表
	*/

	function pageList(pageNo, pageSize){

		//每次分页就对数据进行了操作，这时全选的复选框如果选中则需要修改状态
		$("#qx").prop("checked", false);

		/*
		注意这里有个问题，ajax请求获取了前端所有可能的数据
		例如我搜索框没有输入了筛选条件但是没有点击查询，此时点击下面的分页，例如下一页
		ajax却获得了所有的参数，将搜索框的残留筛选条件也获取到了并传递给了后端进行条件查询
		因此我们需要在每次查询后保存当前查询的内容，如果用户不点击搜索，应该一直维持这个筛选条件
		*/

		//查询前将隐藏域的信息取出来重新赋予到搜索框
		$("#search-name").val($.trim($("#hidden-name").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-startDate").val($.trim($("#hidden-startDate").val()));
		$("#search-endDate").val($.trim($("#hidden-endDate").val()));
		$.ajax({
			url: "workbench/activity/pageList.do",
			data: {
				"pageNo": pageNo,
				"pageSize": pageSize,
				"name": $.trim($("#search-name").val()),
				"owner": $.trim($("#search-owner").val()),
				"startDate": $.trim($("#search-startDate").val()),
				"endDate": $.trim($("#search-endDate").val()),
			},
			dataType: "json",
			type: "post",
			success: function (data){
				/*
				市场活动信息列表
				data
					我们需要的：
					[{市场活动1},{市场活动2},...]
					bootstrap分页插件需要的：查询的总记录数

					{"total":总数，"dataList":[{市场活动1},{市场活动2},...]}
				 */

				let html = "";
				//每一个n就是一个市场活动对象
				$.each(data.dataList, function (i,n) {

					//标签里面用的双引号，因此外面用单引号
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.id+'" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.do?id='+n.id+'\';">'+n.name+'</a></td>';
					//注意表中owner存的是用户的uuid，不是名字，需要在后台转换
					html += '<td>'+n.owner+'</td>';
					html += '<td>'+n.startDate+'</td>';
					html += '<td>'+n.endDate+'</td>';
					html += '</tr>';

				})
				$("#activityBody").html(html);

				//计算总页数
				let totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;

				//数据处理完毕后，结合分页插件，对前端展现分页信息
				$("#activityPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					//该回调函数在点击分页组件时触发
					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});

			}
		})
	}
	
</script>
</head>
<body>

	<input type="hidden" id="hidden-name"/>
	<input type="hidden" id="hidden-owner"/>
	<input type="hidden" id="hidden-startDate"/>
	<input type="hidden" id="hidden-endDate"/>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="activityAddForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<%--同时为class加入多项信息，用空格分隔--%>
								<input type="text" class="form-control time" id="create-startDate">
							</div>
							<label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<%--
					data-dismiss
						表示关闭模态窗口
					--%>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">

						<input type="hidden" id="edit-id"/>
					
						<div class="form-group">
							<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
                            <label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startDate" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate">
							</div>
							<label for="edit-endDate" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<%--
								文本域textarea：
									一定要以标签对的形式存在，而且一对标签要紧挨着，中间的空格都将被认为是文本域中的内容
									textarea也属于表单元素的范畴，对textarea取值和赋值要用val()方法，而不是html()方法
								--%>
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input type="text" class="form-control time" id="search-startDate" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input type="text" class="form-control time" id="search-endDate">
				    </div>
				  </div>
				  
				  <button type="button" id="searchBtn" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
					<%--

					创建按钮有两个属性值：
					data-toggle="modal" 表示点击该按钮，打开一个模态窗口
					data-target="#createActivityModal" 表示要打开哪个模态窗口
					这里通过属性值写在button里，问题在于这样无法对按钮功能进行扩充，一旦点击按钮就会触发模态窗口，而不能做其他事情
					所以开发中对于触发模态窗口的操作不能写死在元素中，应该由我们自己写js代码来操控

					--%>
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">
						<%--<tr class="active">
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
                            <td>2020-10-10</td>
                            <td>2020-10-20</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>