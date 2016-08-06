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
        <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
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
            
            String testFetch = "select * from (select * from tests order by test_id desc limit 20) tmp order by tmp.test_id asc";
            PreparedStatement ps1 = connection.prepareStatement(testFetch);
            ResultSet rs1 = ps1.executeQuery();
            int[] scores = new int[20];
            int counter = 0;
            while(rs1.next()){
                scores[counter] = Integer.parseInt(rs.getString("percentage"));
                counter++;
            }
        %>
        <canvas id="myChart" height="100vh"></canvas>
        <script>
            var scores = [];
            var labels = [];
            <% for (int i=0; i < counter; i++) { %>
                scores[<%= i %>] = <%=scores[i] %>;
                console.log(scores[<%= i %>]);
                labels[<%= i %>] = '<%= i+1 %>';
            <%}%> 
            $(function() {
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
            });
        </script>
    </body>
</html>
