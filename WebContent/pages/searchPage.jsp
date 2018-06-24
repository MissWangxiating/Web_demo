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
    <link href="../css/bootstrap.min.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style>
        .mainbody{
            min-height: 400px;
            margin-left: 20px;
            margin-right: 20px;
        }
        .line{
            padding:5px 30px 5px 15px;
            margin-left:5px;
        }
        .line-blue{
            background-color: transparent;
            border-left:5px solid #3c8bdc;
        }
    </style>
</head>
<body>
    <div class="mainbody">
        <div class="line line-blue">
            <strong>搜索信息</strong>
        </div>
        <div>
            <span>请输入关键词：</span>
            <input id="keyword" type="text">&nbsp;&nbsp;
            <button id ="search" class="btn btn-primary btn-default">搜索</button>
        </div>
        <!-- 列表 -->
        <table class="table table-hover">
            <thead>
                <th>编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>生日</th>
                <th>籍贯</th>
                <th>简介</th>
                <th>详细资料</th>
            </thead>
            <tbody id="mytr">
                <tr>
                    <td>1</td>
                    <td>小二</td>
                    <td>男</td>
                    <td>1992-3-12</td>
                    <td>吉林长春</td>
                    <td>超级超级好的人</td>
                    <td>此处应为一个PDF文件</td>
                </tr>
            </tbody>
        </table>
        <!-- 分页视图 -->
        <div id="div_page" style="display:none" >
              <ul class="pagination">
              
              <li><a id="a_first">首页</a></li>
              <li><a id="a_up">上一页</a></li>
              <li><a id="present">第1页</a></li>
              <li><a id="a_down">下一页</a></li>
              <li><a id="a_end">尾页</a></li>
              <li><a id="total">共1页</a></li>
              </ul>     
         </div>
    </div>
</body>
<script>
$("document").ready(function(){
	var pagecount;
	
	getServlet(1);
	
	function getServlet(){
		var pageIndex = arguments[0];
		var FirstURL = encodeURI("ExportServlet?pageIndex="+ pageIndex);
		//var FirstURL = encodeURI("ExportServlet");
		$.ajax({
			url:FirstURL,
			type:"POST",
			dataType:"text",
			cache:false,
			async:false,
			success:function(result){
				var data = JSON.parse(result);
				pagecount = Math.ceil(data.num/5);
				$("#total").text("共"+pagecount+"页");
				$("#present").text("第"+pageIndex+"页");
			     
				var datalist = data.jsonArray;
				if(datalist.length!=0){
			        $("#mytr").empty();
		        };
		        $.each(datalist,function(i,item){
			        var $tr = $("<tr></tr>");
			        var $td = $("<td></td>");
			
			    $tr.append("<td id="+item.id+">"+((++i)+5*(pageIndex-1))+"</td>");//编号
			    $tr.append("<td>"+item.name+"</td>");//姓名 
			    $tr.append("<td>"+item.sex+"</td>");//性别
			    $tr.append("<td>"+item.xxx+"</td>");//生日 ,不知道后台命名是什么？
			    $tr.append("<td>"+item.xxx+"</td>");//籍贯，不知道后台命名是什么？
			    $tr.append("<td>"+item.intro+"</td>"); //简介
			    $tr.append("<td>"+item.xxxx+"</td>");//详细资料,不知道后台给的是啥？要怎么处理？具体的一个文件				    
			
			    
			
			    $("#mytr").append($tr);
			    });
		         $("#div_page").css({"display":"block"});
	           },
		});
			
	}
	
	/********************分页列表***************************/
	var pageIndex = 1; //判定当前页数
	//首页
	$("#a_first").click(function(){
		pageIndex = 1;
		getServlet(pageIndex);
		//console.log("进入首页");
	});
	//上一页
	$("#a_up").click(function(){
		if(pageIndex>1){
			pageIndex = pageIndex-1;
		    getServlet(pageIndex);
		   // console.log("进入上一页");
		}	
	});
	
	//下一页
	$("#a_down").click(function(){
		if(pageIndex<pagecount){
			pageIndex = pageIndex+1;
		    getServlet(pageIndex);
		    //console.log("进入下一页");
		}
		
		
	});
	
	//末页
	$("#a_end").click(function(){
		pageIndex = pagecount;
		getServlet(pageIndex);
		//console.log("进入尾页");
	});
	
	/*** 搜索信息  ***/
	$("#search").click(function(){
		var keys = $("#keyword").val();
		$.ajax({
			url:encodeURI("SelectServlet?name="+keys+"&pageIndex="+ pageIndex),//这里有问题。。。。
			type:"GET",
			dataType:"text",
			cache:false,
			success:function(result){
				var data=JSON.parse(result);
			
				$("#total").text("共"+pagecount+"页");
				$("#present").text("第"+pageIndex+"页");
			     
				var datalist = data.jsonArray;
				if(datalist.length!=0){
			        $("#mytr").empty();
		        }
				else{
					$("#mytr").empty();
					var $tr = $("<tr></tr>");
					$tr.append("<td>检索结果为空！！！</td>");
				    $("#mytr").append($tr);
				}
		        $.each(datalist,function(i,item){
			        var $tr = $("<tr></tr>");
			        var $td = $("<td></td>");
			
			    $tr.append("<td id="+item.id+">"+((++i)+5*(pageIndex-1))+"</td>");//编号
			    $tr.append("<td>"+item.name+"</td>");//姓名 
			    $tr.append("<td>"+item.sex+"</td>");//性别
			    $tr.append("<td>"+item.xxx +"</td>");//生日，具体看后台数据库里的数据名？
			    $tr.append("<td>"+item.xxx +"</td>");//籍贯，具体看后台数据库里的数据名？
			    $tr.append("<td>"+item.intro+"</td>");//简介
			    $tr.append("<td>"+item.xxxx +"</td>");//详细资料，具体看后台数据库里的数据名，应该需要转换？
			
			    $("#mytr").append($tr);
			    });
		         $("#div_page").css({"display":"block"});
			},
		    error: function(){
		    	alert("检索请求未响应！");
		    }
		    	
		});
	});
	
});


</script>
</html>