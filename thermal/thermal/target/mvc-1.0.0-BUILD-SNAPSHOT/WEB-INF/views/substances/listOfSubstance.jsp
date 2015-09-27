<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
		<title>listOfSubstance</title>
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
		<h1>Substance Listing</h1>
		<table>
			<thead>
				<tr>
					<th>Substance Name</th>
					<th>Substance Formula</th>
				</tr>
			</thead>
			<tbody>	
				<c:forEach items="${subtances}" var="substance">
					<tr>
						<td><a href ="/mvc/data/${substance.name}/${substance.id}">${substance.name}</a></td>
						<td><a href ="/mvc/data/${substance.name}/${substance.id}">${substance.subst_formula}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</body>
</html>