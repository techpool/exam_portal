<%-- 
    Document   : register
    Created on : Jul 28, 2016, 12:53:10 PM
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
        <title>Register | Exam Portal</title>
    </head>
    <body>
        <%
            
            if(request.getMethod().equals("GET")){
                response.sendRedirect("register.html");
            }
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullname");
            
            InitialContext initialContext = new InitialContext();
            Context context = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) context.lookup("database");
            Connection connection = ds.getConnection();
            if (connection == null){
                throw new SQLException("Error establishing connection!");
            }
            
            String duplicateCheck = "SELECT * FROM users where email='"+email+"';";
            PreparedStatement ps = connection.prepareStatement(duplicateCheck);
            ResultSet rs = ps.executeQuery();
            int flag = 0;
            while(rs.next()){
                flag = 1;
            }
            
            if(flag == 1){
                out.println("You are already registered");
            } else {
                String insertion = "INSERT into users values('"+fullname+"', '"+email+"', '"+password+"')";
                PreparedStatement ps1 = connection.prepareStatement(insertion);
                ps1.executeUpdate();
                
                out.println("You have been registered<br>");
                out.println("<a href='login.html'>Log In here</a>");
            }
        %>
    </body>
</html>
