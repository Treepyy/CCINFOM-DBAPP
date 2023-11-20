<%-- 
    Document   : index
    Created on : 11 18, 23, 5:56:07 PM
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
          <h1>Welcome</h1>
          <hr>
          <p>Medicine Inventory and Donations Management Database Application</p>
          <button onclick="location.href = 'selection.jsp';" type="submit" class="normbtn">Manage Records</button>
          <button onclick="location.href = 'transactions.jsp';" type="submit" class="normbtn">Transactions</button>
          <button onclick="location.href = 'reports.jsp';" type="submit" class="normbtn">Generate Reports</button>
        </div>
    </body>    
</html>