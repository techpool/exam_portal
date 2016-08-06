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
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
        <script src="js/script.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.js"></script>
    </head>
    <body class="question-page">
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
        %>
        <ul id="dropdown1" class="dropdown-content">
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout.jsp">Logout</a></li>
        </ul>
        <nav>
            <div class="nav-wrapper">
                <a href="#!" class="brand-logo"><img src="https://cdn3.iconfinder.com/data/icons/science-flat-round/512/report_document_reports_paper_graph_chart-512.png" height="50px" style="margin-top: 5px; margin-left: 5px;"></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="sass.html">Top Scorers</a></li>
                    <li><a href="badges.html">Take another exam!</a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Profile<i class="material-icons right">arrow_drop_down</i></a></li>
                </ul>
            </div>
        </nav>
        <div class="row glossy">
            <div class="col s3 question-num-area center-align">
                <span class="current-question"><%= question_num %></span>
                <span class="by"> / </span>
                <span class="noq"><%= noq %></span>
                
            </div>
            <div class="col s9 question-area">
                <div class="row">
                    
                </div>
                <form class="col s12" action="answer_check.jsp" method="POST">
                <%
                    int counter = 0;
                    while(rs.next()){
                        if(counter < skip){
                            counter++;
                            continue;
                        }
                        session.setAttribute("question_id", rs.getString("question_id"));
                        out.println(rs.getString("question") + "<br>");
                        out.println("<p><input class='with-gap' name='answer' value=1 type='radio' id='option1'/><label for='option1'>"+rs.getString("option1")+"</label></p>");
                        out.println("<p><input class='with-gap' name='answer' value=2 type='radio' id='option2'/><label for='option2'>"+rs.getString("option2")+"</label></p>");
                        out.println("<p><input class='with-gap' name='answer' value=3 type='radio' id='option3'/><label for='option3'>"+rs.getString("option3")+"</label></p>");
                        out.println("<p><input class='with-gap' name='answer' value=4 type='radio' id='option4'/><label for='option4'>"+rs.getString("option4")+"</label></p>");
                        break;
                    }
                    connection.close();
                %>
                    <button class="btn waves-effect waves-light" type="submit" name="action">Submit Answer
                        <i class="material-icons right">send</i>
                    </button>
                </form>
            </div>
        </div>
    </body>
</html>
