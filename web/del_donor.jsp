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
        <title>Delete Donor</title>
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
        <form action="del_donor_view.jsp">
            <jsp:useBean id="A" class="dbapplication.Donor" scope="session"/>
            <div style="font-size: 24px; margin-top: 50px; margin-bottom: 20px;"> <b>Delete Donor</b> </div><br>
            Select a donor to delete.<br><br>
            
                Donor: <select id="donorid" name="donorid">
                <%
                    ArrayList<Integer> deletable_idlist = new ArrayList<> ();
                    deletable_idlist = A.list_deletable_donors();

                    for (int i = 0; i < deletable_idlist.size(); i++) {
                %>
                        <option value ="<%= deletable_idlist.get(i)%>"><%= deletable_idlist.get(i)%></option>
                <%
                    }
                %>  
                </select><br>
            </div>
            <div style="margin-top: 30px;"><input type="submit" value="Submit"></div>
        </form>    
    </body>
</html>
