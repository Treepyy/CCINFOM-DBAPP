<%-- 
    Document   : medicine-tracking
    Created on : 11 21, 23, 11:16:12 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="dbapplication.Patient, dbapplication.Medication_Tracking, dbapplication.Medicine" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%!
int currentFacility;
%>

<%
    // Check if the form is submitted
    if (request.getParameter("Submit") != null) {
        // Retrieve form data
        String selectedPatient = request.getParameter("patient");
        String selectedMedicine = request.getParameter("medicine");
        String dischargeStr = request.getParameter("discharge");
        String status = request.getParameter("status");
        String amtgiven = request.getParameter("amount");
        
        Patient currPatient = new Patient();
        Medication_Tracking medTrack = new Medication_Tracking();
        currPatient.patientid = Integer.parseInt(selectedPatient);
        
        // updating patient status
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate discharge = null;
        
        if (dischargeStr != null && !dischargeStr .isEmpty()) {
            discharge = LocalDate.parse(dischargeStr, formatter);
            currPatient.updatePatientStatus(java.sql.Date.valueOf(discharge));
            currPatient.viewRecord();
            
        }
        
        else{
            // creating medtrack records if patient is not discharged
            // updates to under medication (U) after assigning
           medTrack.amtgiven = Integer.parseInt(amtgiven);
           medTrack.assignMedicineToAdmittedPatient(Integer.parseInt(selectedMedicine), Integer.parseInt(selectedPatient));
           currPatient.status = "U";
           currPatient.updatePatientStatus(); 
           currPatient.viewRecord();
           
           session.setAttribute("t_patientid", currPatient.patientid);
           session.setAttribute("t_facilityid", currPatient.facilityid);
           session.setAttribute("t_medicineid", selectedMedicine);
           session.setAttribute("t_admission", currPatient.admission);
           session.setAttribute("t_status", currPatient.status);
           session.setAttribute("t_addate", medTrack.administer);
           session.setAttribute("t_amtgiven", medTrack.amtgiven);
           response.sendRedirect("transaction-results.jsp");
        }
        
        session.setAttribute("message", "Medicine Tracking Record Saved!");
        session.setAttribute("returnurl", "medicine-tracking.jsp");
        session.setAttribute("buttonLbl", "Another Transaction");
        
        
        

   
    }
%>
<html>
<head>
    <title>Medicine Tracking</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="maincss.css">
    <script>
        function updateOptions() {
            var facility = document.getElementById("facility").value;
            // Redirect to the same page with the selected facility as a parameter
            window.location.href = 'medicine-tracking.jsp?facility=' + facility;
        }
    </script>
    <script>
        function validateForm(){
            var discharge = document.getElementById("discharge").value;
            
            if (discharge !== ""){
                document.getElementById("status").value = "D";
                document.getElementById("status").disabled = true;
            }
            else{
                if (document.getElementById('status').value === "D"){
                   document.getElementById("status").value = "A";
                }
                document.getElementById("status").disabled = false;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Assign Medicine to a Patient</h1>
        <hr>
        <jsp:useBean id="medBean" class="dbapplication.Patient" scope="session" />
        <jsp:useBean id="cinBean" class="dbapplication.Medicine" scope="session" />
        <jsp:useBean id="trackingBean" class="dbapplication.Medication_Tracking" scope="session" />

        <!-- Submit button for selecting the facility -->
        <form name="selectFacilityForm" action="" method="GET">
            Select Your Health Facility : 
            <select name="facility" id="facility">
                <% 
                    ArrayList<Integer> facilityIDs = medBean.getFacilityIDs();
                    for (int id : facilityIDs) { 
                %>
                    <option value="<%=id%>" <%= (String.valueOf(id).equals(request.getParameter("facility"))) ? "selected" : "" %>><%=medBean.getFacilityName(id)%></option>                        
                <% } %>
            </select>
            <br><br>
            <input type="submit" value="Select Facility" class="normbtn"><br>
        </form>

        <% 
            // Check if the facility is selected
            String selectedFacility = request.getParameter("facility");
            if (selectedFacility != null) {
                currentFacility = Integer.parseInt(selectedFacility);
        %>

            <!-- Form for selecting patient, medicine, etc. -->
            <form name="addpatient" action="" method="POST" oninput="validateForm()"> <!-- Use oninput to trigger the validation -->
                Select Admitted Patient<sup>*</sup> : <select name="patient" id="patient" required>
                                 <% String currFacility = request.getParameter("facility");
                                    ArrayList<Integer> patientIDs = medBean.getPatientIDs(currentFacility);
                                    for (int id : patientIDs) { %>
                                    <option value="<%=id%>"><%=medBean.getPatientName(id)%></option>                        
                                  <% } %>
                </select><br><br>

                Select Medicine to Give<sup>*</sup> : <select name="medicine" id="medicine" required>
                                  <% 
                                    ArrayList<Integer> medicineIDs = cinBean.getMedicineIDs(currentFacility);
                                    for (int id : medicineIDs) { %>
                                    <option value="<%=id%>"><%=cinBean.getMedicineName(id)%></option>                        
                                    <% } %></select><br><br>
                Amount<sup>*</sup> : <input type ="number", name="amount", id="amount", min="1", max="100" required><br><br>
                <input type="hidden" name="selectedFacility" value="<%=currentFacility%>">
                <input type="submit" value="Submit" name="Submit" class="normbtn" id="submitBtn" /><br>
                <i><sup>*</sup>Required Fields</i><br>
            </form>

        <% } %>

        <button onclick="location.href = 'transactions.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
    </div>
</body>
</html>
