import java.sql.*;

public class Main {
    public static void main(String[] args) {
        try {
            Connection connection = DatabaseConnection.getConnection();
            Medicine.createNewMedicine(connection);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}