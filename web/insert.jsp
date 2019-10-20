<%@page import="Package.Connect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<html>
   <head>
      <title>Add</title>
   </head>
    <body>
        <%
            //out.println(request.getParameter("username"));
            int count,oid=0;
            Connection con = Connect.getConnection();
            String order_id=session.getAttribute("order_id").toString();
            String customer_id=session.getAttribute("customer_id").toString();
          //  String order_id = request.getParameter("oid");
            String item_no = request.getParameter("inum");
            String customer_name=session.getAttribute("customer_name").toString();
            
            Statement stmt = con.createStatement();
            String query = "select * from `item` where item_no="+"'"+item_no+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            int price=Integer.parseInt(rs.getString("price"));
            
            Statement stmt1 = con.createStatement();
            String query1 = "select customer_name,count(*) as rows from `order` where " + "customer_id="+customer_id;
            ResultSet rs1 = stmt1.executeQuery(query1);
            rs1.next();
            
            Statement stmt2 = con.createStatement();
            String query2 = "select order_id,count(*) from `order` where customer_id="+customer_id+" group by order_id having count(*)<9 limit 1";
            ResultSet rs2 = stmt2.executeQuery(query2);
            
            count=Integer.parseInt(rs1.getString("rows"));
            
            if(!rs2.isBeforeFirst())
            {
                Statement stmt3 = con.createStatement();
                String query3 = "select order_id,count(*) as rows from `order` where customer_id="+"'"+customer_id+"'"+" order by order_id desc limit 1";
                ResultSet rs3 = stmt3.executeQuery(query3);
                rs3.next();
                
                Statement stmt4 = con.createStatement();
                String query4 = "select order_id from `order` order by order_id desc limit 1";
                ResultSet rs4 = stmt4.executeQuery(query4);
                
                count=Integer.parseInt(rs3.getString("rows"));
                
                if(count%9==0)
                {
                    if(rs4.isBeforeFirst())
                    {
                        rs4.next();
                        order_id=rs4.getString("order_id");
                        oid=Integer.parseInt(order_id);
                    }    
                    oid++;
                }
                else
                {
                    order_id=rs3.getString("order_id");
                    oid=Integer.parseInt(order_id);
                }
            }
            else
            {
                rs2.next();
                order_id=rs2.getString("order_id");
                oid=Integer.parseInt(order_id);
            }

            try{
                Statement stmt5 = con.createStatement();
                String sql="select item_no,status from `item` where item_no='"+item_no+"'";
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
                    if(rs5.getString("status")=="sold")
                    {
                        String message="Item is sold !";
                        RequestDispatcher rd=request.getRequestDispatcher("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                        request.setAttribute("msg",message);
                        rd.forward(request,response);
                    }
                    else
                    {
                        String sql1 = "INSERT INTO `order` " +
                               "VALUES ('"+oid+"','"+item_no+"','"+customer_id+"','"+customer_name+"','"+price+"')";

                        String sql2 = "update `item` set status='sold' where item_no='"+item_no+"'and status='unsold'";
                        
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
                                int newAmount=amount+price;
                                String sql3="update `account` set amount='"+newAmount+"' where customer_id='"+customer_id+"'";
                                stmt.executeUpdate(sql3);
                            }
                            
                            if(valid2==1)
                            {
                                response.sendRedirect("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                            }
                        }
                        else
                        {
                            String message="Item cannot be added to customer's cart. Some error occured !";
                            RequestDispatcher rd=request.getRequestDispatcher("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                            request.setAttribute("msg",message);
                            rd.forward(request,response);
                        }
                        
                    }
                }
            }
            
            catch(Exception e){
                String message="Item is sold !";
                RequestDispatcher rd=request.getRequestDispatcher("additem.jsp?cid="+customer_id+"&cname="+customer_name);
                request.setAttribute("msg",message);
                rd.forward(request,response);
            }
            
           
        %>
    </body>
</html>