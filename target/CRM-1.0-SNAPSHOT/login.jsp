<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script>
	$(function () {

		//如果当前窗口不是顶层窗口，则将当前窗口设置为顶层窗口
		//这种情况是当用户在页面上时，如果后端重启了服务器，那么用户登录失效，此时用户却还停留在登录后的首页
		//首页由两部分组成，左边是一个项目栏，每个栏关联一个超链接，链接会在右边的内置网页框(iframe)中被打开
		//此时登录失效，点击右边的项目栏地址会被过滤器拦截并重定向到登录页面
		//但是这个登录页面却会在内置网页框中被打开，而不是在整个页面被打开
		//内置的网页框不是顶层页面，加载登录页面的内置网页框的内容会被赋予顶层窗口，从而整个页面进入登录页面
		if(window.top != window){
			window.top.location=window.location;
		}

		//页面加载完成后，将用户文本框中上次保留的文本清空，val是文本框内容，html是标签内容
		$("#loginAct").val("");
		$("#loginPwd").val("");

		//在页面加载完完毕后，让用户的文本框自动获得焦点
		$("#loginAct").focus()

		//为登录按钮绑定事件执行登录操作
		$("#submitBtn").click(function () {
			login();
		})

		//为当前登录页面的窗口绑定键盘事件，使点击回车后可以登录，event参数可以获得当前敲击了哪个键盘
		$(window).keydown(function (event) {
			//回车按键对应的码值为13
			if(event.keyCode == 13) {
				login();
			}

		})
	})

	//成员函数可以写在 $(function(){}) 外面，也可以写在里面
	//但是写在里面当 $(function(){}) 里面内容过多时，可能会出现问题
	function login()
	{
		//验证账号密码不为空
		//取得账号密码，需要将文本中左右空格去掉，使用$.trim(文本)
		let loginAct = $.trim($("#loginAct").val());
		let loginPwd = $.trim($("#loginPwd").val());
		if(loginAct == "" || loginPwd == ""){
			$("#msg").html("账号密码不能为空");
			//如果账号密码为空，则需要及时强制终止该方法
			return false;
		}
		//在后台验证账号密码
		$.ajax({
			url:"settings/user/login.do",
			data:{
				"loginAct":loginAct,
				"loginPwd":loginPwd

			},
			type:"post",
			dataType:"json",
			success:function (data){
				/*
				data
					{"success":true/false,"msg":错误原因}
				*/
				if(data.success){
					//跳转到工作台的初始页面，即欢迎页面
					window.location.href="workbench/index.jsp";
				}
				else{
					$("#msg").html(data.msg);
				}
			}
		})
	}
</script>

</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/login.png" style="width: 135%; height: 135%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM</div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.jsp" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="loginAct">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="loginPwd">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
							<%--提示错误信息的位置--%>
							<span id="msg" style="color: red"></span>
						
					</div>
					<%--
					按钮写在form表单中，默认的行为就是提交表单，要将按钮的类型设置为button
					这样按钮点击触发的行为将由我们手动的js代码决定
					--%>
					<button type="button" id="submitBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>