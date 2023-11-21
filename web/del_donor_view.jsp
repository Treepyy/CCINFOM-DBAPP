<%-- 
    Document   : register_processing
    Created on : 04 15, 23, 8:56:53 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dbapplication.*" %>
<%@page import="java.time.*, dbapplication.*" %>
<%@page import="java.sql.*, dbapplication.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> View Donor Processing</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%; /* Table takes up full width */
                table-layout: fixed; /* Fixed table layout */
            }
            th, td {
                padding: 8px; /* Padding for cells */
                text-align: left; /* Left-align cell content */
                border: 1px solid black; /* Add borders for cells */
                width: 100px; /* Default column width */
                word-wrap: break-word; /* Allow content to wrap within cells */
            }
            th {
                background-color: lightgray; /* Background color for headers */
            }
            tr:nth-child(even) td {
                background-color: #f2f2f2; /* Zebra striping for even rows */
            }
        </style>
    </head>
    
    <body>
        <form action="del_donor_processing.jsp">
            <jsp:useBean id="A" class="dbapplication.Donor" scope="session"/>
            <% 
                
                int donorid = Integer.parseInt(request.getParameter("donorid"));
                session.setAttribute("passdonor", donorid);
                
                String db_firstname = "";
                String db_middlename = "";
                String db_lastname = "";
                String db_gender = "";
                String db_birthday = "";
                String db_age = "";
                String db_mobileno = "";
                String db_filepath = "";
               
                try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our SELECT Statement   
                
                PreparedStatement pstmt = conn.prepareStatement("SELECT p.firstname, p.middlename, p.lastname, p.gender, p.birthday, p.age, p.picture, " +
                                                                "       d.mobileno " +
                                                                "FROM   person p LEFT JOIN donor d" +
                                                                "                ON (d.donorid = p.personid) " +
                                                                "WHERE  personid = ?");
                
                
                pstmt.setInt    (1, donorid);
               
                ResultSet rst = pstmt.executeQuery();
                
                if(rst.next()) {
                    db_firstname = rst.getString("firstname");
                    db_middlename = rst.getString("middlename");
                    db_lastname = rst.getString("lastname");
                    db_gender = rst.getString("gender");
                    db_birthday = rst.getString("birthday");
                    db_age = rst.getString("age");
                    db_filepath = rst.getString("picture");
                    db_mobileno = rst.getString("mobileno");
                }
                
                pstmt.close();
                rst.close();
                conn.close();
            } catch (Exception e) {
               System.out.println(e.getMessage());
            }
                    
            %>

            <table>

                <tr>
                    <th> ID </th>
                    <th> First name </th> 
                    <th> Middle initial </th>
                    <th> Last name </th>
                    <th> Gender </th>
                    <th> Birthday </th>
                    <th> Age </th>
                    <th> Picture (File name) </th>
                    <th> Mobile number </th>
                </tr>
                <tr>
                    <td> <%= donorid %> </td>
                    <td> <%= db_firstname %> </td>
                    <td> <%= db_middlename %> </td>
                    <td> <%= db_lastname %> </td>
                    <td> <%= db_gender %> </td>
                    <td> <%= db_birthday %> </td>
                    <td> <%= db_age %> </td>
                    <td> <%= db_filepath %> </td>
                    <td> <%= db_mobileno %> </td>
                </tr>
                
           
            <input type="submit" value="Delete">
        </form>
                
    </body>

</html>


