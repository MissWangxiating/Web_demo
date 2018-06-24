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
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <script src="../js/jquery.js"></script>
    <script src="../js/functionc.js"></script>

    <script src="../datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="../datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

    <script src="../js/bootstrap.min.js"></script>
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
        <table class="table table-hover">
            <tr>
                <td style="text-align: right" >
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;姓名
                </td>
                <td><input id="studentName" type="text" placeholder="请输入姓名"></td>
            </tr>
            <tr>
                <td style="text-align: right" >
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;性别
                </td>
                <td><input id="studentSex" type="text" placeholder="请输入性别"></td>
            </tr>
            <tr>
                <td style="text-align: right" >
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;生日
                </td>
                <!-- 调用时间控件，方法一：直接用html5里的type属性设为date-->
                <td><input  id="studentBirth"  type="date" ></td>
                <!--  
                <td>
                    <input id="birth" value="" type="text" placeholder="请输入生日年月日">
                </td>
                  -->
            </tr>
            <tr>
                <td style="text-align: right">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;籍贯
                </td>
                <td><input  id="studentPlace" type="text" placeholder="请输入籍贯"></td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;简介
                </td>
                <td><input  id="studentIntro" type="text" placeholder="请输入简介"></td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <span class="glyphicon glyphicon-hand-right"></span>
                    &nbsp;详细资料
                </td>
                <td><input  id="studentFile" type="file" placeholder="请添加文件"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                <button id="save" type="button" class="btn btn-primary">添加</button>&nbsp;&nbsp;
                <button>重置</button>
                </td>
            </tr>
        </table>
    </div>
</body>
<script>
    $("document").ready(function () {
        /**
    	var now = new Date();

       $("#birth").val(now) ;

       $("#birth").datetimepicker({
           format: 'yyyy-mm-dd',
           autoclose:true,
           todayBtn : true,
           language:'zh-CN',
           todayHighlight:true,
           minView:2
       });**/
       
        /**********添加信息*********/
       $("#save").click(function(){
		    //获取到文本框的值
		    //var sId = $("#studentId").val();
		    var sName = $("#studentName").val();
		    var sSex = $("#studentSex").val();
		    var sBirth = $("#studentBirth").val();//新增日期
		    var sPlace = $("#studentPlace").val();//新增籍贯
		    var sIntro = $("#studentIntro").val();
		    var sFile = $("#studentFile").val();//新增详细资料
		    console.log(sFile);
		
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
				obj["xxx"] = sBirth;//新增日期，具体参数参照后台？
				obj["xxx"] = sPlace;//新增籍贯，具体参数参照后台？
				obj["intro"] = sIntro;
				obj["xxx"] = sFile; //新增详细资料，不知道这样获取是否正确？具体参数参照后台
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

    });

</script>
</html>