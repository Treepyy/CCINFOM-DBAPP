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
                        <td>Age</td>
                        <td>${s_age}</td>
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
                        <td>Facility ID</td>
                        <td>${s_facilityid}</td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td>${s_admissiondate}</td>
                    </tr>
                    <tr>
                        <td>Discharge Date</td>
                        <td>${s_discharge}</td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>${s_status}</td>
                    </tr>
                </table>
        <%
            }
        %>
        
        <%-- Display the previous and new information in tables if the record was updated successfully --%>
        <%
           if (message.equals("Record updated successfully!")) {
        %>
                <h3> Old Record</h3>
                <table border="1">
                    <tr>
                        <th>Field</th>
                        <th>Value</th>
                    </tr>
                    <tr>
                        <td>Patient ID</td>
                        <td><${prev_patientid}></td>
                    </tr>
                    <tr>
                        <td>First Name</td>
                        <td>${prev_firstname}</td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td>${prev_lastname}</td>
                    </tr>
                    <tr>
                        <td>Middle Name</td>
                        <td>${prev_middlename}</td>
                    </tr>
                    <tr>
                        <td>Birthday</td>
                        <td>${prev_birthday}</td>
                    </tr>
                    <tr>
                        <td>Gender</td>
                        <td>${prev_gender}</td>
                    </tr>
                    <tr>
                        <td>Photo</td>
                        <td>${prev_filepath}</td>
                    </tr>
                    <tr>
                        <td>Facility ID</td>
                        <td>${prev_facilityid}</td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td>${prev_admissiondate}</td>
                    </tr>
                    <tr>
                        <td>Discharge Date</td>
                        <td>${prev_discharge}</td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>${prev_status}</td>
                    </tr>
                </table>
                    
                <h3> New Record</h3>
                <table border="1">
                    <tr>
                        <th>Field</th>
                        <th>Value</th>
                    </tr>
                    <tr>
                        <td>Patient ID</td>
                        <td><${new_patientid}></td>
                    </tr>
                    <tr>
                        <td>First Name</td>
                        <td>${new_firstname}</td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td>${new_lastname}</td>
                    </tr>
                    <tr>
                        <td>Middle Name</td>
                        <td>${new_middlename}</td>
                    </tr>
                    <tr>
                        <td>Birthday</td>
                        <td>${new_birthday}</td>
                    </tr>
                    <tr>
                        <td>Gender</td>
                        <td>${new_gender}</td>
                    </tr>
                    <tr>
                        <td>Photo</td>
                        <td>${new_filepath}</td>
                    </tr>
                    <tr>
                        <td>Facility ID</td>
                        <td>${new_facilityid}</td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td>${new_admissiondate}</td>
                    </tr>
                    <tr>
                        <td>Discharge Date</td>
                        <td>${new_discharge}</td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>${new_status}</td>
                    </tr>
                </table>
        <%
            }
        %>
        
        <br>
        <button onclick="location.href = '${returnurl}';" class="normbtn">${buttonLbl}</button><br>
        <button onclick="location.href = 'selection-patients.jsp';" class="normbtn">Back to Selection</button>
        
    </div>
</body>
</html>
