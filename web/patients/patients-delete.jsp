<%-- 
    Document   : patients-delete
    Created on : 11 18, 23, 6:04:22 PM
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

<%!
public int currentPatientID;
%>

<%
    // Check if the form is submitted
    if (request.getParameter("Delete") != null) {
        
        Patient medBean = new Patient();
        medBean.patientid = currentPatientID;
        
        String message, buttonLbl, returnurl = "patients-delete.jsp";
        buttonLbl = "Delete Another Record";
        
        int result = medBean.delRecord();
        if (result == 1) {
            message = "Record deleted successfully!";
        } else {
            message = "Record could not be deleted.";
        }
        
        session.setAttribute("message", message);
        session.setAttribute("returnurl", returnurl);
        session.setAttribute("buttonLbl", buttonLbl);
        response.sendRedirect("results-display.jsp");
        
        
    } %>

<html>
    <head>
        <title>Delete a Patient</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
        <div class="container">
            <h1>Delete a Patient</h1>
            <hr>
            <form name="deletePatient" action="patients-delete.jsp" method="POST">
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
                        currentPatientID = patientId;

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
                        <br>
                        <form name="deletePatientForm" action="patients-delete.jsp" method="POST" onsubmit="return confirm('Are you sure you want to delete this patient?');">
                                <input type="hidden" name="patientid" value="<%= currentPatientID %>">
                                <input type="submit" value="Delete" name="Delete" class="normbtn" id="submitBtn" /><br>
                        </form>
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
