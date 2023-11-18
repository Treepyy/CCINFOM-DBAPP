<%-- 
    Document   : selection
    Created on : 11 18, 23, 5:57:23 PM
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
        <title>Medicine Inventory and Donations Management</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Manage Records</h1>
            <hr>
            <button onclick="location.href = 'selection.jsp';" type="submit" class="normbtn">Medicines</button>
            <button onclick="location.href = 'selection.jsp';" type="submit" class="normbtn">Donors</button>
            <button onclick="location.href = 'patients/selection-patients.jsp';" type="submit" class="normbtn">Patients</button>
            <button onclick="location.href = 'selection.jsp';" type="submit" class="normbtn">Health Facilities</button>
            <button onclick="location.href = 'index.jsp';" type="submit" class="normbtn">Return to Main</button>
        </div>
    </body>
</html>
