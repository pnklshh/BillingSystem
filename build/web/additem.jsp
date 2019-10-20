<%-- 
    Document   : additem
    Created on : May 21, 2016, 5:00:16 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="stylesheet" href="css/materialize.min.css">
        <script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <title>JSP Page</title>
    </head>
    <% 
        int count;
        String customer_id = request.getParameter("cid");
        //String order_id=customer_id;
        String customer_name = request.getParameter("cname");
        String message=null;
        Connection con = Connect.getConnection();
        
        Statement stmt1 = con.createStatement();
       
        String query1 = "select * from `order` order by order_id desc limit 1"; 
        ResultSet rs1 = stmt1.executeQuery(query1);
        String order_id = null;
        if(!rs1.isBeforeFirst())
        {
            order_id = "1";
        }
        else
        {
            rs1.next();
            order_id = (Integer.parseInt(rs1.getString("order_id")) + 1) + "";
        }
        
        
        Statement stmt = con.createStatement();
        
        
            String query = "select customer_name,count(*) as count from `order` where "
                    + "customer_id="+customer_id
                    +" and customer_name!="+"'"+customer_name+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            if(Integer.parseInt(rs.getString("count"))>0 && customer_name!=null){
                //response.sendRedirect("index.jsp");
                message="Customer id already exists for some other customer !";
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                request.setAttribute("msg",message);
                rd.forward(request,response);
               // out.println("Order id already exists for some other customer !");
            }
            else if(Integer.parseInt(rs.getString("count"))==0 && customer_name==null){
                //response.sendRedirect("index.jsp");
                message="No existing customer with this customer id. Please enter customer name !";
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                request.setAttribute("msg",message);
                rd.forward(request,response);
               // out.println("Order id already exists for some other customer !");
            }
        
            
        if(customer_id==null) 
        {   
            customer_id = session.getAttribute("customer_id").toString();
        }
        
      /*  String query1 = "select count as rows from `order` where order_id="+order_id;
        ResultSet rs1 = stmt.executeQuery(query1);
        rs1.next();
        count=Integer.parseInt(rs1.getString("rows"));
        
        if(count==5){
            int oid=Integer.parseInt(order_id) + 1;
        }*/
        
        session.setAttribute("customer_id",customer_id);
       
        if(order_id==null) 
        {   
            order_id = session.getAttribute("order_id").toString();
        }
        session.setAttribute("order_id",order_id);
        
        //String customer_name = request.getParameter("cname");
        if(customer_name==null) 
            customer_name = session.getAttribute("customer_name").toString();
        session.setAttribute("customer_name",customer_name);
        
            

    %>    
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
            <form method="GET" class="col s12 center-align">
            
            <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="inum" placeholder="Item number" value="" id="item_no" type="text" class="active validate" required>
            </div>    
            </div> 
             
           <!-- <div class="row">
            <div class="input-field col s4 offset-s4">
                <input name="price" placeholder="Price" value="" id="price" type="text" class="active validate" required>
            </div>    
            </div>-->
            
            <div class="row">
                <button class="btn waves-effect waves-light red" type="submit" onclick="form.action='insert.jsp';">Add Item</button>
            </div>
           <div class="row">
                
                <button class="btn waves-effect waves-light red" type="submit" onclick="form.action='delete.jsp';">Delete Item</button>
            </div>
                
           <!-- Enter item no:<input type="text" name="inum"></br>
           
            Enter price:<input type="text" name="price"></br></br>
            <input type="submit" value="Insert">
            <a href="generatebill.jsp">Generate bill</a></br></br>
            <a href="index.html">New customer</a></br></br>-->
            
            
        </form>
        </div> 
        
       <!-- <form action="delete.jsp" method="GET" class="col s12 center-align">
            <div class="row">
                
                <button class="btn waves-effect waves-light red" type="submit" onclick="form.action='delete.jsp';">Delete Item</button>
            </div>
        </form>-->    
        
        <div class="row">
            <div class="col s2 offset-s1">
            <a href="generatebill.jsp">Generate bill</a>
            </div>
            <div class="col s2 offset-s6">
            <a href="index.jsp">New customer</a>
            </div>
        </div>
        </br></br>
        
        <%
        //Connection con = Connect.getConnection();
        //Statement stmt = con.createStatement();
        
        message=null;                
        message = (String) request.getAttribute("msg");
        if(message!=null)
        out.println("<h5 align='center'>"+ message+"</h5>");

        int id=0;
        id=Integer.parseInt(session.getAttribute("order_id").toString());
        
        Statement stmt2 = con.createStatement();
        String query2 = "select * from `order` where customer_id="+"'"+customer_id+"'";
        ResultSet rs2 = stmt2.executeQuery(query2);
        
        out.println("<table class='centered'>");
            out.println("<thead>");    
                out.println("<tr>");
                    out.println("<th>Order ID</th>");
                    out.println("<th>Item Number</th>");
                    //out.println("<th>Customer Name</th>");
                    out.println("<th>Price</th>");
                out.println("</tr>");
            out.println("</thead>");
        
            while(rs2.next())
            {
                out.println("<tbody>");
                    out.println("<tr>");
                            out.println("<td>" + rs2.getString("order_id") + "</td>");
                        out.println("<td>"+ rs2.getString("item_no") + "</td>");
                       // out.println("<td>" + rs.getString("customer_name") + "</td>");
                        out.println("<td>" + rs2.getString("price") + "</td>");
                    out.println("</tr>");    
                out.println("</tbody>");    
            }
            out.println("</table>");
            %>
    </body>
</html>
