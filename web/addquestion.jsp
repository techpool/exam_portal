<%-- 
    Document   : addquestion.jsp
    Created on : Jul 31, 2016, 11:46:21 PM
    Author     : suryadeep
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Question | Exam Portal</title>
    </head>
    <body>
        <%
            String question = request.getParameter("question");
            String option1 = request.getParameter("option1");
            String option2 = request.getParameter("option2");
            String option3 = request.getParameter("option3");
            String option4 = request.getParameter("option4");
            String answer = request.getParameter("answer");
            String level = request.getParameter("level");
            String subject = request.getParameter("subject");
            
            InitialContext initialContext = new InitialContext();
            Context context = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) context.lookup("database");
            Connection connection = ds.getConnection();
            if (connection == null){
                throw new SQLException("Error establishing connection!");
            }
            
            String insertQues = "INSERT INTO questions VALUES('"+question+"', '"+option1+"', '"+option2+"', '"+option3+"', '"+option4+"', '"+answer+"', '"+level+"', '"+subject+"', null);";
            PreparedStatement ps = connection.prepareStatement(insertQues);
            ps.executeUpdate();
            
            response.sendRedirect("addquestion.html");
        %>
    </body>
</html>
