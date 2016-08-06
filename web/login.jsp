<%-- 
    Document   : login
    Created on : Jul 28, 2016, 10:57:28 AM
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
        <title>Login | Exam Portal</title>
    </head>
    <body>
        <%
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            InitialContext initialContext = new InitialContext();
            Context context = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) context.lookup("database");
            Connection connection = ds.getConnection();
            if (connection == null){
                throw new SQLException("Error establishing connection!");
            }
            
            String searchUser = "SELECT * FROM users where email='"+ email +"' and password='"+password+"';";
            PreparedStatement ps = connection.prepareStatement(searchUser);
            ResultSet rs = ps.executeQuery();
            int flag = 0;
            while(rs.next()){
                flag = 1;
            }
            
            if(flag == 0){
                response.sendRedirect("login.html");
            } else {
                session.setAttribute("email", email);
                response.sendRedirect("profile.jsp");
            }
            connection.close();
        %>
    </body>
</html>
