<%-- 
    Document   : paid_unpaid
    Created on : Jul 16, 2016, 3:38:21 PM
    Author     : PankilNShah
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="stylesheet" href="css/materialize.min.css">
        <script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <title>JSP Page</title>
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
        <div class="row">
            <form action="account.jsp" method="GET" class="col s12 center-align">
            
            <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="customer_id" placeholder="Customer id" value="" id="customer_id" type="text" class="active validate" required>
            </div>    
            </div> 
             
            <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="paid" placeholder="Paid" value="" id="paid" type="text" class="active validate" required>
            </div>    
            </div>
            
            <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="mob" placeholder="Mobile number" value="" id="mob" type="text" class="active validate">
            </div>    
            </div>    
                
            <div class="row">
                <button class="btn waves-effect waves-light red" type="submit">Submit</button>
            </div>
        </div>
        
        <%
        Connection con = Connect.getConnection();
        //Statement stmt = con.createStatement();
        
        String message=null;                
        message = (String) request.getAttribute("msg");
        if(message!=null)
        out.println("<h5 align='center'>"+ message+"</h5>");

        Statement stmt2 = con.createStatement();
        String query2 = "select  distinct order.customer_id,order.customer_name,amount,paid,unpaid,mobile_number from `account` inner join `order` on account.customer_id=order.customer_id";
        ResultSet rs2 = stmt2.executeQuery(query2);
        
        out.println("<table class='centered'>");
            out.println("<thead>");    
                out.println("<tr>");
                    out.println("<th>Customer ID</th>");
                    out.println("<th>Customer Name</th>");
                    out.println("<th>Amount</th>");
                    out.println("<th>Paid</th>");
                    out.println("<th>Unpaid</th>");
                    out.println("<th>Mobile number</th>");
                out.println("</tr>");
            out.println("</thead>");
        
            while(rs2.next())
            {
                out.println("<tbody>");
                    out.println("<tr>");
                        out.println("<td>" + rs2.getString("customer_id") + "</td>");
                        out.println("<td>" + rs2.getString("customer_name") + "</td>");
                        out.println("<td>"+ rs2.getString("amount") + "</td>");
                        out.println("<td>" + rs2.getString("paid") + "</td>");
                        out.println("<td>" + rs2.getString("unpaid") + "</td>");
                        out.println("<td>" + rs2.getString("mobile_number") + "</td>");
                    out.println("</tr>");    
                out.println("</tbody>");    
            }
            out.println("</table>");
        %>    
            
    </body>
</html>
