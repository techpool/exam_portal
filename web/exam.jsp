<%-- 
    Document   : exam
    Created on : Jul 28, 2016, 11:13:18 AM
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
        <title>Exam | Exam Portal</title>
    </head>
    <body>
        <%
            
            if((String)session.getAttribute("email") == null){
                response.sendRedirect("login.html");
            }
            
            // Retreiving the question num from session
            String question_num = (String)session.getAttribute("question_num");
            
            InitialContext initialContext = new InitialContext();
            Context context = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) context.lookup("database");
            Connection connection = ds.getConnection();
            if (connection == null){
                throw new SQLException("Error establishing connection!");
            }
            
            if(question_num == null){
                // if question_num is null that means the session variable was never set
                // and this is the first time he is openning this page thus the parameters must
                // be retrieved from the submitted form and the required session variables should
                // be set
                String subject = request.getParameter("subject");
                String noq = request.getParameter("noq");
                
                question_num = "1";
                session.setAttribute("question_num", "1");
                session.setAttribute("subject", subject);
                // level 3 - easy
                session.setAttribute("level", "3");
                session.setAttribute("easy", "0");
                session.setAttribute("medium", "0");
                session.setAttribute("hard", "0");
                session.setAttribute("correct", "0");
                session.setAttribute("noq", noq);
            }
            
            String subject = (String)session.getAttribute("subject");
            String noq = (String)session.getAttribute("noq");
            // Retrieving the level from session
            String level = (String)session.getAttribute("level");
            
            String question_retrieve = "SELECT * from questions where subject='"+subject+"' and level='"+level+"';";
            PreparedStatement ps = connection.prepareStatement(question_retrieve);
            ResultSet rs = ps.executeQuery();
            
            int skip = 0;
            if(level.equals("3")){
                skip = Integer.parseInt((String)session.getAttribute("easy"));
            } else if(level.equals("2")){
                skip = Integer.parseInt((String)session.getAttribute("medium"));
            } else {
                skip = Integer.parseInt((String)session.getAttribute("hard"));
            }
            
            int counter = 0;
            while(rs.next()){
                if(counter < skip){
                    counter++;
                    continue;
                }
                session.setAttribute("question_id", rs.getString("question_id"));
                out.println(rs.getString("question"));
                out.println(rs.getString("option1"));
                out.println(rs.getString("option2"));
                out.println(rs.getString("option3"));
                out.println(rs.getString("option4"));
                break;
            }
        %>
        <form action="answer_check.jsp" method="POST">
            <input type="number" name="answer">
            <input type="submit" value="Submit Answer">
        </form>
    </body>
</html>
