<%-- 
    Document   : deleteAS
    Created on : 04 16, 23, 5:23:43 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dbapplication.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>View Donor</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: "Lucida Console", Monaco, monospace;
            }

            button {
                display: block;
                margin: auto;
            }
        </style>
    </head>
    
    
    <body style="text-align: center;">
        <form action="view_donor_processing.jsp">
            <jsp:useBean id="A" class="dbapplication.Donor" scope="session"/>
            <div style="font-size: 24px; margin-top: 50px; margin-bottom: 20px;"> <b>View Donor</b> </div><br>
            Select a donor to view.<br><br>
            
                Donor: <select id="donorid" name="donorid">
                <%
                    ArrayList<Integer> donor_idlist = new ArrayList<> ();
                    donor_idlist = A.list_donors();

                    for (int i = 0; i < donor_idlist.size(); i++) {
                %>
                        <option value ="<%= donor_idlist.get(i)%>"><%= donor_idlist.get(i)%></option>
                <%
                    }
                %>  
                </select><br>
            </div>
            <div style="margin-top: 30px;"><input type="submit" value="Submit"></div>
        </form>    
    </body>
</html>
