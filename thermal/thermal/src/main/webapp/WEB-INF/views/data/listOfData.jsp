<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="helpers.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
		<title>listOfData</title>
		<style type="text/css">
   		TABLE { 
    			width: 300px; /* Ширина таблицы */
    			border: 2px solid black; /* Рамка вокруг таблицы */
    			background: white; /* Цвет фона таблицы */
   			}
   		TD, TH { 
    			text-align: center; /* Выравнивание по центру */
    			padding: 3px; /* Поля вокруг содержимого ячеек */
   			}
   		TH { 
    			background: #4682b4; /* Цвет фона */
    			color: white; /* Цвет текста */
    			border-bottom: 2px solid black; /* Линия снизу */
   			}
   		.lc { 
    			font-weight: bold; /* Жирное начертание текста */
    			text-align: left; /* Выравнивание по левому краю */
   			}
  		</style>
	</head>
	<body>
		<h1>${subst_name}</h1>
		<h2>Constants Listing</h2>
		<h3>Data Source</h3>
		<p>${constants.get(0).getData_Source().getName()}</p>
		<table>
			<thead>
				<tr>
					<th>Constant Name</th>
					<th>Constant Value</th>
					<th>Constant Dimension</th>
					<th>Constant Uncertainty</th>
					<th>Uncertainty Type</th>
					
				</tr>
			</thead>
			<tbody>	
				<c:forEach items="${constants}" var="constant">
					<tr>
						<td>${constant.getProperty().getProp_designation()}</td>
						<td>${constant.value}</td>
						<td>${constant.getProperty().getDimension().getName()}</td>
						<td>${constant.uncertainty_value}</td>
						<td>${constant.getUncertainty().getName()}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		<p><a href ="/mvc/chemspiderbinding/${subst_id}">Найти соответсвующее вещество в ChemSpider</a></p>
		<c:choose>
		<c:when test="${not empty infos}">
		<h3>
		  This substance has a link to ChemSpider 
		</h3>
		  <table>
		      <tr><td>${infos.get(0).getChemSpiderUri()}</td></tr>
		      <tr><td><a href="${infos.get(0).getChemSpiderURL()}">ChemSpider ${infos.get(0).getChemSpiderId()}</a></td></tr>
              <tr><td><img src="${infos.get(0).getPictureURL()}"/></td></tr>
          </table>
		<p><a href ="/mvc/removebinding/${subst_id}">Удалить привязку</a></p>
        
		</c:when>
		</c:choose>
		
		<c:choose>
		<c:when test="${empty dates[0]}">
					<p>Substance is characterized only by constants.</p>
		</c:when>
		<c:when test="${not empty dates[0]}">
		<h3>Data Source</h3>
		<p>${dates[0].get(0).getData_Source().getName()}</p>
		<table>
			<c:forEach items="${dates}" var="data">			
				<td>
					<table>
						<thead>
							<tr>
								
								<th>${data.get(0).getProperty().getProp_designation()}</th>
								
							</tr>
							<tr>

								<th>${data.get(0).getProperty().getDimension().getName()}</th>
								
							</tr>
						</thead>
						<tbody>
							
							<c:forEach items="${data}" var="d">
			
							<tr>
								<td>${d.value}</td>
							</tr>
							
							</c:forEach>
							
			
						</tbody>	
					</table>
				</td>
			</c:forEach>
		</table>
		</c:when>
		</c:choose>
	<p><a href ="/mvc/substances">Вернуться к списку доступных данных.</a></p>	
	</body>
</html>