<%@ page import="java.io.IOException" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>크롤링 예제 - json</title>
    <style>
        table, td, th {
            border: 2px solid grey;
            border-collapse: collapse;
        }
    </style>
</head>
<body>
<%
    String url = "http://fx.kebhana.com/FER1101M.web";
    String line = "";
    String title = "";

    try {
        String kebhana = Jsoup.connect(url).get().text();

        String strJson = kebhana.substring(kebhana.indexOf("{"));
        JSONParser jsonParser = new JSONParser();
        JSONObject json = (JSONObject) jsonParser.parse(strJson.trim());
        Object date = json.get("날짜");
        out.println("환율 기준일: " + date.toString() + "<br>");
        JSONArray array = (JSONArray) json.get("리스트");

        for (Object o : array) {
            JSONObject obj = (JSONObject) o;
            String str = obj.get("통화명").toString();
            out.println(str + "&nbsp;&nbsp; : &nbsp;&nbsp;");
            out.println(obj.get("매매기준율").toString() + "<br>");
        }
    } catch (IOException | ParseException e) {
        e.printStackTrace();
    }
%>
</body>
</html>
