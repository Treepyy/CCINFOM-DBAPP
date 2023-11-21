<%-- 
    Document   : register
    Created on : 04 16, 23, 2:24:54 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dbapplication.*" %>
<%@page import="java.sql.*, dbapplication.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Create Donation</title>
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
        <form action="donation_processing.jsp">
            \
            <jsp:useBean id="B" class="dbapplication.Donor" scope="session"/>
            <div style="font-size: 24px; margin-top: 50px; margin-bottom: 20px;"> <b>Create Donation</b> </div><br>
            Select a donor, health facility, and medicine. <br><br>
            <div style="display: flex; justify-content: center;">
                <table style="text-align: left;">
                    
           
                <% 
                ArrayList<Integer> donor_idlist = new ArrayList<> ();
                donor_idlist = B.list_donors();    
                
                    
                ArrayList<Integer> facility_idlist = new ArrayList<> ();
                ArrayList<Integer> medicine_idlist = new ArrayList<> ();
                
                try {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                    PreparedStatement sql_statement = conn.prepareStatement("SELECT      facilityid " + 
                                                                             "FROM       health_facility "  +
                                                                             "ORDER BY   facilityid");
                    ResultSet results = sql_statement.executeQuery();

                    facility_idlist.clear();

                    while(results.next()) {
                        facility_idlist.add(results.getInt("facilityid"));
                    }

                    sql_statement.close();
                    conn.close();

                    
                } catch(SQLException e) {
                    
                }
                
                try {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                    PreparedStatement sql_statement = conn.prepareStatement("SELECT      medicineid " + 
                                                                             "FROM       medicine "  +
                                                                             "ORDER BY   medicineid");
                    ResultSet results = sql_statement.executeQuery();

                    medicine_idlist.clear();

                    while(results.next()) {
                        medicine_idlist.add(results.getInt("medicineid"));
                    }

                    sql_statement.close();
                    conn.close();

                    
                } catch(SQLException e) {
                    
                }

                %>
        
                Donor: 
                <select id="donorid" name="donorid">
                    <% for (int i = 0; i < donor_idlist.size(); i++) { %>
                        <option value ="<%= donor_idlist.get(i) %>"><%= donor_idlist.get(i) %></option>
                    <% } %>
                </select>
                
                
                Health Facility: 
                <select id="facilityid" name="facilityid">
                    <% for (int j = 0; j < facility_idlist.size(); j++) { %>    
                        <option value ="<%= facility_idlist.get(j) %>"><%= facility_idlist.get(j) %></option>
                    <% } %>
                </select>
                
                Medicine:
                <select id="medicineid" name="medicineid">
                    <% for(int k = 0; k < medicine_idlist.size(); k++) { %>
                        <option value ="<%= medicine_idlist.get(k) %>"><%= medicine_idlist.get(k) %>"</option>
                    <% } %>
                </select>
                        
                        
                <tr>
                    <td colspan="2" style="padding-bottom: 20px;">
                        <input type="submit" value="Submit">
                    </td>
                </tr>
                </table>
            </div>
        </form>
    </body>
</html>
