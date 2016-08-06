<%-- 
    Document   : answer_check
    Created on : Jul 28, 2016, 11:30:54 AM
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
        <title>Answer Check | Exam Portal</title>
    </head>
    <body>
        <%
            if((String)session.getAttribute("email") == null){
                response.sendRedirect("login.jsp");
            }
            
            if(request.getMethod().equals("GET")){
                response.sendRedirect("exam.jsp");
            }
            
            InitialContext initialContext = new InitialContext();
            Context context = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) context.lookup("database");
            Connection connection = ds.getConnection();
            if (connection == null){
                throw new SQLException("Error establishing connection!");
            }
            
            String answer = request.getParameter("answer");
            String question_num = (String)session.getAttribute("question_num");
            String subject = (String)session.getAttribute("subject");
            String number_of_question = (String)session.getAttribute("noq");
            // Retrieving the level from session
            String level = (String)session.getAttribute("level");
            
            String question_id = (String)session.getAttribute("question_id");
            String questionSearch = "SELECT * FROM questions where question_id='"+question_id+"';";
            PreparedStatement ps = connection.prepareStatement(questionSearch);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                if(rs.getString("answer").equals(answer)){
                    String scoreString = (String)session.getAttribute("score");
                    if(scoreString == null){
                        session.setAttribute("score", "1");
                    } else {
                        int scoreInt = Integer.parseInt(scoreString);
                        scoreInt++;
                        session.setAttribute("score", Integer.toString(scoreInt));
                    }
                    
                    
                    if(level.equals("3")){
                        int easy = Integer.parseInt((String)session.getAttribute("easy"));
                        easy++;
                        session.setAttribute("easy", Integer.toString(easy));

                        int correctTemp = Integer.parseInt((String)session.getAttribute("correct"));
                        correctTemp++;
                        if(correctTemp == 3){
                            correctTemp = 0;
                            session.setAttribute("level", "2");
                        }
                        session.setAttribute("correct", Integer.toString(correctTemp));
                    }else if(level.equals("2")){
                        int medium = Integer.parseInt((String)session.getAttribute("medium"));
                        medium++;
                        session.setAttribute("medium", Integer.toString(medium));

                        int correctTemp = Integer.parseInt((String)session.getAttribute("correct"));
                        correctTemp++;
                        if(correctTemp == 3){
                            correctTemp = 0;
                            session.setAttribute("level", "1");
                        }
                        session.setAttribute("correct", Integer.toString(correctTemp));
                    }else{
                        int hard = Integer.parseInt((String)session.getAttribute("hard"));
                        hard++;
                        session.setAttribute("hard", Integer.toString(hard));

                        int correctTemp = Integer.parseInt((String)session.getAttribute("correct"));
                        correctTemp++;
                        if(correctTemp == 3){
                            correctTemp = 3;
                        }
                        session.setAttribute("correct", Integer.toString(correctTemp));
                    }
                    
                    
                } else {
                    if(level.equals("3")){
                        int easy = Integer.parseInt((String)session.getAttribute("easy"));
                        easy++;
                        session.setAttribute("easy", Integer.toString(easy));

                        int correctTemp = Integer.parseInt((String)session.getAttribute("correct"));
                        correctTemp--;
                        if(correctTemp == -1){
                            correctTemp = 0;
                        }
                        session.setAttribute("correct", Integer.toString(correctTemp));
                    }else if(level.equals("2")){
                        int medium = Integer.parseInt((String)session.getAttribute("medium"));
                        medium++;
                        session.setAttribute("medium", Integer.toString(medium));

                        int correctTemp = Integer.parseInt((String)session.getAttribute("correct"));
                        correctTemp--;
                        if(correctTemp == -1){
                            correctTemp = 0;
                            session.setAttribute("level", "3");
                        }
                        session.setAttribute("correct", Integer.toString(correctTemp));
                    }else{
                        int hard = Integer.parseInt((String)session.getAttribute("hard"));
                        hard++;
                        session.setAttribute("hard", Integer.toString(hard));

                        int correctTemp = Integer.parseInt((String)session.getAttribute("correct"));
                        correctTemp--;
                        if(correctTemp == -1){
                            correctTemp = 0;
                            session.setAttribute("level", "2");
                        }
                        session.setAttribute("correct", Integer.toString(correctTemp));
                    }
                }
                break;
            }
            
            int question_numInt = Integer.parseInt(question_num);
            int number_of_questionInt = Integer.parseInt(number_of_question);
            
            if(question_numInt == number_of_questionInt){
                response.sendRedirect("score.jsp");
            } else {
                question_numInt++;
                session.setAttribute("question_num", Integer.toString(question_numInt));
                response.sendRedirect("exam.jsp");
            }
            connection.close();
        %>
    </body>
</html>
