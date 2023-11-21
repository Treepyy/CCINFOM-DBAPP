package dbapplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Reports1 {
    
    public String getFacilityForDonation(int donationId) {
        String facilityName = null;

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345");
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT hf.facilityname " +
                             "FROM health_facility hf " +
                             "JOIN donation d ON hf.facilityid = d.facility " +
                             "WHERE d.donationid = ?")) {

            pstmt.setInt(1, donationId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                facilityName = rs.getString("facilityname");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return facilityName;
    }

    public int getDonationCountByFacilityType(String facilityType) {
        int donationQuantity = 0;

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345");
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT COUNT(d.donationid) AS donationQuantity " +
                             "FROM health_facility h " +
                             "LEFT JOIN donation d ON h.facilityid = d.facility " +
                             "WHERE h.facilitytype = ? " +
                             "GROUP BY h.facilityid, h.facilitytype")) {

            pstmt.setString(1, facilityType);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                donationQuantity = rs.getInt("donationQuantity");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return donationQuantity;
    }

    public int getDonationCountByMonth(int medicineId, int month) {
        int donationCount = 0;

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345");
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT COUNT(d.donationid) AS donationCount " +
                             "FROM medicine m " +
                             "LEFT JOIN donation d ON m.medicineid = d.medicine " +
                             "WHERE m.medicineid = ? AND MONTH(d.donationdate) = ?")) {

            pstmt.setInt(1, medicineId);
            pstmt.setInt(2, month);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                donationCount = rs.getInt("donationCount");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return donationCount;
    }

    public int getDonorDonationToFacilityCountByFacilityType(String facilityType) {
        int donationCount = 0;

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345");
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT COUNT(dn.donationid) AS donationCount " +
                             "FROM donor d " +
                             "JOIN donation dn ON d.donorid = dn.donor " +
                             "JOIN health_facility hf ON dn.facility = hf.facilityid " +
                             "WHERE hf.facilitytype = ? " +
                             "GROUP BY d.donorid, hf.facilityid, hf.facilitytype")) {

            pstmt.setString(1, facilityType);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                donationCount = rs.getInt("donationCount");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return donationCount;
    }
}