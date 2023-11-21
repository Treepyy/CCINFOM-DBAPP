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
        String status = request.getParameter("status");
        String facilityid = request.getParameter("facility");

        // Convert date strings to LocalDate
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate birthday = LocalDate.parse(birthdayStr, formatter);
        LocalDate admission = null;
        LocalDate discharge = null;
            
        Patient medBean = new Patient();
        
        // Check if discharge and/or admission date is provided
        if (admissionStr != null && !admissionStr .isEmpty()) {
            admission = LocalDate.parse(admissionStr, formatter);
            medBean.admission = java.sql.Date.valueOf(admission);
        }
        
        if (dischargeStr != null && !dischargeStr.isEmpty()) {
            discharge = LocalDate.parse(dischargeStr, formatter);
            medBean.discharge = java.sql.Date.valueOf(discharge);
            status = "D";
        }       

        // Set values for the Patient instance
        medBean.firstname = firstname;
        medBean.lastname = lastname;
        medBean.middlename = middlename;
        medBean.birthday = java.sql.Date.valueOf(birthday); // Convert LocalDate to java.sql.Date
        medBean.gender = gender.substring(0,1);
        medBean.filepath = filepath;
        medBean.status = status;
        medBean.facilityid = Integer.parseInt(facilityid);

        // Add the record to the database
        int result = medBean.addRecord();
        String message, buttonLbl, returnurl = "patients-add.jsp";
        buttonLbl = "Add Another Record";
        
        // Check the result and perform further actions (e.g., display a success message or handle errors)
        if (result == 1) {
            message = "Record added successfully!";
            session.setAttribute("s_patientid", Integer.toString(medBean.patientid));
            session.setAttribute("s_firstname", medBean.firstname);
            session.setAttribute("s_lastname", medBean.lastname);
            session.setAttribute("s_middlename", medBean.middlename);
            session.setAttribute("s_birthday", birthdayStr);
            session.setAttribute("s_age", medBean.age);
            session.setAttribute("s_gender", medBean.gender);
            session.setAttribute("s_filepath", medBean.filepath);
            if (medBean.facilityid == 0){
               session.setAttribute("s_facilityid", ""); 
            } else {
               session.setAttribute("s_facilityid", medBean.facilityid); 
            }
            session.setAttribute("s_admissiondate", medBean.admission);
            session.setAttribute("s_discharge", medBean.discharge);
            session.setAttribute("s_status", medBean.status);
        } else {
            message = "Error adding record.";
        }
        
        session.setAttribute("message", message);
        session.setAttribute("returnurl", returnurl);
        session.setAttribute("buttonLbl", buttonLbl);
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
        .date:disabled{
            background-color: #dddddd;
            color: #999999;
            cursor: not-allowed;
        }
        .select:disabled{
            background-color: #dddddd;
            color: #999999;
            cursor: not-allowed;
        }
    </style>
    <script>
        function validateForm() {
            // Get form field values
            var firstName = document.getElementById("fname").value;
            var lastName = document.getElementById("lname").value;
            var birthday = document.getElementById("birthday").value;
            var gender = document.getElementById("gender").value;
            var admissiondate = document.getElementById("admissiondate").value;
            var discharge = document.getElementById("discharge").value;
            var status = document.getElementById("status").value;
            var facility = document.getElementById("facility").value;

            // Check if all req fields are filled
            if (firstName !== "" && lastName !== "" && birthday !== "" && gender !== "") {
                // Enable the submit button
                document.getElementById("submitBtn").disabled = false;
            } else {
                // Disable the submit button
                document.getElementById("submitBtn").disabled = true;
            }
            
            console.log(facility);
            if (facility !== "0"){
                console.log(facility);
                document.getElementById("admissiondate").disabled = false;
                
                 if (admissiondate !== "") {
                    document.getElementById("discharge").disabled = false;
                    document.getElementById("status").disabled = false;
                    document.getElementById("status").requred = true;

                    if (status==="D"){
                        document.getElementById("status").value = "A";
                    }
                    else if (status===""){
                        document.getElementById("status").value = "A";
                    }

                    if (discharge !== ""){
                        document.getElementById("status").value = "D";
                        document.getElementById("status").disabled = true;
                    }
                    else{
                        document.getElementById("status").disabled = false;
                    }
                    
                    // Date check
                    var birthdayDate = new Date(birthday);
                    var admissionDate = new Date(admissiondate);
                    var dischargeDate = new Date(discharge);
                    
                    // invalids
                    if (admissionDate < birthdayDate) {
                        document.getElementById("submitBtn").disabled = true;
                        alert("Invalid date range. Admission date cannot be EARLIER than birth date.");
                    } 
                    else if (admissionDate > dischargeDate){
                        document.getElementById("submitBtn").disabled = true;
                        alert("Invalid date range. Discharge date cannot be EARLIER than admission date.");
                    }
                    else {
                        // Valid dates
                        document.getElementById("submitBtn").disabled = false;
                    }

                } else {
                    document.getElementById("status").disabled = true;  
                    document.getElementById("status").value = "";
                    document.getElementById("discharge").disabled = true;
                    document.getElementById("discharge").value = "";
                }
            }
            
            else{
                console.log("pong");
                document.getElementById("admissiondate").disabled = true;
                document.getElementById("admissiondate").value = null;
            }
            

        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Add a Patient</h1>
        <hr>
        <jsp:useBean id="medBean" class="dbapplication.Patient" scope="session" />
        <form name="addpatient" action="" method="POST" oninput="validateForm()"> <!-- Use oninput to trigger the validation -->
            First Name<sup>*</sup> : <input type="text" name="firstname" id="fname" required><br>
            Last Name<sup>*</sup> : <input type="text" name="lastname" id="lname" required><br>
            Middle Name : <input type="text" name="middlename" id="mname" ><br>
            Birthday<sup>*</sup> : <input type="date" name="birthday" id="birthday" required><br><br>
            Gender<sup>*</sup> : <select name="gender" id="gender" required> 
                        <option value="" disabled selected hidden>Select Gender</option>
                        <option value="Male"> Male </option>                        
                        <option value="Female"> Female </option>    
                    </select><br><br>
            Picture File Path : <input type="text" name="filepath" id="filepath"> <br>
            Health Facility : <select name="facility" id="facility">
                              <option value = "0">None</option>
                              <% 
                                ArrayList<Integer> facilityIDs = medBean.getFacilityIDs();
                                for (int id : facilityIDs) { %>
                                <option value="<%=id%>"><%=medBean.getFacilityName(id)%></option>                        
                              <% } %>
                    </select><br><br>
            Admission Date : <input type="date" name="admissiondate" id="admissiondate" disabled><br><br>
            Discharge Date : <input type="date" name="discharge" id="discharge" disabled><br><br>
            Status : <select name="status" id="status" disabled> 
                        <option value="" selected hidden>No Status</option>
                        <option value="A"> Admitted </option>  
                        <option value="U"> Under Medication </option>
                        <option value="D" hidden> Discharged </option>
                    </select><br><br>
            <input type="submit" value="Submit" name="Submit" class="normbtn" id="submitBtn" disabled /><br>
            <i><sup>*</sup>Required Fields</i><br>
        </form> 
        <button onclick="location.href = 'selection-patients.jsp';" class="normbtn">Return to Previous Menu</button>
    </div>
</body>
</html>