<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

/*
请求参数通过url中地址传过来的
这里不能用EL表达式直接取，因为EL表达式是针对域对象取值的，而url地址栏的参数和值是跟随请求头发送过来的
这个参数并没有保存在域对象中，而是由tomcat为我们保存到了一个地方
一种方法是取得每个参数后用表达式脚本输出
String fullname = request.getParameter("fullname");
String id = request.getParameter("id");
String appellation = request.getParameter("appellation");
String company = request.getParameter("company");
String owner = request.getParameter("owner");

如果想要用EL表达式取值则需要用
	${param.参数名}
如果前面不加param，则会默认在域对象中取值，这是找不到的
*/

%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

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

		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});

		//为放大镜图标绑定事件，打开搜索市场活动的模态窗口
		$("#openSearchModalBtn").click(function () {
			$("#searchActivityModal").modal("show");
		})

		//为搜索操作的模态窗口绑定事件，绑定并展现市场活动列表的操作
		$("#aname").keydown(function (event) {
			if(event.keyCode == 13){
				$.ajax({
					url: "workbench/clue/getActivityListByName.do",
					data: {
						"aname": $.trim($("#aname").val())
					},
					dataType: "json",
					type: "get",
					success: function (data) {
						/*
						data
							[{市场活动1},{市场活动2},...]
						 */
						let html = "";
						$.each(data, function (i,n) {
							html += '<tr>';
							html += '<td><input type="radio" name="xz" value="'+n.id+'"/></td>';
							html += '<td id="'+n.id+'">'+n.name+'</td>';
							html += '<td>'+n.startDate+'</td>';
							html += '<td>'+n.endDate+'</td>';
							html += '<td>'+n.owner+'</td>';
							html += '</tr>';
						})
						$("#activitySearchBody").html(html);
					}
				})
				return false;
			}
		})

		//为提交市场活动按钮绑定事件，填充活动源（市场活动的名字和id）
		$("#submitActivityBtn").click(function () {
			//取得选中的id
			let id = $("input[name=xz]:checked").val();
			//取得选中市场活动的名字
			let name = $("#"+id).html();
			//将信息写入文本框和隐藏域
			$("#activityName").val(name);
			$("#activityId").val(id);

			//关闭模态窗口
			$("#searchActivityModal").modal("hide");
		})

		//为转换按钮绑定一个事件，执行线索的转换操作
		$("#convertBtn").click(function (){
			/*
			提交请求到后台，执行线索转换的操作，传统请求就足够了
			请求结束后最终响应回到线索列表

			根据为客户创建交易的复选框有没有选中，来判断是否创建交易
			 */
			if($("#isCreateTransaction").prop("checked")){
				//如果需要创建交易，不仅要传递clueId，还要传递交易表单中的信息
				//可以在跳转地址后面用?挂载参数，但是参数一旦增多或长度变长，这种传统挂参数的方式可能失效，而拼接字符串很麻烦

				//为了避免我们在网址后面手动挂载参数，我们可以通过提交表单来发出传统请求，而且表单能用post请求
				//表单是name就是参数名，value参数值

				//提交表单
				$("#tranForm").submit();
			}
			else{
				//在不需要创建交易的时候，传递clueId即可
				window.location.href="workbench/clue/convert.do?clueId=${param.id}";
			}
		})
	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" id="aname" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="activitySearchBody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>
							<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>--%>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="submitActivityBtn">提交</button>
				</div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<%--用表达式脚本输出，或者用EL表达式取值--%>
		<%--<h4>转换线索 <small><%=fullname%><%=appellation%>-<%=company%></small></h4>--%>
		<h4>转换线索 <small>${param.fullname}${param.appellation}-${param.company}</small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：${param.company}
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：${param.fullname}${param.appellation}
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
	
		<form id="tranForm" action="workbench/clue/convert.do" method="post">

          <%--因为前台是直接提交的，后台并不知道提交的信息是有交易还是没有交易，因此这里做一个标记，有标记了说明需要创建交易--%>
		  <input type="hidden" name="flag" value="a">

		  <input type="hidden" name="clueId" value="${param.id}">

		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney" name="money">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName" name="name">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control time" id="expectedClosingDate" name="expectedDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage"  class="form-control" name="stage">
		    	<option></option>
		    	<c:forEach items="${stage}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="openSearchModalBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="activityName" placeholder="点击上面搜索" readonly>
			  <input type="hidden" id="activityId" name="activityId">
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b>${param.owner}</b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input class="btn btn-primary" type="button" value="转换" id="convertBtn">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" type="button" onclick="window.history.back();" value="取消">
	</div>
</body>
</html>