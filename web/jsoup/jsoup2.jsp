<%@ page import="java.io.IOException" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>크롤링 예제</title>
    <style>
        table, td, th {
            border: 2px solid black;
        }
    </style>
</head>
<body>
<%
    String url = "https://www.koreaexim.go.kr/site/program/financial/exchange?menuid=001001004002001";
    StringBuilder line = new StringBuilder();
    Document doc = null;

    try {
        doc = Jsoup.connect(url).get();
        Elements elements = doc.select("table").select("tr");

        for (Element element : elements) {
            String temp = element.html();
            System.out.println("==========");
            System.out.println(temp);
            line.append("<tr>")
                    .append(temp)
                    .append("</tr>");
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
%>
<table><%=line.toString()%></table>
</body>
</html>
