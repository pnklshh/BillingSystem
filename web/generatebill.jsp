^<%-- 
    Document   : showmypurchase
    Created on : May 21, 2016, 11:07:17 PM
    Author     : Nimesh
--%>

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
<!--              <li><a href="showmyorderid.jsp">Show last order id</a></li>-->
              <li><a href="paid_unpaid.jsp">Manage account</a></li>
              <li><a href="viewstats.jsp">View Sales</a></li>
            </ul>
          </div>
        </nav>
        
        <div class="row" style="padding-top: 150px;">
            <form action="viewmypurchase.jsp" method="GET" class="col s12 center-align">
                <div class="row">
                    <div class="input-field col s4 offset-s4">
                         <input name="oid" placeholder="Order Id" value="" id="order_id" type="text" class="active validate" required>
                    </div>
                </div>
                
                <div class="row">
                    <button class="btn waves-effect waves-light red" type="submit">View</button>
                </div>
           <!-- Enter order id:<input type="text" name="oid"></br></br>
            <input type="submit" value="View">-->
        </form>
            
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
