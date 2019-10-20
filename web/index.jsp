<%-- 
    Document   : index
    Created on : May 28, 2016, 1:43:29 AM
    Author     : Nimesh
--%>
<%@page import="Package.Connect"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="stylesheet" href="css/materialize.min.css">
        <script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <!--
        <script type="text/javascript">
        
            <%
            /*Connection con = Connect.getConnection();
            Statement stmt = con.createStatement();
        
        
            String query = "select count(status) as sold from `item` where status=`sold`";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            */
            
            %>
            // Load google charts
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            // Draw the chart and set the chart values
            function drawChart() {
              var data = google.visualization.arrayToDataTable([
              ['Task', 'Hours per Day'],
              ['Work', 8],
              ['Friends', 2],
              ['Eat', 2],
              ['TV', 3],
              ['Gym', 2],
              ['Sleep', 7]
            ]);

              // Optional; add a title and set the width and height of the chart
              var options = {'title':'My Average Day', 'width':400, 'height':300};

              // Display the chart inside the <div> element with id="piechart"
              var chart = new google.visualization.PieChart(document.getElementById('piechart'));
              chart.draw(data, options);
            }
        </script>
        -->
    </head>
    <body>
        
        <nav>
          <div class="nav-wrapper">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="index.jsp">New customer</a></li>
                <li><a href="stock.jsp">Add to stock</a></li>
              <li><a href="generatebill.jsp">Generate Bill</a></li>
              <li><a href="getcustomername.jsp">Show my order id</a></li>
<!--              <li><a href="showlastorderid.jsp">Show last order id</a></li>-->
              <li><a href="paid_unpaid.jsp">Manage account</a></li>
              <li><a href="viewstats.jsp">View Sales</a></li>
            </ul>
          </div>
        </nav>
        
        <%
            Connection con = Connect.getConnection();
            Statement stmt = con.createStatement();
       
            String query = "select * from `order` order by customer_id desc limit 1"; 
            ResultSet rs = stmt.executeQuery(query);
            int id = 1;
            if(!rs.isBeforeFirst())
            {
                id = 1;
            }
            else
            {
                rs.next();
                id = Integer.parseInt(rs.getString("customer_id")) + 1;
            }
        %>
        
        <div class="row" style="padding-top: 150px;">
        <form action="additem.jsp" method="GET" class="col s12 center-align">
            <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="cid" placeholder="Customer Id" value="<%=id%>" id="order_id" type="text" class="active validate" required>
            </div>    
            </div> 
            
            <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="cname" placeholder="Customer Name" value="" id="customer_name" type="text" class="active validate" required>
            </div>    
            </div>
            
            <div class="row">
                <button class="btn waves-effect waves-light red" type="submit">Add Item</button>
            </div>
        <!--    Enter order id:<input type="text" name="oid"></br>
            Enter item no:<input type="text" name="inum"></br>
            Enter customer name:<input type="text" name="cname"></br>
            Enter price:<input type="text" name="price"></br></br>
            <input type="submit" value="Add Item">-->
        
        </form>
        <div id="piechart"></div>
            <%
                String message=null;
                
                
                message = (String) request.getAttribute("msg");
                if(message!=null)
                out.println("<h5 align='center'>"+ message+"</h5>"); 
               
               // out.println("hi");
            %>  
        </div>    
    </body>

</html>
