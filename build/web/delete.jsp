<%@page import="Package.Connect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<html>
   <head>
      <title>Delete</title>
   </head>
    <body>
        <%
            //out.println(request.getParameter("username"));
            int count;
            Connection con = Connect.getConnection();
            String order_id=session.getAttribute("order_id").toString();
            String customer_id=session.getAttribute("customer_id").toString();
          //  String order_id = request.getParameter("oid");
            String item_no = request.getParameter("inum");
            String customer_name=session.getAttribute("customer_name").toString();
            
            Statement stmt = con.createStatement();
            try{
                Statement stmt5 = con.createStatement();
                String sql="select * from `item` where item_no='"+item_no+"'";
                ResultSet rs5 = stmt5.executeQuery(sql);
                
                if(!rs5.isBeforeFirst())
                {
                    String message="This item is not added to stock !";
                    RequestDispatcher rd=request.getRequestDispatcher("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                    request.setAttribute("msg",message);
                    rd.forward(request,response);
                }
                
                else
                {
                    rs5.next();
                    int price=Integer.parseInt(rs5.getString("price"));
                    if(rs5.getString("status")=="unsold")
                    {
                        String message="Item is still unsold !";
                        RequestDispatcher rd=request.getRequestDispatcher("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                        request.setAttribute("msg",message);
                        rd.forward(request,response);
                    }
                    else
                    {
                        String sql1 = "delete from `order` where item_no="+"'"+item_no+"' and customer_id='"+customer_id+"'" ;
                        //out.println(sql);
                        String sql2 = "update `item` set status="+"'unsold'" +"where item_no='"+item_no+"' and status='sold'";

                        Statement stmt6 = con.createStatement();
                        String amountQuery="select amount,count(*) as rowCount from `account` where customer_id='"+customer_id+"'";
                        ResultSet rs6 = stmt6.executeQuery(amountQuery);
                        rs6.next();
                        
                        int valid1 = stmt.executeUpdate(sql1);
                        int valid2=0;
                        if(valid1==1)
                        {
                            valid2 = stmt.executeUpdate(sql2);
                            
                            if(Integer.parseInt(rs6.getString("rowCount")) > 0)
                            {
                                int amount=Integer.parseInt(rs6.getString("amount"));
                                String sql3="update `account` set amount='"+(amount-price)+"' where customer_id='"+customer_id+"'";
                                stmt.executeUpdate(sql3);
                            }
                            
                            if(valid2==1)
                            {
                                response.sendRedirect("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                            }
                        }
                        else
                        {
                            String message="Item is not in customer's cart !";
                            RequestDispatcher rd=request.getRequestDispatcher("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                            request.setAttribute("msg",message);
                            rd.forward(request,response);
                        }
                        
                    }
                }
            }
            catch(Exception e){
                
            }
                //out.println("done");
            //}
           // RequestDispatcher rd = request.getRequestDispatcher("index.html");
            //rd.forward(request, response);
           
        %>
    </body>
</html>