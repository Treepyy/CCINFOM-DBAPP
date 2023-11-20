public class HealthFacility {
        public int facilityid;
        public String name;
        public int maxcapacity;
        public char facilitytype;
        public int zipcode;
        public String streetno;
        public String streetname;
        public String barangay;
        public String city;
        public String province;
        public String region;

        public HealthFacility() {

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

                // 5. Supply the statement with values
                pstmt.setInt    (1, facilityid);
                pstmt.setString (2, name);
                pstmt.setInt    (3, maxcapacity);
                pstmt.setChar   (4, facilitytype);
                pstmt.setInt    (5, zipcode);
                pstmt.setString (6, streetno);
                pstmt.setString (7, streetname);
                pstmt.setString (8, barangay);
                pstmt.setString (9, city);
                pstmt.setString (10, province);
                pstmt.setString (11, region);

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

        public int modRecord () {           // Method modify a Record
            try {
                // 1. Instantiate a connection variable
                Connection conn;     
                // 2. Connect to your DB
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                // 3. Indicate a notice of successful connection
                System.out.println("Connection Successful");
                // 4. Prepare our INSERT Statement
                PreparedStatement pstmt = conn.prepareStatement("UPDATE health_facility   " +
                                                                "SET    name          = ?," +
                                                                "       maxcapacity   = ?," +
                                                                "       facilitytype  = ?," +
                                                                "       zipcode       = ?," +
                                                                "       streetno      = ?," +
                                                                "       streetname    = ?," +
                                                                "       barangay      = ?," +
                                                                "       city          = ?," +
                                                                "       province      = ?," +
                                                                "       region        = ?"  +
                                                                "WHERE  personid      = ? "
                                                                );
                // 5. Supply the statement with values
                pstmt.setString (1, name);
                pstmt.setInt    (2, maxcapacity);
                pstmt.setChar   (3, facilitytype);
                pstmt.setInt    (4, zipcode);
                pstmt.setString (5, streetno);
                pstmt.setString (6, streetname);
                pstmt.setString (7, barangay);
                pstmt.setString (8, city);
                pstmt.setString (9, province);
                pstmt.setString (10, region);
                pstmt.setInt    (11, facilityid);

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
                pstmt.setInt    (1, facilityid);

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
                pstmt.setInt    (1, facilityidid);

                // 6. Execute the SQL Statement
                ResultSet rs = pstmt.executeQuery();   

                // 7. Get the results
                while (rs.next()) {
                    facilityid      = rs.getInt("facilityid");
                    name            = rs.getString("name");
                    maxcapacity     = rs.getInt("maxcapacity");
                    facilitytype    = rs.getChar("facilitytype");
                    zipcode         = rs.getInt("zipcode");
                    streetno        = rs.getString("streetno");
                    streetname      = rs.getString("streetname");
                    barangay        = rs.getString("barangay");
                    city            = rs.getString("city");
                    province        = rs.getString("province");
                    region          = rs.getString("region");
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
