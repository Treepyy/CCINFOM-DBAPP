package dbapplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class Medicine {

    public int medicineid;
    public String brandname, genericname, category, medtype, expiration;
    public double amount;
    public boolean isdonated;

    private int generateMedicineID() {
        int newMedicineId = 1000;

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {

            String query = "SELECT MAX(medicineid) AS maxId FROM medicine";
            try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        int maxMedicineId = resultSet.getInt("maxId");

                        newMedicineId = maxMedicineId + 1;
                    }
                }
            }
            return newMedicineId;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    private void addRecord(Medicine newMedicine) {
        newMedicine.medicineid = generateMedicineID();

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO medicine (medicineid, brandname, genericname, category, medtype, amount, expiration, isdonated) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

            pstmt.setInt(1, newMedicine.medicineid);
            pstmt.setString(2, newMedicine.brandname);
            pstmt.setString(3, newMedicine.genericname);
            pstmt.setString(4, newMedicine.category);
            pstmt.setString(5, newMedicine.medtype);
            pstmt.setDouble(6, newMedicine.amount);
            pstmt.setString(7, newMedicine.expiration);
            pstmt.setBoolean(8, newMedicine.isdonated);

            pstmt.executeUpdate();
            System.out.println("New medicine added successfully!");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private void modRecord(Medicine updatedMedicine) {
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
             PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE medicine SET brandname = ?, genericname = ?, category = ?, medtype = ?, amount = ?, expiration = ?, isdonated = ? WHERE medicineid = ?")) {

            pstmt.setString(1, updatedMedicine.brandname);
            pstmt.setString(2, updatedMedicine.genericname);
            pstmt.setString(3, updatedMedicine.category);
            pstmt.setString(4, updatedMedicine.medtype);
            pstmt.setDouble(5, updatedMedicine.amount);
            pstmt.setString(6, updatedMedicine.expiration);
            pstmt.setBoolean(7, updatedMedicine.isdonated);
            pstmt.setInt(8, updatedMedicine.medicineid);

            pstmt.executeUpdate();
            System.out.println("Medicine updated successfully!");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private void delRecord(int medicineId) {
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
             PreparedStatement pstmt = conn.prepareStatement(
                     "DELETE FROM medicine WHERE medicineid = ?")) {

            pstmt.setInt(1, medicineId);
            pstmt.executeUpdate();
            System.out.println("Medicine deleted successfully!");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void viewRecord() {
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT medicineid, brandname, genericname, category, medtype, amount, expiration, isdonated " +
                             "FROM medicine " +
                             "WHERE medicineid = ?")) {

            pstmt.setInt(1, medicineid);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                medicineid = rs.getInt("medicineid");
                brandname = rs.getString("brandname");
                genericname = rs.getString("genericname");
                category = rs.getString("category");
                medtype = rs.getString("medtype");
                amount = rs.getDouble("amount");
                expiration = rs.getString("expiration");
                isdonated = rs.getBoolean("isdonated");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public class Main {
        public static void main(String[] args) {
            Medicine testMedicine = new Medicine();

            testMedicine.brandname = "Panadol";
            testMedicine.genericname = "Paracetamol";
            testMedicine.category = "Pain Relief";
            testMedicine.medtype = "Tablet";
            testMedicine.amount = 10.99;
            testMedicine.expiration = "2023-12-31";
            testMedicine.isdonated = false;

            testMedicine.addRecord(testMedicine);

            testMedicine.delRecord(testMedicine.medicineid);

            testMedicine.modRecord(testMedicine);
        }
    }
}