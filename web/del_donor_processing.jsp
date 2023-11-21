<%-- 
    Document   : deleteAS_processing
    Created on : 04 16, 23, 5:34:28 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dbapplication.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Donor Processing</title>
    </head>
    
    <body>
        <form action="index.html">
            <jsp:useBean id="A" class="dbapplication.Donor" scope="session"/>
            <%  
               
                int donorid = (Integer) session.getAttribute("passdonor");

                int status = A.delRecord(donorid);

                if (status == 1) {
            %>
            <h1>Deleting Donor Successful!</h1>
            <%
                } else {
            %>
            <h1>Deleting Donor Failed!</h1>
            <%
                }
            %>
            <input type="submit" value="Return">
        </form>   
    </body>
</html>
