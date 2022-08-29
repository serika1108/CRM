<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script src="ECharts/echarts.min.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>

    <script>
        $(function (){
            //页面加载完毕后绘制统计图表
            getCharts();
        })

        function getCharts() {

            $.ajax({
                url: "workbench/activity/getCharts.do",
                data: {

                },
                dataType: "json",
                type: "get",
                success: function (data) {

                    //基于准备好的dom，初始化echarts的实例
                    let myChart = echarts.init(document.getElementById("main"));
                    //指定图]的样式和属性
                    option = {
                        title: {
                            text: '市场活动折线图'
                        },
                        toolbox: {
                            feature: {
                                dataView: {readOnly: false},
                                restore: {},
                                saveAsImage: {}
                            }
                        },
                        xAxis: {
                            type: 'category',
                            data: data.time
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [
                            {
                                data: data.value,
                                type: 'line'
                            }
                        ]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                }
            })
        }

    </script>

</head>
<body>
<div id="main" style="width: 800px; height: 600px;"></div>
</body>
</html>
