<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.tibame.tga105.rest.dishmodel.*"%>

<%
   DishVO dishVO = (DishVO) request.getAttribute("dishVO");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta
      name="author"
      content="Mark Otto, Jacob Thornton, and Bootstrap contributors"
    />
    <meta name="generator" content="Hugo 0.108.0" />
    <title>OGABE|點餐後台</title>
    <link href="dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="dist/css/carousel.css" rel="stylesheet" />
    <link href="dist/css/my.css" rel="stylesheet" />
    <!-- <style>
      footer {
         position: absolute;
         bottom: 0%;
       }
    </style> -->
  </head>

  <body>
  
   <%@ include file="cmsheader.jsp" %>
   
    <main>
      <!-- go to top -->
      <div class="to-top">
        <a href="#">TOP</a>
      </div>
      <!-- Modal註冊彈跳視窗 -->
      
      <!-- model end -->
      <div class="container-fluid pt-5 px-5">
        <h1 class="h_center">點餐系統後台</h1>
      </div>
      <hr />
      <h2 class="h_center">餐廳管理</h2>
<br>
<div class="text-center">
<h3>新增餐點:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="dish.do" enctype="multipart/form-data" name="form1">

	<jsp:useBean id="restSvc" scope="page" class="com.tibame.tga105.rest.restmodel.RestService" />
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐廳:
		<label for="InputDishid" class="form-label">		
		<select class="form-select" size="1" name="restid" id="InputDishid">
			<c:forEach var="restVO" items="${restSvc.all}">
				<option value="${restVO.restid}" ${(param.restid==restVO.restid)? 'selected':'' } >${restVO.restname}
			</c:forEach>
		</select></label>
		</div>
	</div>	
	
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐點名稱:
		<label for="InputDishid1" class="form-label">
		<input type="TEXT" class="form-control" name="dishname" size="45" id="InputDishid1"
			 value="<%= (dishVO==null)? "" : dishVO.getDishname()%>" />
		</label>
	</div>
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐點價格:
		<label for="InputDishid2" class="form-label">
		<input type="TEXT" class="form-control" name="dishprice" size="45" id="InputDishid2"
			 value="<%= (dishVO==null)? "" : dishVO.getDishprice()%>" />
		</label>
	</div>
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐點數量:
		<label for="InputDishid3" class="form-label">
		<input type="TEXT" class="form-control" name="dishity" size="45" id="InputDishid3"
			 value="<%= (dishVO==null)? "" : dishVO.getDishity()%>" />
		</label>
	</div>
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐點描述:
		<label for="InputDishid4" class="form-label">
		<input type="TEXT" class="form-control" name="dishdescription" size="45" id="InputDishid4"
			 value="<%= (dishVO==null)? "" : dishVO.getDishdescription()%>" />
		</label>
	</div>
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐點明細:
		<label for="InputDishid5" class="form-label">
		<input type="TEXT" class="form-control" name="dishspec" size="45" id="InputDishid5"
			 value="<%= (dishVO==null)? "" : dishVO.getDishspec()%>" />
		</label>
	</div>
	<div class="mb-3">
		<div class="rest_dish_select_qty">餐點圖片:
		<label for="InputRestid6" class="form-label">
		<input type="file" class="form-control" name="dishimg" size="45" id="InputRestid6"
			 value="<%= (dishVO==null)? "" : dishVO.getDishimg()%>" />
		</label>
		
	</div>
</div>	
	
	
 	</div>
		<input type="hidden" name="action" value="insert">
		<input type="submit" class="btn btn-primary" value="送出"></FORM>
</div><br>
<div class="h_center">
  <a class="btn btn-outline-secondary"  href='dishcmslistall.jsp'>餐點管理</a>
  
</div>	     
    </main>
    <!-- footer -->
    
    <%@ include file="cmsfooter.jsp" %>
    
    <script src="dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
