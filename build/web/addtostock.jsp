<%@page import="Package.Connect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<html>
   <head>
      <title>AddStock</title>
   </head>
    <body>
        <%
            //out.println(request.getParameter("username"));
            int count;
            String status="unsold";
            try{
            Connection con = Connect.getConnection();
            
            String price = request.getParameter("price");
            String item_no = request.getParameter("inum");
            
            Statement stmt = con.createStatement();
       
            String sql1 = "INSERT INTO `item` " +
                   "VALUES ('"+item_no+"','"+price+"','"+status+"')";       
            
            int valid1 = stmt.executeUpdate(sql1);
          //  if(valid1==1)
            //{
                
            response.sendRedirect("stock.jsp");
            }
            catch(Exception e){
                String message="This item already exists !";
                RequestDispatcher rd=request.getRequestDispatcher("stock.jsp");
                request.setAttribute("msg",message);
                rd.forward(request,response);
            }
                //out.println("done");
            //}
           // RequestDispatcher rd = request.getRequestDispatcher("index.html");
            //rd.forward(request, response);
           
        %>
    </body>
</html>