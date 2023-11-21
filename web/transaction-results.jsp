<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbapplication.Patient" %>

<html>
<head>
    <title>Result</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="maincss.css">
</head>
<body>
    <div class="container">
        <h1>${message}</h1>
        <hr>
        <%-- Display the information in a table if the record was added successfully --%>
        <%
            String message = (String) session.getAttribute("message");
            if (message.equals("Medicine Tracking Record Saved!")) {
        %>
                <table border="1">
                    <tr>
                        <th>Field</th>
                        <th>Value</th>
                    </tr>
                    <tr>
                        <td>Patient ID</td>
                        <td><${t_patientid}></td>
                    </tr>
                    <tr>
                        <td>Facility ID</td>
                        <td>${t_facilityid}</td>
                    </tr>
                    <tr>
                        <td>Medicine ID</td>
                        <td>${t_medicineid}</td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td>${t_admission}</td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>${t_status}</td>
                    </tr>
                    <tr>
                        <td>Administer Date</td>
                        <td>${t_addate}</td>
                    </tr>
                    <tr>
                        <td>Amount Given</td>
                        <td>${t_amtgiven}</td>
                    </tr>
                </table>
        <%
            }
        %>
        
        <button onclick="location.href = '${returnurl}';" class="normbtn">${buttonLbl}</button><br>
        <button onclick="location.href = 'transactions.jsp';" class="normbtn">Back to Selection</button>
        
    </div>
</body>
</html>
