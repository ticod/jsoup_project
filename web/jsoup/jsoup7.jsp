<%@ page import="java.io.IOException" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.util.*" %>
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
    Object date = null;

    try {
        String kebhana = Jsoup.connect(url).get().text();

        String strJson = kebhana.substring(kebhana.indexOf("{"));
        JSONParser jsonParser = new JSONParser();
        JSONObject json = (JSONObject) jsonParser.parse(strJson.trim());
        date = json.get("날짜");
        out.println("환율 기준일: " + date.toString() + "<br>");
        JSONArray array = (JSONArray) json.get("리스트");

        Map<String, List<String>> objects = new HashMap<>();
        int count = 0;

        for (Object o : array) {
            JSONObject obj = (JSONObject) o;
            for (Object key : obj.keySet()) {
                if (objects.get(key) != null) {
                    String value = (String) obj.get(key);
                    objects.get(key).add(value);
                } else {
                    List<String> list = new ArrayList<>();
                    list.add((String) obj.get(key));
                    objects.put((String) key, list);
                }
                count++;
            }
        }
        out.println(objects.size());
        pageContext.setAttribute("objects", objects);
        pageContext.setAttribute("listSize", count);
    } catch (IOException | ParseException e) {
        e.printStackTrace();
    }
%>
<table>
    <caption><%=date != null ? date.toString() : null%></caption>
    <tr>
        <c:forEach items="${objects.keySet()}" var="objectKey">
            <th>${objectKey}</th>
        </c:forEach>
    </tr>
    <c:forEach begin="1" end="${listSize}" var="i">
    <tr>
        <c:forEach items="${objects.keySet()}" var="objectKey">
            <td>${objects.get(objectKey).get(i)}</td>
        </c:forEach>
    </tr>
    </c:forEach>

</table>
</body>
</html>
