<%@page import="Package.Connect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="stylesheet" href="css/materialize.min.css">
        <script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script> 
      <title>showlastorderid</title>
   </head>
    <body>
        
        <nav>
          <div class="nav-wrapper">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="index.jsp">New customer</a></li>
                <li><a href="stock.jsp">Add to stock</a></li>
              <li><a href="generatebill.jsp">Generate Bill</a></li>
              <li><a href="getcustomername.jsp">Show my order id</a></li>
              <li><a href="showlastorderid.jsp">Show last order id</a></li>
              <li><a href="paid_unpaid.jsp">Manage account</a></li>
              <li><a href="viewstats.jsp">View Sales</a></li>
            </ul>
          </div>
        </nav>
        </br></br>
        <%
           
            Connection con = Connect.getConnection();
            
            //String price = request.getParameter("price");
            //String customer_name = request.getParameter("cname");
            
            Statement stmt = con.createStatement();
       
            String query = "select * from `order` order by order_id desc limit 1"; 
            ResultSet rs = stmt.executeQuery(query);
            
            
            out.println("<table class='centered'>");
            out.println("<thead>");    
                out.println("<tr>");
                    out.println("<th>Order ID</th>");
                   // out.println("<th>Item Number</th>");
                    out.println("<th>Customer Name</th>");
                   // out.println("<th>Price</th>");
                out.println("</tr>");
            out.println("</thead>");
        
            while(rs.next())
            {
                out.println("<tbody>");
                    out.println("<tr>");
                            out.println("<td>" + rs.getString("order_id") + "</td>");
                       // out.println("<td>"+ rs.getString("item_no") + "</td>");
                        out.println("<td>" + rs.getString("customer_name") + "</td>");
                       // out.println("<td>" + rs.getString("price") + "</td>");
                    out.println("</tr>");    
                out.println("</tbody>");    
            }
            out.println("</table>");
            
           
        %>
    </body>
</html>