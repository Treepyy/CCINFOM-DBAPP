/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbapplication;
import java.sql.*;
import java.time.LocalDate;
import java.time.Period;

/**
 *
 * @author Treepyy
 */

public class Patient {
        
        public int patientid;
        public String firstname, lastname, middlename;
        public Date birthday;
        public String gender;
        public int age;
        public String filepath;
        
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
                pstmt.close();
                conn.close();
                return 1;
            } catch (SQLException e) {
                    System.out.println(e.getMessage());  
                    return 0;
                }  
        }
        
        public int modRecord () {           // Method modify a Record
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
                                                                "       filepath      = ? " +
                                                                "WHERE  personid      = ? "
                                                                );
                // 5. Supply the statement with values
                // 5. Supply the statement with values
                pstmt.setString (1, firstname);
                pstmt.setString (2, lastname);
                pstmt.setString (3, middlename);
                pstmt.setString (4, gender);
                pstmt.setDate   (5, birthday);
                pstmt.setInt    (6, age);
                pstmt.setString (7, filepath);
                pstmt.setInt    (8, patientid);

                // 6. Execute the SQL Statement
                pstmt.executeUpdate();   
                pstmt.close();
                conn.close();
                return 1;
                
            } catch (SQLException e) {
                System.out.println(e.getMessage());  
                return 0;
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

                // 6. Execute the SQL Statement
                pstmt.executeUpdate();   
                pstmt.close();
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
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM person WHERE personid = ?");
                // 5. Supply the statement with values
                pstmt.setInt    (1, patientid);

                // 6. Execute the SQL Statement
                ResultSet rs = pstmt.executeQuery();   

                // 7. Get the results
                while (rs.next()) {
                    patientid    = rs.getInt("personid");
                    firstname    = rs.getString("firstname");
                    lastname     = rs.getString("lastname");
                    middlename   = rs.getString("middlename");
                    gender       = rs.getString("gender");
                    birthday     = rs.getDate("birthday");
                    age          = rs.getInt("age");
                    filepath     = rs.getString("picture");
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
      
     public static void main (String[] args) {
        Patient testp = new Patient();
        
        testp.patientid = 2001;
        testp.firstname = "Bob";
        testp.lastname = "Bobby";
        testp.middlename = "Bobbins";
        testp.birthday = Date.valueOf(LocalDate.of(2002, 06, 22));
        testp.filepath = "Bob.png";
        testp.gender = "M";
        testp.addRecord();
        
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
