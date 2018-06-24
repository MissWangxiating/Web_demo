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
    <title>首页</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        body{
            overflow-x: hidden !important;

            min-height: 100%;
            background-color: #f9f9f9;
        }
        .logo{
            float:left;
            width:220px;
            background-color: #3c8dbc;
            color:#ffffff;
            font-size: 20px;
            font-family:"Microsoft Sans Serif";
            line-height: 50px;
            text-align: center;
            height: 50px;
            display: block;
        }

        .wrapper{
            margin-top: 50px;
            min-height: 100%;
        }
        .wrapper:before ,.wrapper:after{
            display: table;
            content: "";
        }
        .wrapper:after{
            clear: both;
        }

        .left-side,.right-side{
            min-height: 100%;
            display: block;
        }
        .right-side{
            background-color: #ffffff;
            margin-left: 220px;
        }
        .left-side{
            position: absolute;
            width: 220px;
            top:50px;
            background-color: #8c8c8c;


        }
        a{

            cursor: pointer;

        }
        a:hover,a:active,a:focus{
            outline: none;
            text-decoration: none;


        }
        .sidebar{
            margin-bottom: 5px;
        }
        .sidebar .sidebar-menu{
            list-style:none;
            margin: 0;
            padding: 0;
        }
        .sidebar .sidebar-menu>li{
            margin:0;
            padding:0;
        }
        .sidebar .sidebar-menu>li>a{
            color:#f5f5f5;
            font-weight: bold;
            padding:12px 5px 12px 15px;
            display: block;
        }
        .sidebar .sidebar-menu>li>a:hover,a:active,a:focus{
            color:#72afd2;
            background-color: #ffffff;
        }

    </style>
    <script>
        $(document).ready(function () {
           $("#contentM").load("pages/firstPage.jsp") ;


           $("#addPage").click(function () {
               $("#contentM").empty().load("pages/addPage.jsp");
           }) ;

           $("#searchPage").click(function(){
               $("#contentM").empty().load("pages/searchPage.jsp");
           });

           $("#firstPage").click(function(){
               $("#contentM").empty().load("pages/firstPage.jsp");
           });

        });
    </script>
</head>
<body>
      <header>
          <a href="index.html" class="logo">个人信息管理系统</a>
          <nav class="navbar nav-default navbar-static-top" role="navigation">
              <div style=" position:relative;left:220px;height:50px; background-color:#1b6d85"></div>
          </nav>
      </header>
      <!--侧边栏-->
      <div class="wrapper">
      <aside class="left-side">
          <section class="sidebar">
              <ul class="sidebar-menu">
                  <li><a id="firstPage"><span class="glyphicon glyphicon-asterisk"></span>&nbsp;首页</a></li>
                  <li><a id="addPage"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加信息</a></li>
                  <li><a id="searchPage"><span class="glyphicon glyphicon-search"></span>&nbsp;搜索信息</a></li>
              </ul>

          </section>

      </aside>
      <aside class="right-side">
          <a name="top" id="top"></a>
          <div class="row" id="contentM" style="margin-left: 0px;margin-right: 0px">

          </div>
          <div class="row">
              <div class="col-sm-12 col-md-12 " style="text-align: center;margin-top: 20px">
                  <b>&copy;2017</b>南京理工大学
              </div>

          </div>
      </aside>
      </div>
</body>
</html>