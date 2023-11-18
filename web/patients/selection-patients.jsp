<%-- 
    Document   : selection-patients
    Created on : 11 18, 23, 6:02:59 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Manage Patients' Records</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Manage Patients' Records</h1>
            <hr>
            <button onclick="location.href = 'patients-add.jsp';" type="submit" class="normbtn">Add a Patient</button>
            <button onclick="location.href = 'patients-update.jsp';" type="submit" class="normbtn">Update Patient Information</button>
            <button onclick="location.href = 'patients-delete.jsp';" type="submit" class="normbtn">Delete a Patient Record</button>
            <button onclick="location.href = 'patients-search.jsp';" type="submit" class="normbtn">Search for a Patient</button>
            <button onclick="location.href = 'patients-filter.jsp';" type="submit" class="normbtn">Filter and List Patients</button>
            <button onclick="location.href = '../selection.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
        </div>
    </body>
</html>
