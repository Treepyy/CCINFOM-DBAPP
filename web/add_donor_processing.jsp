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
            <jsp:useBean id="donor" class="dbapplication.Donor" scope="session"/>
            <%  
                String entry_firstname = request.getParameter("firstname");
                String entry_middlename = request.getParameter("middlename");
                String entry_lastname = request.getParameter("lastname");
                String entry_gender = request.getParameter("gender");
                String str_birthday = request.getParameter("birthday");
                String entry_mobileno = request.getParameter("mobileno");
                String entry_filepath = request.getParameter("filepath");

                int status = donor.addRecord(entry_firstname, entry_middlename, entry_lastname,
                                            entry_gender, str_birthday, entry_mobileno,
                                            entry_filepath);

                int age = donor.calculateAge(LocalDate.parse(str_birthday), LocalDate.now());


                if (status != 0) {
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
                    <td> <%= status %> </td>
                    <td> <%= entry_firstname %> </td>
                    <td> <%= entry_middlename %> </td>
                    <td> <%= entry_lastname %> </td>
                    <td> <%= entry_gender %> </td>
                    <td> <%= str_birthday %> </td>
                    <td> <%= age %> </td>
                    <td> <%= entry_filepath %> </td>
                    <td> <%= entry_mobileno %> </td>
                </tr>
            <%
                } else {
            %>
            <h1>Updating Donor Failed!</h1>
            <%
                }
            %>
            <input type="submit" value="Return">
        </form>
    </body>

</html>


