<%-- 
    Document   : patients-add
    Created on : 11 18, 23, 6:04:32 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="dbapplication.Patient" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.net.URLEncoder" %>

<%
    // Check if the form is submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Retrieve form data
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String middlename = request.getParameter("middlename");
        String birthdayStr = request.getParameter("birthday");
        String gender = request.getParameter("gender");
        String filepath = request.getParameter("filepath");
        String admissionStr = request.getParameter("admissiondate");
        String dischargeStr = request.getParameter("discharge");

        // Convert date strings to LocalDate
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate birthday = LocalDate.parse(birthdayStr, formatter);
        LocalDate admission = LocalDate.parse(admissionStr, formatter);
        LocalDate discharge = null;

        // Check if discharge date is provided
        if (dischargeStr != null && !dischargeStr.isEmpty()) {
            discharge = LocalDate.parse(dischargeStr, formatter);
        }

        // Create an instance of the Patient class
        Patient medBean = new Patient();

        // Set values for the Patient instance
        medBean.firstname = firstname;
        medBean.lastname = lastname;
        medBean.middlename = middlename;
        medBean.birthday = java.sql.Date.valueOf(birthday); // Convert LocalDate to java.sql.Date
        medBean.gender = gender.substring(0,1);
        medBean.filepath = filepath;
        medBean.admission = java.sql.Date.valueOf(admission);
        medBean.discharge = (discharge != null) ? java.sql.Date.valueOf(discharge) : null;

        // Add the record to the database
        int result = medBean.addRecord();
        String message, returnurl = "patients-add.jsp";
        
        // Check the result and perform further actions (e.g., display a success message or handle errors)
        if (result == 1) {
            message = "Record added successfully!";
            session.setAttribute("s_patientid", Integer.toString(medBean.patientid));
            session.setAttribute("s_firstname", medBean.firstname);
            session.setAttribute("s_lastname", medBean.lastname);
            session.setAttribute("s_middlename", medBean.middlename);
            session.setAttribute("s_birthday", birthdayStr);
            session.setAttribute("s_gender", medBean.gender);
            session.setAttribute("s_filepath", medBean.filepath);
            session.setAttribute("s_admissiondate", admissionStr);
            if (dischargeStr != null && !dischargeStr.isEmpty()) {
                session.setAttribute("s_discharge", dischargeStr);
            }
        } else {
            message = "Error adding record.";
        }
        
        session.setAttribute("message", message);
        session.setAttribute("returnurl", returnurl);
        response.sendRedirect("results-display.jsp");
    }
%>

<html>
<head>
    <title>Add a Patient</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../maincss.css">
    <style>
        .normbtn:disabled {
            background-color: #dddddd; /* Use a gray color for the background */
            color: #999999; /* Use a lighter gray color for the text */
            cursor: not-allowed; /* Show a 'not-allowed' cursor */
        }
    </style>
    <script>
        function validateForm() {
            // Get form field values
            var firstName = document.getElementById("fname").value;
            var lastName = document.getElementById("lname").value;
            var middleName = document.getElementById("mname").value;
            var birthday = document.getElementById("birthday").value;
            var gender = document.getElementById("gender").value;
            var filepath = document.getElementById("filepath").value;
            var admissiondate = document.getElementById("admissiondate").value;

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
</head>
<body>
    <div class="container">
        <h1>Add a Patient</h1>
        <hr>
        <form name="addpatient" action="" method="POST" oninput="validateForm()"> <!-- Use oninput to trigger the validation -->
            First Name<sup>*</sup> : <input type="text" name="firstname" id="fname" required><br>
            Last Name<sup>*</sup> : <input type="text" name="lastname" id="lname" required><br>
            Middle Name<sup>*</sup> : <input type="text" name="middlename" id="mname" required><br>
            Birthday<sup>*</sup> : <input type="date" name="birthday" id="birthday" required><br><br>
            Gender<sup>*</sup> : <select name="gender" id="gender" required> 
                        <option value="" disabled selected hidden>Select Gender</option>
                        <option value="Male"> Male </option>                        
                        <option value="Female"> Female </option>    
                    </select><br><br>
            Picture File Path<sup>*</sup> : <input type="text" name="filepath" id="filepath" required> <br>
            Admission Date<sup>*</sup> : <input type="date" name="admissiondate" id="admissiondate" required><br><br>
            Discharge Date : <input type="date" name="discharge" id="discharge"><br><br>
            <input type="submit" value="Submit" name="Submit" class="normbtn" id="submitBtn" disabled /><br>
            <i><sup>*</sup>Required Fields</i><br>
        </form> 
        <button onclick="location.href = 'selection-patients.jsp';" class="normbtn">Return to Previous Menu</button>
    </div>
</body>
</html>