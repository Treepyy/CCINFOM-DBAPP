<%-- 
    Document   : register_processing
    Created on : 04 15, 23, 8:56:53 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dbapplication.*" %>
<%@page import="java.time.*, dbapplication.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Donor Processing</title>
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
        <form action="index.html">
            <jsp:useBean id="donation" class="dbapplication.Donation" scope="session"/>
            <%  
                int donorid = Integer.parseInt(request.getParameter("donorid"));
                int facilityid = Integer.parseInt(request.getParameter("facilityid"));
                int medicineid = Integer.parseInt(request.getParameter("medicineid"));
                
                
                int status = donation.createDonation(donorid, facilityid, medicineid);

                if (status != 0) {
            %>
            <h1> Donation created </h1>
            <%
                } else {
            %>
            <h1> Donation failed </h1>
            <%
                }
            %>
            <input type="submit" value="Return">
        </form>
    </body>

</html>



