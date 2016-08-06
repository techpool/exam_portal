<%-- 
    Document   : startexam.jsp
    Created on : Jul 28, 2016, 11:07:38 AM
    Author     : suryadeep
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Start Exam | Exam Portal</title>
    </head>
    <body>
        <%
            String email = (String)session.getAttribute("email");
            if(email == null){
                response.sendRedirect("login.html");
            }
        %>
        
        <form action="exam.jsp" method="POST">
            Select Subject:
            <select name="subject">
                <option value="cs">Computer Science</option>
                <option value="mt">Maths</option>
            </select>
            Number of Questions you want:
            <input type="number" name="noq" placeholder="Number of Questions">
        </form>
    </body>
</html>
