<%-- 
    Document   : patients-filter
    Created on : 11 18, 23, 6:04:06 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="dbapplication.Patient" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>

<%
    if (request.getParameter("Submit") != null) {
        // Get parameters from the request
        String firstname = request.getParameter("firstNameInputField");
        String lastname = request.getParameter("lastNameInputField");
        String gender = request.getParameter("genderInputField");
        String status = request.getParameter("statusInputField");
        String facilityid = request.getParameter("facilityInputField");

        // Count the number of filters
        int filterCount = 0;
        ArrayList<String> filtersList = new ArrayList<>();
        
        Patient searchFor = new Patient();
        // Add filters based on non-null parameters
        if (firstname != null && !firstname.isEmpty()) {
            filtersList.add("firstname");
            searchFor.firstname = firstname;
            filterCount++;
        }
        if (lastname != null && !lastname.isEmpty()) {
            filtersList.add("lastname");
            searchFor.lastname = lastname;
            filterCount++;
        }
        if (gender != null && !gender.isEmpty()) {
            filtersList.add("gender");
            searchFor.gender = gender;
            filterCount++;
        }
        if (status != null && !status.isEmpty()) {
            filtersList.add("status");
            searchFor.status = status;
            filterCount++;
        }
        if (facilityid != null && !facilityid.isEmpty()) {
            filtersList.add("facility");
            searchFor.facilityid = Integer.parseInt(facilityid);
            filterCount++;
        }

        // Convert filtersList to an array
        String[] filters = filtersList.toArray(new String[5]);

        String resultSet = searchFor.searchRecord(filters, filterCount);
        out.println("Results : ");
        out.println(resultSet);
   
        //String resultString = String.join("\n", resultSet);
        
        //session.setAttribute("searchResult", resultString);
        // response.sendRedirect("results-display.jsp");
        

    }
%>
<html>
<head>
    <title>Filter Patients</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../maincss.css">
    <script>
        function toggleInput(type) {
            var inputElement = document.getElementById(type + "Input");
            var checkbox = document.getElementById(type + "Checkbox");
            inputElement.style.display = checkbox.checked ? "block" : "none";
            
            // Enable or disable input based on checkbox state
            var inputField = document.getElementById(type + "InputField");
            inputField.disabled = !checkbox.checked;

            checkSubmitButton();
        }

        function checkSubmitButton() {
            var checkboxes = document.querySelectorAll('input[type="checkbox"]');
            var submitButton = document.getElementById('submitButton');

            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    submitButton.disabled = false;
                    return;
                }
            }
            submitButton.disabled = true;
        }

        function submitForm() {
            // Collect and display values here
            var lastNameField = document.getElementById('lastNameInputField');
            var lastName = document.getElementById('lastNameCheckbox').checked && !lastNameField.disabled ? lastNameField.value : '';

            var firstNameField = document.getElementById('firstNameInputField');
            var firstName = document.getElementById('firstNameCheckbox').checked && !firstNameField.disabled ? firstNameField.value : '';

            var facilityField = document.getElementById('facilityInputField');
            var facility = document.getElementById('facilityCheckbox').checked && !facilityField.disabled ? facilityField.value : '';

            var statusField = document.getElementById('statusInputField');
            var status = document.getElementById('statusCheckbox').checked && !statusField.disabled ? statusField.value : '';

            var genderField = document.getElementById('genderInputField');
            var gender = document.getElementById('genderCheckbox').checked && !genderField.disabled ? genderField.value : '';
            <% 
            
            %>
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Filter Patients</h1>
        <hr>
        <jsp:useBean id="medBean" class="dbapplication.Patient" scope="session" />
        <form action="" method="post">
        <label>
            <input type="checkbox" id="lastNameCheckbox" onclick="toggleInput('lastName')"> Last Name
        </label><br>
        <div id="lastNameInput" style="display: none;">
            <input name="lastNameInputField" id="lastNameInputField" type="text" placeholder="Enter last name" disabled>
        </div>

        <label>
            <input type="checkbox" id="firstNameCheckbox" onclick="toggleInput('firstName')"> First Name
        </label><br>
        <div id="firstNameInput" style="display: none;">
            <input name="firstNameInputField" id="firstNameInputField" type="text" placeholder="Enter first name" disabled>
        </div>

        <label>
            <input type="checkbox" id="facilityCheckbox" onclick="toggleInput('facility')"> Facility
        </label><br>
        <div id="facilityInput" style="display: none;">
            <select name="facilityInputField" id="facilityInputField" disabled>
                               <option value = "None">None</option>
                              <% 
                                ArrayList<Integer> facilityIDs = medBean.getFacilityIDs();
                                for (int id : facilityIDs) { %>
                                <option value="<%=id%>"><%=medBean.getFacilityName(id)%></option>                        
                              <% } %>
            </select><br><br>
        </div>

        <label>
            <input type="checkbox" id="statusCheckbox" onclick="toggleInput('status')"> Status
        </label><br>
        <div id="statusInput" style="display: none;">
            <select name="statusInputField" id="statusInputField" disabled>
                <option value = "NS">None</option>
                <option value="A">Admitted</option>
                <option value="U">Under Medication</option>
                <option value="D">Discharged</option>
                <!-- Add more status options as needed -->
            </select><br><br>
        </div>

        <label>
            <input type="checkbox" id="genderCheckbox" onclick="toggleInput('gender')"> Gender
        </label><br>
        <div id="genderInput" style="display: none;">
            <select name="genderInputField" id="genderInputField" disabled>
                <option value="M">Male</option>
                <option value="F">Female</option>
                <!-- Add more gender options as needed -->
            </select><br><br>
        </div>
        <button id="submitButton" type="submit" value="Submit" name ="Submit" class="normbtn" disabled>Submit</button>
        <button onclick="location.href = 'selection-patients.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
    </form>
    </div>
</body>
</html>



