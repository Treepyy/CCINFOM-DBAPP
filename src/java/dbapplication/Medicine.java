package dbapplication;
import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
public class Medicine {
    
    public Medicine(){}
    
    public int loadProducts(){ 
        return 0; 
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
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO orderdetails VALUES (?,?,?,?)");
            // 5. Supply the statement with values
            pstmt.setInt    (1, ordernumber );
            pstmt.setInt    (2, pcode);
            pstmt.setInt    (3, qty);
            pstmt.setInt    (4, price);

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
    
}
