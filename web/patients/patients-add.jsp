<%-- 
    Document   : patients-add
    Created on : 11 18, 23, 6:04:32 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, dbapplication.*" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Add a Patient</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../maincss.css">
    </head>
    <body>
        <div class="container">
            <h1>Add a Patient</h1>
                    <hr>
                    <jsp:useBean id="medBean" class="dbapplication.Patient" scope="session" />
                    <% medBean.addRecord(); %>
                    <form name="addpatient" action="patient-add.jsp" method="POST">
                        First Name: <input type="text" name="firstname" id="fname"><br>
                        Last Name:  <input type="text" name="lastname" id="lname"><br>
                        Middle Name:  <input type="text" name="lastname" id="mname"><br>
                        Birthday: <input type="date" name="birthday" id="birthday"><br><br>
                        Gender: <select name="gender" id="gender"> 
                                    <option value="Male"> Male </option>                        
                                    <option value="Female"> Female </option>    
                                </select><br>
                    </form>
                    <form name="submitorder" action="submitorder.jsp" method = "POST">
                        <br>
                        <input type="submit" value="Submit" name="Submit" class ="normbtn" /><br>
                    </form> 
            <button onclick="location.href = 'selection-patients.jsp';" class="normbtn">Return to Previous Menu</button>
        </div>
    </body>
</html>