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
                url: "workbench/transaction/getCharts.do",
                data: {

                },
                dataType: "json",
                type: "get",
                success: function (data) {
                    /*
                    data
                        ["total":总条数,"dataList":{value: ,name},{},...]
                     */


                    //基于准备好的dom，初始化echarts的实例
                    let myChart = echarts.init(document.getElementById("main"));
                    //指定图]的样式和属性
                    let option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '数据总量: ' + data.total
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b} : {c}%'
                        },
                        toolbox: {
                            feature: {
                                dataView: {readOnly: false},
                                restore: {},
                                saveAsImage: {}
                            }
                        },
                        calculable: true,
                        series: [
                            {
                                name:'漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                bottom: 60,
                                width: '80%',
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data:
                                data.dataList
                               /* [
                                    {value: 60, name: '访问'},
                                    {value: 40, name: '咨询'},
                                    {value: 20, name: '订单'},
                                    {value: 80, name: '点击'},
                                    {value: 100, name: '展现'}
                                ]*/
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
