<%-- 
    Document   : results-display
    Created on : 11 20, 23, 7:10:36 PM
    Author     : ccslearner
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbapplication.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <title>Result</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../maincss.css">
</head>
<body>
    <div class="container">
        <h1>${message}</h1>
        <hr>
        <%-- Display the information in a table if the record was added successfully --%>
        <%
            String message = (String) session.getAttribute("message");
            if (message.equals("Record added successfully!")) {
        %>
                <table border="1">
                    <tr>
                        <th>Field</th>
                        <th>Value</th>
                    </tr>
                    <tr>
                        <td>Patient ID</td>
                        <td><${s_patientid}></td>
                    </tr>
                    <tr>
                        <td>First Name</td>
                        <td>${s_firstname}</td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td>${s_lastname}</td>
                    </tr>
                    <tr>
                        <td>Middle Name</td>
                        <td>${s_middlename}</td>
                    </tr>
                    <tr>
                        <td>Birthday</td>
                        <td>${s_birthday}</td>
                    </tr>
                    <tr>
                        <td>Gender</td>
                        <td>${s_gender}</td>
                    </tr>
                    <tr>
                        <td>Photo</td>
                        <td>${s_filepath}</td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td>${s_admissiondate}</td>
                    </tr>
                    <tr>
                        <td>Discharge Date</td>
                        <td>${s_discharge}</td>
                    </tr>
                </table>
        <%
            }
        %>
        <button onclick="location.href = '${returnurl}';" class="normbtn">Return to Previous Menu</button>
    </div>
</body>
</html>