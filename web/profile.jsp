<%-- 
    Document   : profile
    Created on : Aug 2, 2016, 6:40:59 PM
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
        <title>Profile Page | Exam Portal</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
        <script src="js/script.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.js"></script>
    </head>
    <body>
        <%
            InitialContext initialContext = new InitialContext();
            Context context = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) context.lookup("database");
            Connection connection = ds.getConnection();
            if (connection == null){
                throw new SQLException("Error establishing connection!");
            }
            

            String email = (String)session.getAttribute("email");
            if(email == null){
                response.sendRedirect("login.html");
            }
            
            String userInfoFetch = "SELECT * from users where email='"+email+"';";
            PreparedStatement ps = connection.prepareStatement(userInfoFetch);
            ResultSet rs = ps.executeQuery();
            
            String name = "";
            while(rs.next()){
                name = rs.getString("fullname");
            }
            
            String testFetch = "select * from (select * from tests where email='"+email+"'order by test_id desc limit 20) tmp order by tmp.test_id asc";
            PreparedStatement ps1 = connection.prepareStatement(testFetch);
            ResultSet rs1 = ps1.executeQuery();
            double[] scores = new double[20];
            int counter = 0;
            while(rs1.next()){
                scores[counter] = Double.parseDouble(rs1.getString("percentage"));
                counter++;
            }
            
            connection.close();
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
        <div class="container">
            <canvas id="myChart"></canvas>
            <hr>
            <div class="row">
                <div class="row center-align">
                    <h4>Take a Test!</h4>
                </div>
                <form class="col s12" id="exam-form">
                    <div class="input-field col s12">
                        <i class="material-icons prefix">mode_edit</i>
                        <select name="subject">
                            <option value="" disabled selected>Choose your option</option>
                            <option value="cs">Computer Science</option>
                            <option value="mt">Maths</option>
                        </select>
                        <label>Choose a subject: </label>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">list</i>
                            <input type="number" id="noq" name="noq" class="validate">
                            <label for="noq">Number of Questions</label>
                        </div>
                    </div>
                    <div class="row center-align">
                        <div class="col s6">
                            <a class="waves-effect waves-light btn-large" id="each-question">Take test with one question at a time</a>
                        </div>
                        <div class="col s6">
                            <a class="waves-effect waves-light btn-large" id="all-question">Take test with all question at a time</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <script>
            var scores = [];
            var labels = [];
            <% for (int i=0; i < counter; i++) { %>
                scores[<%= i %>] = <%=scores[i] %>;
                console.log(scores[<%= i %>]);
                labels[<%= i %>] = '<%= i+1 %>';
            <%}%> 
            $(function() {
                $('select').material_select();
                var data = {
                    labels: labels,
                    datasets: [
                        {
                            label: "Score Percentage",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(75,192,192,0.4)",
                            borderColor: "rgba(75,192,192,1)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "rgba(75,192,192,1)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(75,192,192,1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: scores,
                            spanGaps: false,
                        }
                    ]
                };
                var ctx = document.getElementById("myChart");
                var ctx = document.getElementById("myChart").getContext("2d");
                var ctx = $("#myChart");
                var myLineChart = new Chart(ctx, {
                    type: 'line',
                    data: data,
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero:false
                                }
                            }]
                        }
                    }
                });
                
                $("#each-question").on("click", function(e){
                    e.preventDefault();
                    $('#exam-form').attr('action', "exam.jsp").submit();
                });
                $("#all-question").on("click", function(e){
                    e.preventDefault();
                    $('#exam-form').attr('action', "exam_all.jsp").submit();
                });
            });
        </script>
    </body>
</html>
