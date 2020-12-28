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
</head>
<body>
<%
    // 두산 베어스의 특정 선수 이미지 가져오기
    String url = "https://www.doosanbears.com/players/batters/20";
    StringBuilder line = new StringBuilder();
    Document doc = null;

    try {
        doc = Jsoup.connect(url).get();
        Elements body = doc.select(".photo_r");

        for (Element src : body) {
            out.println(src.toString());
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
%>
<%=line.toString()%>
</body>
</html>
