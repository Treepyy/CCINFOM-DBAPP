<%-- 
    Document   : filterresults
    Created on : 11 22, 23, 6:11:58 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="dbapplication.Patient" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <link rel="stylesheet" href="../maincss.css">
</head>
<body>
    <div class="container">
        <h2>Search Results</h2>
        <h3>${searchResult}</h3>
        <button onclick="location.href = 'selection-patients.jsp';" type="submit" class="normbtn">Filter Again</button>
        <button onclick="location.href = 'selection-patients.jsp';" type="submit" class="normbtn">Return to Main Menu</button>
    </div>
</body>
</html>
