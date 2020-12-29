<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공공 데이터 api 활용</title>
    <style>
        table, th, td {
            border: 2px solid black;
            border-collapse: collapse;
            text-align: center;
        }
    </style>
</head>
<body>
<%
    String serviceKey = "zf0Df3eFF6PUO%2BFko%2B6k4BxS5GN635dzqSLJ%2BP9WnkR03BFEKNKTciyZsqbZa7qIekIL5dYvLvur5W%2BgTQ62MQ%3D%3D";
    String apiURL = "http://openapi.airport.kr/openapi/service/" +
            "StatusOfPassengerFlights/" +
            "getPassengerArrivals" +
            "?serviceKey=" + serviceKey;
    StringBuilder line = new StringBuilder();
    String str = "";

    URL url = new URL(apiURL);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // url 연결
    conn.setRequestProperty("Accept", "application/xml"); // xml 정보 수신
    BufferedReader br = new BufferedReader(
            new InputStreamReader(
                    conn.getInputStream(), StandardCharsets.UTF_8));
    // UTF-8로 한글 처리
    // StandardCharsets.UTF_8 == "utf-8"
    while((str = br.readLine()) != null) {
        line.append(str);
    }
    Document doc = null;
    StringBuilder html = new StringBuilder("<table><tr><th>출발공항</th><th>항공사</th><th>비행기</th>" +
            "<th>예정시간</th><th>변경시간</th><th>정보</th></tr>");

    try {
        doc = Jsoup.parse(String.valueOf(line));
        int cnt = 0;
        Elements body = doc.select("item");
        for (Element element : body) {
            html.append("<tr>");
            html.append("<td>")
                    .append(element.select("airport").get(0).text())
                    .append("</td>");
            html.append("<td>")
                    .append(element.select("airline").get(0).text())
                    .append("</td>");
            html.append("<td>")
                    .append(element.select("flightid").get(0).text())
                    .append("</td>");
            html.append("<td>")
                    .append(element.select("scheduledatetime").get(0).text())
                    .append("</td>");
            html.append("<td>")
                    .append(element.select("estimateddatetime").get(0).text())
                    .append("</td>");
            try {
                html.append("<td>")
                        .append(element.select("remark").get(0).text())
                        .append("&nbsp;</td></tr>");
            } catch (IndexOutOfBoundsException e) {
                html.append("&nbsp;</td></tr>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    html.append("</table>");
%>
<%=html.toString()%>
</body>
</html>
