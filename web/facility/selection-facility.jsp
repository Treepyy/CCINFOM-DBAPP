<%-- 
    Document   : selection-facility
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
        <title>Manage Facility Records</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Manage Facility Records</h1>
            <hr>
            <button onclick="location.href = 'facility-add.jsp';" type="submit" class="normbtn">Add a Facility</button>
            <button onclick="location.href = 'facility-update.jsp';" type="submit" class="normbtn">Update Facility Information</button>
            <button onclick="location.href = 'facility-delete.jsp';" type="submit" class="normbtn">Delete a Facility Record</button>
            <button onclick="location.href = 'facility-search.jsp';" type="submit" class="normbtn">Search for a Facility</button>
            <button onclick="location.href = 'facility-filter.jsp';" type="submit" class="normbtn">Filter and List Facilities</button>
            <button onclick="location.href = '../selection.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
        </div>
    </body>
</html>
