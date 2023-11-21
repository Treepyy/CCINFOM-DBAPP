package dbapplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Reports2 {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678";

    public void getMedicationHistoryForPatient(int patientId, int medicineId) {
        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT mt.patientid, mt.administer, mt.amountgiven " +
                             "FROM medication_tracking mt " +
                             "WHERE mt.patientid = ? AND mt.medicineid = ?")) {

            pstmt.setInt(1, patientId);
            pstmt.setInt(2, medicineId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int resultPatientId = rs.getInt("patientid");
                String administerDate = rs.getString("administer");
                int amountGiven = rs.getInt("amountgiven");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    public void getAverageProvisionByMedicineType(int month) {
        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT m.medtype, MONTH(mt.administer) AS administerMonth, AVG(mt.amountgiven) AS avgProvision " +
                             "FROM medication_tracking mt " +
                             "JOIN medicine m ON mt.medicineid = m.medicineid " +
                             "WHERE MONTH(mt.administer) = ? " +
                             "GROUP BY m.medtype, administerMonth")) {

            pstmt.setInt(1, month);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String medType = rs.getString("medtype");
                int administerMonth = rs.getInt("administerMonth");
                double avgProvision = rs.getDouble("avgProvision");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    public String getHighestProvidedMedicineType(int month) {
        String highestMedicineType = null;

        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT m.medtype, MONTH(mt.administer) AS administerMonth, SUM(mt.amountgiven) AS totalProvision " +
                             "FROM medication_tracking mt " +
                             "JOIN medicine m ON mt.medicineid = m.medicineid " +
                             "WHERE MONTH(mt.administer) = ? " +
                             "GROUP BY m.medtype, administerMonth " +
                             "ORDER BY totalProvision DESC " +
                             "LIMIT 1")) {

            pstmt.setInt(1, month);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                highestMedicineType = rs.getString("medtype");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return highestMedicineType;
    }
    
    public void getTotalMedicineQuantityByYear(int year) {
        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT m.medtype, YEAR(mt.administer) AS administerYear, SUM(mt.amountgiven) AS totalQuantity " +
                             "FROM medication_tracking mt " +
                             "JOIN medicine m ON mt.medicineid = m.medicineid " +
                             "WHERE YEAR(mt.administer) = ? " +
                             "GROUP BY m.medtype, administerYear")) {

            pstmt.setInt(1, year);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String medType = rs.getString("medtype");
                int administerYear = rs.getInt("administerYear");
                int totalQuantity = rs.getInt("totalQuantity");

            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    public void getPatientWithMostMedicineByYear() {
        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT p.patientid, YEAR(mt.administer) AS administerYear, SUM(mt.amountgiven) AS totalQuantity " +
                             "FROM patient p " +
                             "JOIN medication_tracking mt ON p.patientid = mt.patientid " +
                             "GROUP BY p.patientid, administerYear " +
                             "ORDER BY totalQuantity DESC")) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int patientId = rs.getInt("patientid");
                int administerYear = rs.getInt("administerYear");
                int totalQuantity = rs.getInt("totalQuantity");

            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    public void getPatientWithMostQuantityByYear() {
        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT t.patientid, t.administerYear, t.totalQuantity " +
                             "FROM ( " +
                             "    SELECT " +
                             "        mt.patientid, " +
                             "        YEAR(mt.administer) AS administerYear, " +
                             "        SUM(mt.amountgiven) AS totalQuantity, " +
                             "        RANK() OVER (PARTITION BY YEAR(mt.administer) ORDER BY SUM(mt.amountgiven) DESC) AS quantityRank " +
                             "    FROM " +
                             "        medication_tracking mt " +
                             "    GROUP BY " +
                             "        mt.patientid, administerYear " +
                             ") AS t " +
                             "WHERE t.quantityRank = 1")) {

            ResultSet rs = pstmt.executeQuery();

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}