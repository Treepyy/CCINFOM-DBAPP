<%-- 
    Document   : patients-search
    Created on : 11 18, 23, 6:03:54 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="dbapplication.Patient" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>View a Patient Record</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>View a Patient Record</h1>
            <hr>
            <form name="viewPatient" action="patients-view.jsp" method="POST">
            Enter Patient ID: <input type="text" name="patientid" required><br>
            <input type="submit" value="View" name="View" class="normbtn"><br>
            </form>

            <%
                // Check if the form is submitted (searching by id)
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String patientIdStr = request.getParameter("patientid");
                    int patientId = 0;

                    try {
                        // Convert the patientIdStr to integer
                        patientId = Integer.parseInt(patientIdStr);

                        // Create an instance of the Patient class
                        Patient medBean = new Patient();

                        // Set patientid for searching
                        medBean.patientid = patientId;

                        // Check if the record exists
                        int result = medBean.viewRecord();
                        String facilityID = "";

                        if (result == 1) {


                        // Display the record details
            %>
                        <h2>Patient Details</h2>
                        <table border="1">
                            <tr>
                                <th>Field</th>
                                <th>Value</th>
                            </tr>
                            <tr>
                                <td>Patient ID</td>
                                <td><%= medBean.patientid %></td>
                            </tr>
                            <tr>
                                <td>First Name</td>
                                <td><%= medBean.firstname %></td>
                            </tr>
                            <tr>
                                <td>Last Name</td>
                                <td><%= medBean.lastname %></td>
                            </tr>
                            <tr>
                                <td>Middle Name</td>
                                <td><%= medBean.middlename %></td>
                            </tr>
                            <tr>
                                <td>Birthday</td>
                                <td><%= medBean.birthday %></td>
                            </tr>
                            <tr>
                                <td>Gender</td>
                                <td><%= medBean.gender %></td>
                            </tr>
                            <tr>
                                <td>File Path</td>
                                <td><%= medBean.filepath %></td>
                            </tr>
                            <tr>
                                <td>Facility ID</td>
                                <td><%= facilityID %></td>
                            </tr>
                            <tr>
                                <td>Admission Date</td>
                                <td><%= medBean.admission %></td>
                            </tr>
                            <tr>
                                <td>Discharge Date</td>
                                <td><%= medBean.discharge %></td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td><%= medBean.status %></td>
                            </tr>
                        </table>
        <%
                    } else {
                        // Record not found, display a message()
        %>
                        <script> alert("Record not found."); </script>
        <%
                    }
                } catch (NumberFormatException e) {
                    // Handle invalid input for patientId
        %>
                    <script> alert("Please enter a valid patient ID."); </script>
        <%
                }
            }
        %>  <br>
            <button onclick="location.href = 'selection-patients.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
        </div>
    </body>
</html>
