<%-- 
    Document   : selection-donors
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
        <title>Manage Donors Records</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Manage Donors Records</h1>
            <hr>
            <button onclick="location.href = 'donors-add.jsp';" type="submit" class="normbtn">Add a Donor</button>
            <button onclick="location.href = 'donors-update.jsp';" type="submit" class="normbtn">Update Donor Information</button>
            <button onclick="location.href = 'donors-delete.jsp';" type="submit" class="normbtn">Delete a Donor Record</button>
            <button onclick="location.href = 'donors-search.jsp';" type="submit" class="normbtn">Search for a Donor</button>
            <button onclick="location.href = 'donors-filter.jsp';" type="submit" class="normbtn">Filter and List Donors</button>
            <button onclick="location.href = '../selection.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
        </div>
    </body>
</html>
