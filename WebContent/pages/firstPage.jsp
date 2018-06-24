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
    <style>
        .mainbody{
            min-height: 400px;
            margin-left: 20px;
            margin-right: 20px;
        }

        .line{
            margin:0;
            padding: 5px 30px 5px 15px; /*上右下左*/
            margin-left: 5px ;
        }
        .line-blue{
            background-color: transparent;/*清除背景色，设为透明色*/
            border-left:5px solid #3c8dbc;
        }
    </style>
</head>
<body>
  <div class="mainbody">
     <div class="line line-blue">
         <strong> 详细信息</strong>
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
             <th>修改</th>
             <th>删除</th>
         </thead>
         <tbody id="mytr">
             <tr>
                 <td>1</td>
                 <td>小二</td>
                 <td>男</td>
                 <td>1992-3-12</td>
                 <td>吉林长春</td>
                 <td>超级超级好的人</td>
                 <td><a>此处应为一个PDF文件</a></td>
                 <td><a data-toggle='modal' href='#myModal'><span class='glyphicon glyphicon-edit'></span></a></td>
                 <td><a><span class="glyphicon glyphicon-trash"></span></a></td>
             </tr>

         </tbody>
     </table>
     
      <!-- 分页视图 -->
          <div id="div_page" style="display:none">
              <ul class="pagination">
              
              <li><a id="a_first">首页</a></li>
              <li><a id="a_up">上一页</a></li>
              <li><a id="present">第1页</a></li>
              <li><a id="a_down">下一页</a></li>
              <li><a id="a_end">尾页</a></li>
              <li><a id="total">共1页</a></li>
       
              </ul>            
              
          </div>
          
          <!-- Modal 修改信息模态框 -->
          <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                  <div class="modal-content">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                          <h4 class="modal-title" id="myModalLabel">个人信息修改</h4>
                      </div>
                      <div class="modal-body">
                          <table class="table">
                          <tr>
                          <td style="text-align:right">姓名：</td><td><input id="Xname" type="text"></td>
                          </tr>
                          <tr>
                          <td style="text-align:right">性别：</td><td><input id="Xsex" type="text"></td>
                          </tr>
                          <!-- 新增信息 -->
                          <tr>
                          <td style="text-align:right">生日：</td><td><input id="Xbirth" type="text"></td>
                          </tr>
                          <tr>
                          <td style="text-align:right">籍贯：</td><td><input id="Xplace" type="text"></td>
                          </tr>
                          <!-- 新增信息 结束-->
                          <tr>
                          <td style="text-align:right">简介：</td><td><input id="Xinfor" type="text"></td>
                          </tr>
                          <!-- 新增信息 -->
                          <tr>
                          <td style="text-align:right">详细资料：</td><td><input id="Xfile" type="file"></td>
                          </tr>
                          <!-- 新增信息结束 -->
                          </table>
                      </div>
                      <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                      <button id="Xsave" type="button" class="btn btn-primary">保存</button>
                      </div>
                  </div>
              </div>
          </div>
          
  </div>
</body>   
<script>
    $("document").ready(function(){
    	 /***************页面加载时同时在页面上显示数据***************/
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
				    $tr.append("<td name=change_"+item.id+"><a data-toggle='modal' href='#myModal'><span class='glyphicon glyphicon-edit'></span></a></td>");//修改
				    $tr.append("<td name=del_"+item.id+"><a><span class='glyphicon glyphicon-trash'></span></a></td>");//删除
				    
				
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
		
		/****************************删除数据*********************************/
		$("#mytr").on("click","td[name^='del_']",function(){
			console.log("启动删除！");
			var childs =$(this).parent().children()
			var del_id =childs[0].getAttribute("id");
			//console.log(del_id);
			var flag;
			 flag = window.confirm("你确定要删除这个信息？");
			 if(flag){
				 var data=this.id;
				 $.ajax({
					 url:encodeURI("DelServlet?delid="+del_id),
					type:"GET",	
			    dataType:"text",
			       cache:false, 
			       async: false,
			       success:function(result){
			    	   $(this).parent().remove();
					   alert("删除成功!");
					   location.reload();
					 }, 
			        error:function(){
			        	alert("删除失败！");
			        }
				 });
			 };
		});
		
		/****************************修改信息***********************/
	    $("#mytr").on("click","td[name^='change_']",function(){
		//把表格中的值传到模态框里去
		var childs = $(this).parent().children();
	    SxId = childs[0].getAttribute("id");
		console.log(SxId);
		$("#Xname").val(childs[1].innerHTML);
		$("#Xsex").val(childs[2].innerHTML);
		$("#Xbirth").val(childs[3].innerHTML);// 新增时间
		$("#Xplace").val(childs[4].innerHTML);// 新增籍贯
		$("#Xinfor").val(childs[5].innerHTML);
		$("#Xfile ").val(childs[6].innerHTML); //新增详细资料，不知道这样获取是否正确
	});	
		//保存修改的信息
	    $("#Xsave").click(function(){
			var Sxname = $("#Xname").val();
			var Sxsex = $("#Xsex").val();
			var Sxbirth =$("#Xbirth").val();  //新增时间
			var Sxplace =$("#Xplace").val();   //新增籍贯
			var Sxinfor = $("#Xinfor").val();
			var Sxfile = $("#Xfile").val();    //新增详细资料，不知道着那个获取是否正确？
			console.log(Sxname);
			console.log(Sxsex);
			console.log(Sxinfor);
			
			if(Sxname==""||Sxsex==""||Sxinfor=="" ||Sxbirth==""||Sxplace==""){
				alert("请修改完整信息！");
			}
			else{
				var sobj ={};
				sobj["id"] = SxId;
				sobj["name"] = Sxname;
				sobj["sex"] = Sxsex;
				sobj["XXX"] = Sxbirth;//新增日期，括号内具体参数，要参照后台数据库对它的命名？
				sobj["XXX"] = Sxplace;//新增籍贯，括号内具体参数，要参照后台数据库对它的命名？
				sobj["intro"] = Sxinfor;
				sobj["XXX"] = Sxfile; //新增详细资料，不知道这个是否正确 ，应该是要转换的，后台如何处理？
				
				var sobjstr = JSON.stringify(sobj);
				console.log("修改传过去的json为"+sobjstr);
				
				$.ajax({
					url:encodeURI("ChangeServlet?changeJson="+ sobjstr),
					type:"POST",
					cache:false,
					dataType:"text",
					success:function(){
						alert("修改成功！");
						//$("#mymodal").modal("hide");	
						location.reload();
					},
					error:function(){
						alert("修改失败，请重试！");
					}
				});	
			}
		});	
    });
</script>

</html>