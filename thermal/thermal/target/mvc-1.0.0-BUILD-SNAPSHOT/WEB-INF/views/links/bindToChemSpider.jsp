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
        <h1>Bind ${substance.getName()} ${substance.getSubst_formula()} to ChemSpider :</h1>
        <h2>ChemSpider substances with the same formula listing :</h2>
        
        <form:form modelAttribute="chemSpiderInfo" action="/mvc/chemspiderbinding/${substance.getId()}" method="post">
	        <table>
	            <thead>
	                <tr>
	                    <th></th>
	                    <th>ChemSpider Id</th>
	                    <th>ChemSpider Image</th>
	                    <th>ChemSpider Systematic Name</th>
	                    <th>ChemSpider Formula</th>
	                </tr>
	            </thead>
	            <tbody> 
	                <c:forEach items="${infos}" var="info">
	                    <tr>
	                        <td><form:radiobutton name="chemSpiderUri" path="chemSpiderUri" value="${info.getChemSpiderUri()}"/></td>
	                        <td><a href="${info.getChemSpiderURL()}">${info.getChemSpiderId()}</a></td>
	                        <td><img src="${info.getPictureURL()}"/></td>
	                        <td>${info.getSystematicName()}</td>
	                        <td>${info.getFormula()}</td>
	                    </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	        <input type="submit" name="action" value="Bind" />
	        <input type="submit" name="action" value="Cancel" />
        </form:form>
    </body>
</html>