<%-- 
    Document   : score.jsp
    Created on : Jul 28, 2016, 12:40:30 PM
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
        <title>Score | Exam Portal</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
        <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
        <script src="js/script.js"></script>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body class="score-page">
        <%
//            String easy = (String)session.getAttribute("easy");
//            String medium = (String)session.getAttribute("medium");
//            String hard = (String)session.getAttribute("hard");
//            String totalScore = (String)session.getAttribute("noq");
//            String score = (String)session.getAttribute("score");
//            String email = (String)session.getAttribute("email");
//            
//            InitialContext initialContext = new InitialContext();
//            Context context = (Context) initialContext.lookup("java:comp/env");
//            DataSource ds = (DataSource) context.lookup("database");
//            Connection connection = ds.getConnection();
//            if (connection == null){
//                throw new SQLException("Error establishing connection!");
//            }
//            
//            String insertTest = "INSERT INTO tests values('"+email+"', null, "+easy+", "+medium+", "+hard+", "+score+", "+totalScore+");";
//            PreparedStatement ps = connection.prepareStatement(insertTest);
//            ps.executeUpdate();
//            

            String easy = "20";
            String medium = "10";
            String hard = "5";
            String totalScore = "50";
            String score = "35";
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
        <div class="circle score-div">
            <span><span class="score-label">Score</span>
            <span class="score"><%= score %>/<span class="total"><%= totalScore %></span></span><br>
        </div>
        <div class="level-score">
            <div class="circle easy-div">
                <span class="easy-label">Easy</span>
                <span class="easy"><%= easy %></span>
            </div>
            <div class="circle medium-div">
                <span class="medium-label">Medium</span>
                <span class="medium"><%= medium %></span>
                <span class="height-extender"><br>.</span>
            </div>
            <div class="circle hard-div">
                <span class="hard-label">Hard</span>
                <span class="hard"><%= hard %></span>
            </div>
        </div>
    </body>
</html>
