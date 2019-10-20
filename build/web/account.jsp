<%-- 
    Document   : account
    Created on : Jul 16, 2016, 3:51:26 PM
    Author     : PankilNShah
--%>
<%@page import="Package.Connect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
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
        <%
            int count;
            Connection con = Connect.getConnection();
           
            String paid = request.getParameter("paid");
            int paid_amt=Integer.parseInt(paid);
            String customer_id = request.getParameter("customer_id");
            String mobile=request.getParameter("mob");
            
            Statement stmt = con.createStatement();
            String query = "select sum(price) as amount from `order` where customer_id="+"'"+customer_id+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            int amt=Integer.parseInt(rs.getString("amount"));
            
            try
            {
                Statement stmt1 = con.createStatement();
                String query1 = "select count(*) as rows from `account` where customer_id="+"'"+customer_id+"'";
                ResultSet rs1 = stmt1.executeQuery(query1);
                rs1.next();
                int rowCount=Integer.parseInt(rs1.getString("rows"));
                
                String sql1="";
                String message="";
                if(rowCount == 0)
                {
                    sql1 = "INSERT INTO `account` " + "VALUES ('"+customer_id+"','"+amt+"','"+paid_amt+"','"+(amt-paid_amt)+"','"+mobile+"')";
                    message="Saved accounts successfully";
                }
                else if(amt==paid_amt)
                {
                    sql1 = "delete from `account` where customer_id='"+customer_id+"'";
                    message = "Settled successfully";
                }
                else
                {
                    sql1 = "update `account` set paid='"+paid_amt+"', unpaid='"+(amt-paid_amt)+"', mobile_number='"+mobile+"' where customer_id='"+customer_id+"'" ;
                    message="Updated accounts successfully";
                }
                int valid1 = stmt.executeUpdate(sql1);
                
                if(valid1==1)
                {
                    RequestDispatcher rd=request.getRequestDispatcher("paid_unpaid.jsp");
                    request.setAttribute("msg",message);
                    rd.forward(request,response);
                }
                //response.sendRedirect("index.jsp");
            }
            catch(Exception e){
           
            }
            
        %>

    </body>
</html>
