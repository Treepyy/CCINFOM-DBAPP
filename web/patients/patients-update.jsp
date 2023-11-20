<%-- 
    Document   : patients-update
    Created on : 11 18, 23, 6:03:40 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="dbapplication.Patient" %>
<%@ page import="java.net.URLEncoder" %>

<html>
<head>
    <title>Update a Patient</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../maincss.css">
</head>
<body>
    <div class="container">
        <h1>Update a Patient</h1>
        <hr>

        <form name="updatePatient" action="patients-update.jsp" method="POST">
            Enter Patient ID: <input type="text" name="patientid" required><br>
            <input type="submit" value="Search" name="Search" class="normbtn"><br>
        </form>

        <%
            // Check if the form is submitted
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

                    if (result == 1) {
                        // Record found, display the record details and update form
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
                                <td>Admission Date</td>
                                <td><%= medBean.admission %></td>
                            </tr>
                            <tr>
                                <td>Discharge Date</td>
                                <td><%= medBean.discharge %></td>
                            </tr>
                        </table>
                        
                          <script>
                            function validateForm() {
                                // Get form field values
                                var firstName = document.getElementById("new_firstname").value;
                                var lastName = document.getElementById("new_lastname").value;
                                var middleName = document.getElementById("new_middlename").value;
                                var birthday = document.getElementById("new_birthday").value;
                                var gender = document.getElementById("new_gender").value;
                                var filepath = document.getElementById("new_filepath").value;
                                var admissiondate = document.getElementById("new_admission").value;

                                // Check if all fields are filled
                                if (firstName !== "" && lastName !== "" && middleName !== "" && birthday !== "" && gender !== "" && filepath !== "" && admissiondate !== "") {
                                    // Enable the submit button
                                    document.getElementById("submitBtn").disabled = false;
                                } else {
                                    // Disable the submit button
                                    document.getElementById("submitBtn").disabled = true;
                                }
                            }
                        </script>
                        <h2>Update Patient Details</h2>
                        <form name="updateForm" action="results-display.jsp" method="POST">
                            <!-- Add input fields for updating the record -->
                            First Name: <input type="text" name="new_firstname" value="<%= medBean.firstname %>" required><br>
                            Last Name: <input type="text" name="new_lastname" value="<%= medBean.lastname %>" required><br>
                            Middle Name: <input type="text" name="new_middlename" value="<%= medBean.middlename %>"><br>
                            Birthday: <input type="date" name="new_birthday" value="<%= medBean.birthday %>" required><br>
                            Gender: 
                            <select name="new_gender">
                                <option value="Male" <%= medBean.gender.equals("Male") ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= medBean.gender.equals("Female") ? "selected" : "" %>>Female</option>
                            </select><br>
                            File Path: <input type="text" name="new_filepath" value="<%= medBean.filepath %>" required><br>
                            Admission Date: <input type="date" name="new_admission" value="<%= medBean.admission %>" required><br>
                            Discharge Date: <input type="date" name="new_discharge" value="<%= medBean.discharge %>"><br>

                            <input type="hidden" name="patientid" value="<%= medBean.patientid %>">
                            <input type="submit" value="Update" name="Update" class="normbtn">
                        </form>
        <%
                    } else {
                        // Record not found, display a message
        %>
                        <p>Record not found.</p>
        <%
                    }
                } catch (NumberFormatException e) {
                    // Handle invalid input for patientId
        %>
                    <p>Please enter a valid Patient ID.</p>
        <%
                }
            }
        %>

        <button onclick="location.href = 'selection-patients.jsp';" class="normbtn">Return to Previous Menu</button>
    </div>
</body>
</html>

