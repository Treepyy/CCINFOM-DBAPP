/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbapplication;
import java.sql.*;
import java.util.ArrayList;
import java.time.LocalDate;
import java.time.Period;

/**
 *
 * @author Treepyy
 */

public class Patient {
        
        public int patientid;
        public String firstname, lastname, middlename;
        public Date birthday, admission, discharge;
        public String gender;
        public int age;
        public String filepath;
        public int facilityid;
        public String status;
        
        public Patient(){
     
        }
        
        private int calculateAge(LocalDate birthdate, LocalDate currentDate) {
            if ((birthdate != null) && (currentDate != null)) {
                return Period.between(birthdate, currentDate).getYears();
            } 
            else {
                throw new IllegalArgumentException("Birthdate and currentDate must not be null");
            }
        }
        
        private int generatePatientID(){
            
            int newPatientId = 1000;
            
             try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                
                String query = "SELECT MAX(personid) AS maxId FROM person";
                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    // Execute the query
                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        if (resultSet.next()) {
                            // Get the maximum patient ID from the result set
                            int maxPatientId = resultSet.getInt("maxId");

                            // Increment the maximum patient ID to get the new patient ID
                            newPatientId = maxPatientId + 1;
                        }
                    }
                }
                return newPatientId;
            } catch (SQLException e) {
                    System.out.println(e.getMessage());  
                    return 0;
                }  
             
        }
    
        public int addRecord(){
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO person VALUES (?,?,?,?,?,?,?,?)");

                age = calculateAge(birthday.toLocalDate(), LocalDate.now());
                patientid = generatePatientID();
                         
                // 5. Supply the statement with values
                pstmt.setInt    (1, patientid);
                pstmt.setString (2, firstname);
                pstmt.setString (3, lastname);
                pstmt.setString (4, middlename);
                pstmt.setString (5, gender);
                pstmt.setDate   (6, birthday);
                pstmt.setInt    (7, age);
                pstmt.setString (8, filepath);

                // 6. Execute the SQL Statement
                pstmt.executeUpdate();
                
                PreparedStatement patientPstmt = conn.prepareStatement("INSERT INTO patient (patientid, facilityid, admission, discharge, patientstatus) "
                                                                     + "VALUES (?,?,?,?,?)");
                patientPstmt.setInt(1, patientid);
                if (facilityid == 0){
                    patientPstmt.setNull(2, Types.INTEGER);
                }
                else{
                    patientPstmt.setInt(2, facilityid);  
                }
                patientPstmt.setDate(3, admission);
                patientPstmt.setDate(4, discharge);
                patientPstmt.setString(5, status);
                
                patientPstmt.executeUpdate();
                
                pstmt.close();
                patientPstmt.close();
                conn.close();
                return 1;
            } catch (SQLException e) {
                    System.out.println(e.getMessage());  
                    return 0;
                }  
        }
        
        public String modRecord () {           // Method modify a Record
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement("UPDATE person            " +
                                                                "SET    firstname     = ?," +
                                                                "       lastname      = ?," +
                                                                "       middlename    = ?," +
                                                                "       gender        = ?," +
                                                                "       birthday      = ?," +
                                                                "       age           = ?," +
                                                                "       picture       = ? " +
                                                                "WHERE  personid      = ? "
                                                                );
                // 5. Supply the statement with values
                age = calculateAge(birthday.toLocalDate(), LocalDate.now());
                
                pstmt.setString (1, firstname);
                pstmt.setString (2, lastname);
                pstmt.setString (3, middlename);
                pstmt.setString (4, gender);
                pstmt.setDate   (5, birthday);
                pstmt.setInt    (6, age);
                pstmt.setString (7, filepath);
                pstmt.setInt    (8, patientid);
                
                pstmt.executeUpdate();   
                pstmt.close();
                
                PreparedStatement patientPstmt = conn.prepareStatement("UPDATE patient           " +
                                                                       "SET    facilityid    = ?," +
                                                                       "       admission     = ?," +
                                                                       "       discharge     = ?," +
                                                                       "       patientstatus = ? " +
                                                                       "WHERE  patientid     = ? "
                                                                       );
                                                                
                if (facilityid == 0){
                    patientPstmt.setNull(1, Types.INTEGER);
                }
                else{
                    patientPstmt.setInt(1, facilityid);  
                }
                patientPstmt.setDate(2, admission);
                patientPstmt.setDate(3, discharge);
                patientPstmt.setString(4, status);
                patientPstmt.setInt(5, patientid);
                
                patientPstmt.executeUpdate();
                patientPstmt.close();

                conn.close();
                return "1";
                
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return e.getMessage();
            }         
        }
        
        public int delRecord () {           // Method delete a Record
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM person WHERE personid = ?");
                // 5. Supply the statement with values
                pstmt.setInt    (1, patientid);
                
                PreparedStatement patientPstmt = conn.prepareStatement("DELETE FROM patient WHERE patientid = ?");
                patientPstmt.setInt     (1, patientid);

                // 6. Execute the SQL Statement
                patientPstmt.executeUpdate();
                pstmt.executeUpdate();
                
                
                pstmt.close();
                patientPstmt.close();
                conn.close();
                return 1;
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return 0;
            }         
        }
        
      public int viewRecord() {           // Method viewing a  - Getting something
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement(
                           "SELECT patientid, firstname, lastname, middlename, gender, birthday, age, picture, facilityid, admission, discharge, patientstatus " + 
                           "FROM person JOIN patient " + 
                           "ON patient.patientid = person.personid " +
                           "WHERE  patientid = ?;"
                        );
                
                /*
                SELECT personid, firstname, lastname, middlename, gender, birthday, age, picture, admission, discharge
                FROM person
                JOIN patient ON patient.patientid = person.personid
                WHERE personid = ?;
                */
                // 5. Supply the statement with values
                pstmt.setInt    (1, patientid);

                // 6. Execute the SQL Statement
                ResultSet rs = pstmt.executeQuery();   

                // 7. Get the results
                while (rs.next()) {
                    patientid    = rs.getInt("patientid");
                    firstname    = rs.getString("firstname");
                    lastname     = rs.getString("lastname");
                    middlename   = rs.getString("middlename");
                    gender       = rs.getString("gender");
                    birthday     = rs.getDate("birthday");
                    age          = rs.getInt("age");
                    filepath     = rs.getString("picture");
                    facilityid   = rs.getInt("facilityid");
                    admission    = rs.getDate("admission");
                    discharge    = rs.getDate("discharge");
                    status       = rs.getString("patientstatus");
                }
                
                rs.close();
                pstmt.close();
                conn.close();
                
                if (firstname == null){
                    return 2;
                }
                
                return 1;
                
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return 0;
            }           
      }
      
     public ArrayList<Integer> getFacilityIDs(){
         
            ArrayList<Integer> facilityIDs = new ArrayList<>();
            
            try {

                Connection conn;     

                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                System.out.println("Connection Successful");

                PreparedStatement pstmt = conn.prepareStatement(
                           "SELECT facilityid " + 
                           "FROM health_facility; "
                        );

                ResultSet rs = pstmt.executeQuery();   

                // 7. Get the results
                while (rs.next()) {
                    facilityIDs.add(rs.getInt("facilityid"));
                }
                
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
            } 
            
            return facilityIDs;
     }
     
     public String getFacilityName(int facilityid){
         
            try {

                Connection conn;     

                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                System.out.println("Connection Successful");

                PreparedStatement pstmt = conn.prepareStatement(
                           "SELECT facilityname "  + 
                           "FROM health_facility " + 
                           "WHERE facilityid = "   + facilityid + ";"
                        );
                
                String name = "";
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()){
                    name = rs.getString("facilityname");
                }
                
                
                rs.close();
                pstmt.close();
                conn.close();
                
                return name;
                
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return null;
            } 
         
     }
     
      
     public static void main (String[] args) {
        
        /*ArrayList<Integer> facilityIDs = getFacilityIDs();
        for (int id : facilityIDs){
            System.out.println(id + " : " + getFacilityName(id));
        }*/
        
        /*
        testp.firstname = "Bob";
        testp.lastname = "Bobby";
        testp.middlename = "Bobbins";
        testp.birthday = Date.valueOf(LocalDate.of(2002, 06, 22));
        testp.filepath = "Bob.png";
        testp.gender = "M";
        testp.addRecord();*/
        
        Patient testp = new Patient();
        testp.patientid = 1017;
        testp.delRecord();
        
        /*
        testp.firstname = "bb";
        testp.modRecord();
        System.out.println(testp.modRecord());
        System.out.println(testp.firstname);*/
        
        // OD.ordernumber = 8001;
        // OD.pcode       = 7002;
        // OD.qty         = 500;
        // OD.price       = 2;
        // OD.addRecord();
        
        // OD.ordernumber = 8001;
        // OD.pcode       = 7002;
        // OD.qty         = 50;
        // OD.price       = 1;
        // OD.modRecord();

        // OD.ordernumber = 8001;
        // OD.pcode       = 7002;        
        // OD.delRecord();
        
        // OD.ordernumber = 8001;
        // OD.pcode       = 7003;        
        // OD.viewRecord();
        // System.out.println (OD.ordernumber);
        // System.out.println (OD.pcode);
        // System.out.println (OD.qty);
        // System.out.println (OD.price);

     }
    
}
