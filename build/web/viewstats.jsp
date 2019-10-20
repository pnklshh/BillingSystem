<%-- 
    Document   : viewstats
    Created on : Apr 27, 2019, 12:28:34 AM
    Author     : PankilNShah
--%>

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
      <title>view sales</title>
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
        </br></br>
        <%
           
            Connection con = Connect.getConnection();
            
            //String price = request.getParameter("price");
            //String customer_name = request.getParameter("cname");
            
            Statement stmt = con.createStatement();
            String query = "select sum(price) as total from `order`";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            int total=0;
            if(rs.getString("total") != null)
            {
                total=Integer.parseInt(rs.getString("total"));
            }
            
            Statement stmt1 = con.createStatement();
            String query1 = "select sum(unpaid) as totalunpaid from `account`";
            ResultSet rs1 = stmt1.executeQuery(query1);
            rs1.next();
            int totalunpaid=0;
            if(rs1.getString("totalunpaid") != null)
            {
                totalunpaid=Integer.parseInt(rs1.getString("totalunpaid"));
            }
            
            int totalcash=total-totalunpaid;
            
            Statement stmt2 = con.createStatement();
            String query2 = "select count(*) as soldcount from `item` where status='sold'";
            ResultSet rs2 = stmt2.executeQuery(query2);
            rs2.next();
            int soldcount=0;
            if(rs2.getString("soldcount") != null)
            {
                soldcount=Integer.parseInt(rs2.getString("soldcount"));
            }
            
            Statement stmt3 = con.createStatement();
            String query3 = "select count(*) as unsoldcount from `item` where status='unsold'";
            ResultSet rs3 = stmt3.executeQuery(query3);
            rs3.next();
            int unsoldcount=0;
            if(rs3.getString("unsoldcount") != null)
            {
                unsoldcount=Integer.parseInt(rs3.getString("unsoldcount"));
            }
            
            out.println("<table class='centered'>");
            out.println("<thead>");    
                out.println("<tr>");
                    out.println("<th>Total sales</th>");
                    out.println("<th>Unpaid</th>");
                    out.println("<th>Total cash</th>");
                    out.println("<th>Items Sold</th>");
                    out.println("<th>Items Unsold</th>");
                out.println("</tr>");
            out.println("</thead>");
        
            
            out.println("<tbody>");
                out.println("<tr>");
                    out.println("<td>" + total + "</td>");
                    out.println("<td>"+ totalunpaid + "</td>");
                    out.println("<td>" + totalcash + "</td>");
                    out.println("<td>" + soldcount + "</td>");
                    out.println("<td>" + unsoldcount + "</td>");
                out.println("</tr>");    
            out.println("</tbody>");    
            
            out.println("</table>");
            
           
        %>
    </body>
</html>