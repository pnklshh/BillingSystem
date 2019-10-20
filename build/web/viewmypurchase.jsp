<%-- 
    Document   : viewmypurchase
    Created on : May 21, 2016, 11:11:13 PM
    Author     : Nimesh
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Package.Connect"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
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
        
        <style type ="text/css" >
            html{
                height:100%;
            }
            body{
/*                align-content: center;*/
/*                height: 210mm;
                width: 148mm;*/
                width:90%;
                height:100%;
                margin:auto;
                background-image: url("http://navenbyarchaeologygroup.org/wp-content/uploads/2019/03/simple-flower-drawing-flower-designs-to-draw-decoration-at-com-free-for-personal-a-design-drawing-beautiful-flower-simple-simple-flower-drawing-with-color.jpg");
                background-position: top right;
                background-repeat: no-repeat;
                background-size: 150px;
                -webkit-print-color-adjust: exact;
            }
            
            footer{ 
                position: absolute;    
                text-align: right;    
                bottom: 0px; 
                width: 100%;
            }    
              br,h4 {
            line-height: 0px;      
            display: block; /* makes it have a width */
            content: ""; /* clears default height */
            margin-top: 0px; /* change this to whatever height you want it */
            }
            h1 {
            line-height: 25px;      
            display: block; /* makes it have a width */
            content: ""; /* clears default height */
            margin-top: 50px; /* change this to whatever height you want it */
            }
            h5 {
                  
            display: block; /* makes it have a width */
            content: ""; /* clears default height */
            margin-top: 20px; /* change this to whatever height you want it */
            }
            
            table{
/*                width: 500px;*/
/*                background-image: url("https://3.bp.blogspot.com/-vj5Y3P74QMM/XFFotf7emDI/AAAAAAAABQM/U7Sd6xlJ5NMUOwj4vTod_KD9sFdOrSmjgCLcBGAs/s1600/Sketch-21-51-49-1-29-2019.jpg");
                background-position: center;
                background-repeat: no-repeat;
                background-size: contain;*/
                align-content: center;
                align-items: center;
                align-self: center;
                border: 2px solid black;
                border-collapse: separate;
                border-spacing: 2px;
                border-radius: 20px;
                -moz-border-radius: 20px;
                -webkit-border-radius: 20px;
            }
            
            th {
                text-align: center;
                border: 2px solid black;
                border-collapse: separate;
                border-spacing: 2px;
                border-radius: 20px;
                -moz-border-radius: 20px;
                -webkit-border-radius: 20px;
             }
            
            table tbody td + td { 
                border-left:2px solid black; 
                border-collapse: collapse;
            }
            
            screen {
                div.divFooter {
                    display: none;
                }
                div.divHeader {
                    display: none;    
                }
            }
            print {
                div.divFooter {
                    position: fixed;
                    bottom: 0;
                }
                div.divHeader {
                    position: fixed;
                    top: 0;    
                }
        /*        display: none !important;*/
            }
            
            /*  background-image: url("images/watermark-design.jpg");*/
            
        </style>
         
    </head>
    <body>
        

<!--        <div class="wrapper" style="text-align:center;margin:0 auto;">-->
            <div class="row">     <!--display:inline-block;-->
                <div class="col">    
                    <font color="red"><h1><b>Rupal's</b></h1><h4 style="padding-left: 120px;">creation</h4></font>
                </div>
                <div class="col">
                    <font color="blue"><h5><b>Exclusive Design OF</b></br>
                    -Dress-Sarees</br>
                    -Chaniya Choli</br>
                    -DesignerBlouse-Kurti
                    </h5>
                    </font>
                </div>    
            </div>
