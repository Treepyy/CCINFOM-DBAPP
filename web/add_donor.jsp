<%-- 
    Document   : register
    Created on : 04 16, 23, 2:24:54 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dbapplication.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Register Donor</title>
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
        <form action="add_donor_processing.jsp">
            <jsp:useBean id="A" class="dbapplication.Donor" scope="session"/>
            <div style="font-size: 24px; margin-top: 50px; margin-bottom: 20px;"> <b>Register Donor</b> </div><br>
            <div style="display: flex; justify-content: center;">
                <table style="text-align: left;">
                <tr>
                    <td style="padding-bottom: 5px; padding-right: 15px;">First Name:</td>
                    <td style="padding-bottom: 5px;"><input type="text" id="firstname" name="firstname" minlength="1" maxlength="45"
                            style="width: 200px;" required></td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-right: 15px;">Middle Initial:</td>
                    <td style="padding-bottom: 5px;"><input type="text" id="middlename" name="middlename"
                            style="width: 200px;"></td>
                </tr>
                <tr>
                    <td style="padding-bottom: 20px; padding-right: 15px;">Last Name:</td>
                    <td style="padding-bottom: 20px;"><input type="text" id="lastname" name="lastname" minlength="1" maxlength="45"
                            style="width: 200px;" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-bottom: 20px;">
                        <fieldset>
                            <legend>Gender:</legend>
                            <input type="radio" id="true" name="gender" value="M" required>
                            <label for="true">Male</label><br>
                            <input type="radio" id="false" name="gender" value="F">
                            <label for="false">Female</label>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 20px; padding-right: 15px;">Birthday:</td>
                    <td style="padding-bottom: 20px;"><input type="date" id="birthday" name="birthday"
                            style="width: 200px;" required>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-right: 15px;">Mobile Number:</td>
                    <td style="padding-bottom: 5px;">
                        <input type="number" id="mobileno" name="mobileno" minlength="12" maxlength="12" style="width: 200px;" required>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-right: 15px;">Picture(File name):</td>
                    <td style="padding-bottom: 5px;">
                        <input type="text" id="filepath" name="filepath" minlength="1" maxlength="45" style="width: 200px;">
                    </td>
                </tr>
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
