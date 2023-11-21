/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
package dbapplication;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;

public class Donor {
        public int donorid;
        public String firstname, lastname, middlename;
        public Date birthday;
        public String gender;
        public int age;
        public String mobileno;
        public String filepath;
        
        public Donor(){
     
        }
        
        public int calculateAge(LocalDate birthdate, LocalDate currentDate) {
            if ((birthdate != null) && (currentDate != null)) {
                return Period.between(birthdate, currentDate).getYears();
            } 
            else {
                throw new IllegalArgumentException("Birthdate and currentDate must not be null");
            }
        }

        private int generateDonorID(){
            
            int newDonorId = 1000;
            
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
                            // Get the maximum donor ID from the result set
                            int maxDonorId = resultSet.getInt("maxId");
        
                            // Increment the maximum patient ID to get the new patient ID
                            newDonorId = maxDonorId + 1;
                        }
                    }
                }
                return newDonorId;
            } catch (SQLException e) {
                    System.out.println(e.getMessage());  
                    return 0;
                }  
             
        }

        public ArrayList<Integer> list_donors() {
            ArrayList<Integer> donor_idlist = new ArrayList<>();
            
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                PreparedStatement sql_statement = conn.prepareStatement("SELECT      donorid " + 
                                                                         "FROM       donor "  +
                                                                         "ORDER BY   donorid");
                ResultSet results = sql_statement.executeQuery();
                
                donor_idlist.clear();
                
                while(results.next()) {
                    donor_idlist.add(results.getInt("donorid"));
                }

                sql_statement.close();
                conn.close();

                return donor_idlist;
            } catch(SQLException e) {
                return donor_idlist;
            }
        }
        
        public ArrayList<Integer> list_deletable_donors() {
            ArrayList<Integer> deletable_idlist = new ArrayList<> ();

            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                PreparedStatement sql_statement = conn.prepareStatement("SELECT donorid " +
                                                                        "FROM   donor  " +
                                                                        "WHERE  donorid NOT IN (SELECT  donor " +
                                                                        "                       FROM    donation) " +
                                                                        "ORDER BY donorid");
                ResultSet results = sql_statement.executeQuery();

                deletable_idlist.clear();

                while(results.next()) {
                    deletable_idlist.add(results.getInt("donorid"));
                }

                sql_statement.close();
                conn.close();

                return deletable_idlist;
            } catch(SQLException e) {
                return deletable_idlist;
            }
        }
        
        public int addRecord(String firstname, String middlename, String lastname, String gender, String birthday, String mobileno, String filepath){
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO person VALUES (?,?,?,?,?,?,?,?)");
        
                age = calculateAge(LocalDate.parse(birthday), LocalDate.now());
                donorid = generateDonorID();
                         
                // 5. Supply the statement with values
                pstmt.setInt    (1, donorid);
                pstmt.setString (2, firstname);
                pstmt.setString (3, lastname);
                pstmt.setString (4, middlename);
                pstmt.setString (5, gender);
                pstmt.setString (6, birthday);
                pstmt.setInt    (7, age);
                pstmt.setString (8, filepath);
        
                // 6. Execute the SQL Statement
                pstmt.executeUpdate();
                
                PreparedStatement donorPstmt = conn.prepareStatement("INSERT INTO donor VALUES (?,?)");
                donorPstmt.setInt(1, donorid);
                donorPstmt.setString(2, mobileno);
        
                donorPstmt.executeUpdate();
                
                pstmt.close();
                donorPstmt.close();
                conn.close();
                return donorid;
            } catch (SQLException e) {
                    System.out.println(e.getMessage());  
                    return 0;
                }  
        }
        
        public int modRecord (int donorid, String firstname, String middlename, String lastname, String gender, String birthday, String mobileno, String filepath) {           // Method modify a Record
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
                                                                "       picture      = ? " +
                                                                "WHERE  personid      = ? "
                                                                );
                
                age = calculateAge(LocalDate.parse(birthday), LocalDate.now());
                // 5. Supply the statement with values
                pstmt.setString (1, firstname);
                pstmt.setString (2, lastname);
                pstmt.setString (3, middlename);
                pstmt.setString (4, gender);
                pstmt.setString (5, birthday);
                pstmt.setInt    (6, age);
                pstmt.setString (7, filepath);
                pstmt.setInt    (8, donorid);
                
                pstmt.executeUpdate();   
                pstmt.close();
                
                PreparedStatement donorPstmt = conn.prepareStatement("UPDATE donor           " +
                                                                     "SET    mobileno     = ? " +
                                                                     "WHERE  donorid      = ? "
                                                                       );
                                                                
                donorPstmt.setString (1, mobileno);
                donorPstmt.setInt (2, donorid);
                
                donorPstmt.executeUpdate();
                donorPstmt.close();
        
                conn.close();
                return 1;
                
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return 0;
            }         
        }
        
        public int delRecord (int donorid) {           // Method delete a Record
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement 
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM donor WHERE donorid = ?");
                // 5. Supply the statement with values
                pstmt.setInt    (1, donorid);

                // 6. Execute the SQL Statement
                pstmt.executeUpdate();
                
                pstmt = conn.prepareStatement("DELETE FROM person WHERE personid = ?");
                
                pstmt.setInt(1, donorid);
                
                pstmt.executeUpdate();
                
                
                pstmt.close();
                conn.close();
                return 1;
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return 0;
            }         
        }

        //public int searchRecord () {}

        public int viewRecord() {           // Method viewing a  - Getting something
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM person WHERE personid = ?");
                // 5. Supply the statement with values
                pstmt.setInt    (1, donorid);

                // 6. Execute the SQL Statement
                ResultSet rs = pstmt.executeQuery();   

                // 7. Get the results
                while (rs.next()) {
                    donorid    = rs.getInt("personid");
                    firstname    = rs.getString("firstname");
                    lastname     = rs.getString("lastname");
                    middlename   = rs.getString("middlename");
                    gender       = rs.getString("gender");
                    birthday     = rs.getDate("birthday");
                    age          = rs.getInt("age");
                    filepath     = rs.getString("picture");
                    mobileno     = rs.getString("mobileno");
                }
                
                rs.close();
                pstmt.close();
                conn.close();
                return 1;
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return 0;
            }
        }
}    
