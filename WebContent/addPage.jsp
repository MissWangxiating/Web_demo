<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>       
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.js"></script>
    <script src="js/functionc.js"></script>

    <script src="datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

    <script src="js/bootstrap.min.js"></script>
    <style>
        .mainbody{
            margin-left: 20px;
            margin-right: 20px;
            min-height: 400px;
        }
        .line{
            margin:0px;
            padding: 5px 30px 5px 15px;
            margin-left: 5px;
        }
        .line-blue{
            background-color: transparent;
            border-left: 5px solid #3c8dbc;
        }
    </style>
</head>
<body>
    <div class="mainbody">
        <div class="line line-blue">
            <strong>添加信息</strong>
        </div>
        <div class="col-md-4 col-md-offset-3">
        <table class="table table-hover">
            <tr>
                <td style="text-align: right" class="col-md-4">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;姓名
                </td>
                <td><input id="studentName" class="form form-control" type="text" placeholder="请输入姓名"></td>
            </tr>
            <tr>
                <td style="text-align: right" >
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;性别
                </td>
                <td >
                    <select id="studentSex" class="form form-control" palceholder="请选择性别">
                        <option vlaue="男">男</option>
                        <option value="女">女</option>   
                    </select>
                </td>
                <!-- 
                <td><input id="studentSex" type="text" placeholder="请输入性别"></td>
                 -->
            </tr>
            <tr>
                <td style="text-align: right" >
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;生日
                </td>
                
                <!-- 调用时间控件，方法一：直接用html5里的type属性设为date
                <td><input id="studentBirth" type="date"></td>
                -->
                 
                <td>
                    <input id="studentBirth" class="form form-control" type="text" placeholder="请输入生日年月日">
                </td>
                  
            </tr>
            <tr>
                <td style="text-align: right">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;籍贯
                </td>
                <td><input  id="studentPlace" class="form form-control" type="text" placeholder="请输入籍贯"></td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;简介
                </td>
                <!--  
                <td><input  id="studentIntro" type="text" class="form form-control" placeholder="请输入简介"></td>
                -->
                <!-- 采用文本域输入 -->
                <td>
                <textarea id="studentIntro" class="form form-control" placeholder="请输入简介" rows="3"></textarea>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;详细资料
                </td>
                <td><input  id="studentFile"  class="form form-control" type="file" placeholder="请添加文件"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                <button id="save"  class="btn btn-primary">添加</button>&nbsp;&nbsp;
                <button id="reset" class="btn btn-primary">重置</button>
                </td>
            </tr>
        </table>
        </div>
    </div>
</body>
<script>
    $(document).ready(function () {
    	
       // var now = new Date();

      // $("#birth").val(now) ;

       $('#studentBirth').datetimepicker({
           format: 'yyyy-mm-dd',   //日期格式，默认为‘mm/dd/yyyy’
           autoclose:true,       //表示选择一个日期后是否立即关闭此日期选择器 默认值:"flase"
           todayBtn : true,      //默认值 false 在日期选择器的底部，显示一个Today按钮以转到当天的日期
           language:'zh-CN',     // 表示时间或者月份的表达语言类型，此处为中文
           todayHighlight:true,  //高亮当前日期
           minView:2      //日期选择器能够提供的最精确的日期选择视图 ，默认值：0 hour
       });
       
       $("#studentFile").on('change',function(){
    	   var s = $("#studentFile").val();
    	   console.log(s);
    	   
       });
       
        /**********添加信息*********/
       $("#save").click(function(){
		    //获取到文本框的值
		    //var sId = $("#studentId").val();
		    var sName = $("#studentName").val();
		    var sSex = $("#studentSex").val();
		    var sBirth = $("#studentBirth").val();//新增日期
		    var sPlace = $("#studentPlace").val();//新增籍贯
		    var sIntro = $("#studentIntro").val();
		   // var sFile = $("#studentFile").val();//新增详细资料
		
		    //判断输入值是否满足输入的格式
		     if(sName==""||sName == null||sSex.length>=2||sIntro==""||sIntro == null||sBirth==""||sPlace=="")
		         {
		  	         alert("请补充完整信息！");
		         }
		     else{
			//生成json
				var obj ={};
				obj["name"] = sName;
				obj["sex"] = sSex;
				obj["birth"] = sBirth;//新增日期，具体参数参照后台？
				obj["place"] = sPlace;//新增籍贯，具体参数参照后台？
				obj["intro"] = sIntro;
				//obj["file"] = sFile; //新增详细资料，不知道这样获取是否正确？具体参数参照后台
				var objstr=JSON.stringify(obj); //这里是把javascript 转换成了json的字符串
				
				//console.log(objstr);
				
				//传值给后台
				$.ajax({
					url:encodeURI("AddServlet?addJson="+ objstr), 
					type:"POST",
					cache:false,
					dataType:"text",
					async:false,
					data:objstr,                    
					success: function(data){
						//console.log(data);
						alert("保存信息成功！");
						location.reload();
					},
					error: function(data){
					     alert("请重试！");	
					},
				});
					
		     };
	       });
       
       //重置信息
       $("#reset").click(function(){
    	   $("#studentName").val("");
		   $("#studentSex").val("");
		   $("#studentBirth").val("");
		   $("#studentPlace").val("");
		   $("#studentIntro").val("");
       });

    });

</script>
</html>