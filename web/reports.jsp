<%-- 
    Document   : reports
    Created on : 11 18, 23, 5:59:52 PM
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
        <title>Generate Reports</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Generate Reports</h1>
            <hr>
            <button onclick="location.href = 'selection-patients.jsp';" type="submit" class="normbtn">Donation Frequency Report</button>
            <button onclick="location.href = 'selection-patients.jsp';" type="submit" class="normbtn">Patient Medicine Provision Report</button>
            <button onclick="location.href = 'index.jsp';" type="submit" class="normbtn">Return to Main</button>
        </div>
    </body>
</html>

