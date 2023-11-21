<%-- 
    Document   : patients-update
    Created on : 11 18, 23, 6:03:40 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="dbapplication.Patient" %>
<%@ page import="java.net.URLEncoder" %>

<%!
public int currentPatientID;
%>

<%
    // Check if the form is submitted
    if (request.getParameter("Update") != null) {
        
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
        medBean.patientid = currentPatientID;
        medBean.firstname = firstname;
        medBean.lastname = lastname;
        medBean.middlename = middlename;
        medBean.birthday = java.sql.Date.valueOf(birthday); // Convert LocalDate to java.sql.Date
        medBean.gender = gender.substring(0,1);
        medBean.filepath = filepath;
        medBean.status = status;
        medBean.facilityid = Integer.parseInt(facilityid);

        String result = medBean.modRecord();
        String message, buttonLbl, returnurl = "patients-update.jsp";
        buttonLbl = "Update Another Record";
        
        // Check the result and perform further actions (e.g., display a success message or handle errors)
        if (result == "1") {
            message = "Record updated successfully!";
            session.setAttribute("new_patientid", Integer.toString(medBean.patientid));
            session.setAttribute("new_firstname", medBean.firstname);
            session.setAttribute("new_lastname", medBean.lastname);
            session.setAttribute("new_middlename", medBean.middlename);
            session.setAttribute("new_birthday", birthdayStr);
            session.setAttribute("new_gender", medBean.gender);
            session.setAttribute("new_filepath", medBean.filepath);
            if (medBean.facilityid == 0){
               session.setAttribute("new_facilityid", ""); 
            } else {
               session.setAttribute("new_facilityid", medBean.facilityid); 
            }
            session.setAttribute("new_admissiondate", medBean.admission);
            session.setAttribute("new_discharge", medBean.discharge);
            session.setAttribute("new_status", medBean.status);
        } else {
            message = "Error updating record." + "Error Code: " + result;
        }
        
        session.setAttribute("message", message);
        session.setAttribute("returnurl", returnurl);
        session.setAttribute("buttonLbl", buttonLbl);
        response.sendRedirect("results-display.jsp");
    }
%>

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
                        
                        // Store current results in session attr
                        session.setAttribute("prev_patientid", Integer.toString(medBean.patientid));
                        session.setAttribute("prev_firstname", medBean.firstname);
                        session.setAttribute("prev_lastname", medBean.lastname);
                        session.setAttribute("prev_middlename", medBean.middlename);
                        session.setAttribute("prev_birthday", medBean.birthday);
                        session.setAttribute("prev_gender", medBean.gender);
                        session.setAttribute("prev_filepath", medBean.filepath);
                        if (medBean.facilityid == 0){
                           session.setAttribute("prev_facilityid", ""); 
                        } else {
                           session.setAttribute("prev_facilityid", medBean.facilityid);
                           facilityID = Integer.toString(medBean.facilityid);
            
                        }
                        session.setAttribute("prev_admissiondate", medBean.admission);
                        session.setAttribute("prev_discharge", medBean.discharge);
                        session.setAttribute("prev_status", medBean.status);
                        
                        
                        // Display the record details and update form
        %>
                        <h2>Current Patient Details</h2>
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
                        <h2>Update Patient Details</h2>
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
                                <input type="submit" value="Update" name="Update" class="normbtn" id="submitBtn" disabled /><br>
                                <i><sup>*</sup>Required Fields</i><br>
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
        %>

        <button onclick="location.href = 'selection-patients.jsp';" class="normbtn">Return to Previous Menu</button>
    </div>
</body>
</html>