<!--        </div>-->
        <hr>
        <font color="red">  <h6 align="center"><b>FF-7, Gurudev Vatika, Nr. Nandalaya soc, Sama Savli Road,Vadodara.(M)7600016271</b></h6></font>
        <hr>
    
        <% 
          
        String order_id=request.getParameter("oid");
        int oid=Integer.parseInt(order_id);
        
        //out.println("<h6 align='left'>Bill no:"+" "+oid+ "</h6>");
        
        Date date=new Date();
        SimpleDateFormat ft = new SimpleDateFormat ("E dd.MM.yyyy 'at' hh:mm:ss a");
        int serial=1,count=1,max;    
        Connection con = Connect.getConnection();
        Statement stmt = con.createStatement();
        int id=0;
        
       // String order_id=request.getParameter("oid");
        //oid=Integer.parseInt(order_id);
        try{
        String query = "select * from `order` where order_id="+order_id;
        ResultSet rs = stmt.executeQuery(query);
        
        Statement stmt2 = con.createStatement();
        ResultSet rs2 = stmt2.executeQuery(query);
        rs2.next();
        
        Statement stmt3 = con.createStatement();
        String query2 = "select customer_id from `order` where order_id="+order_id;
        ResultSet rs3 = stmt3.executeQuery(query2);
        rs3.next();
        String customer_id=rs3.getString("customer_id");
        
        Statement stmt1 = con.createStatement();
        String query1 = "select sum(price) as total from `order` where customer_id="+"'"+customer_id+"'";   //here customer name is unique and 1 customer may have multiple order_ids. Actually there should be a customer table(customer_id,customer_name). customer_id should be unique
        ResultSet rs1 = stmt1.executeQuery(query1);
        rs1.next();
        
        int total=Integer.parseInt(rs1.getString("total"));
        int discount=(10*total)/100;
        int discountedTotal=total-discount;
        
        Statement stmt4 = con.createStatement();
        String query3 = "select count(distinct order_id) as rows from `order` where customer_id="+"'"+customer_id+"'" + "and order_id<"+order_id;
        //String query3 = "select count(order_id) as rows from `order` where order_id="+order_id;
        ResultSet rs4 = stmt4.executeQuery(query3);
        rs4.next();
        count=Integer.parseInt(rs4.getString("rows"));
        
        Statement stmt5 = con.createStatement();
        String query4 = "select max(order_id) as maximum from `order` where customer_id="+"'"+customer_id+"'";
        ResultSet rs5 = stmt5.executeQuery(query4);
        rs5.next();
        
        max=Integer.parseInt(rs5.getString("maximum"));
        serial=(9*count)+1;
        //serial=1;
//        "&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"
        out.println("<font color='blue'><h6 style='display:inline'>"+"Bill no: "+oid+"</h6><h6 style='float:right;display:inline'>"+ft.format(date)+"</h6></font>");        
        out.println("<h5>To "+rs2.getString("customer_name")+"</h5></br>");
        
        //out.println("<div class='watermark'></div>");
        //out.println("<div class='main'>");
        out.println("<table class='centered table' data-paging='true' align='center'>");
            out.println("<thead>");    
                out.println("<tr>");
                    out.println("<th align='center'>Sr.no.</th>");
                    out.println("<th data-field='item_no'>Item Number</th>");
                   // out.println("<th data-field='customer_name'>Customer Name</th>");
                    out.println("<th data-field='price'>Price</th>");
                out.println("</tr>");
            out.println("</thead>");
            
            
            
            while(rs.next())
            {
                out.println("<tbody>");
                    out.println("<tr>");
                            out.println("<td>" + (serial++) + "</td>");
                        out.println("<td>"+ rs.getString("item_no") + "</td>");
                      //  out.println("<td>" + rs.getString("customer_name") + "</td>");
                        out.println("<td>" + rs.getString("price") + "</td>");
                    out.println("</tr>"); 
                 out.println("</tbody>");   
            }  
                out.println("</tfoot>");
               // out.println("<table border='0' class='centered' align='center'>");    
                    out.println("<tr>");
                    //out.println("<table border='0' class='centered' align='center'>"); 
                           //out.println("<tr>");
                            out.println("<th colspan='2'><b>TOTAL</b></th>");
                            
                           // out.println("<td></td>");
                           if(oid==max){
                           //if(serial==count+1){
                            out.println("<th><b>" + rs1.getString("total") + "</b></th>");
                            out.println("</tr>");   
                            /*out.println("<tr>");
                            out.println("<th colspan='2'><b>DISCOUNT</b></th>");
                            out.println("<th><b>"+ discount +"</b></th>");
                            out.println("</tr>");
                            
                            out.println("<tr>");
                            out.println("<th colspan='2'><b>DISCOUNTED TOTAL</b></th>");
                            out.println("<th><b>"+ discountedTotal +"</b></th>");
                            out.println("</tr>");*/
                           } 
                           else{
                            out.println("<th></th>");
                             //out.println("</tr>"); 
                           // out.println("</table>");    
                            out.println("</tr>");   
                           }
                          
                // out.println("</table>");   
                out.println("</tfoot>");    
            
            out.println("</table>");
            //out.println("</div>");
        }
        catch(Exception e){
                String message="No customer for this order id !";
                RequestDispatcher rd=request.getRequestDispatcher("generatebill.jsp");
                request.setAttribute("msg",message);
                rd.forward(request,response);
            }
        
            %>
                   
<!--            <div class="wrapper" style="text-align:center;margin: auto;">-->
                <div class="row" style="">     <!--padding-left:120px;-->
                    <font color="red">
                        <h6>- First Wash Dry clean</br>
                            - No Exchange-No Return</br>
                            - No Guarantee for Fabric & Colour.</br>
                            - THANKS
                        </h6>
                    </font>    
                </div>
<!--            </div>-->
<!--            <footer>
                <h5>For Rupal's Creation</h5>
            </footer>-->

    </body>
</html>
