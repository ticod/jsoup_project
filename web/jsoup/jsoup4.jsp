<%@ page import="java.io.IOException" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>크롤링 예제</title>
    <style>
        table, td, th {
            border: 2px solid grey;
            border-collapse: collapse;
        }
    </style>
</head>
<body>
<%
    String url = "https://www.koreaexim.go.kr/site/program/financial/exchange?menuid=001001004002001";
    String line = "";
    Document doc = null;
    List<String> list = new ArrayList<>();

    try {
        doc = Jsoup.connect(url).get();
        Elements body = doc.select(".tc");

        for (Element src : body) {
            list.add(src.html());
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
    pageContext.setAttribute("list", list);
%>
<table>
    <c:forEach items="${list}" var="v" varStatus="stat">
        <c:choose>
            <c:when test="${stat.index % 7 == 0}">
                <tr><td rowspan="6">${v}</td>
            </c:when>
            <c:when test="${stat.index % 7 == 1}">
                <td>${v}</td></tr>
            </c:when>
            <c:otherwise>
                <tr><td rowspan>${v}</td></tr>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</table>
</body>
</html>
