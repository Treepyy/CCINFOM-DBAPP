<%-- 
    Document   : selection-medicines
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
        <title>Manage Medicines Records</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Manage Medicines Records</h1>
            <hr>
            <button onclick="location.href = 'medicines-add.jsp';" type="submit" class="normbtn">Add a Medicine</button>
            <button onclick="location.href = 'medicines-update.jsp';" type="submit" class="normbtn">Update Medicine Information</button>
            <button onclick="location.href = 'medicines-delete.jsp';" type="submit" class="normbtn">Delete a Medicine Record</button>
            <button onclick="location.href = 'medicines-search.jsp';" type="submit" class="normbtn">Search for a Medicine</button>
            <button onclick="location.href = 'medicines-filter.jsp';" type="submit" class="normbtn">Filter and List Medicines</button>
            <button onclick="location.href = '../selection.jsp';" type="submit" class="normbtn">Return to Previous Menu</button>
        </div>
    </body>
</html>
