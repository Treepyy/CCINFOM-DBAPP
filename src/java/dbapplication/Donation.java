import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Date;

public class Donation {

    public int donationid;
    public int donor;
    public int facility;
    public int medicine;
    public Date donationdate;

    private int generateDonationID() {
        int newDonationId = 10000;

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {

            String query = "SELECT MAX(donationid) AS maxId FROM donation";
            try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        int maxDonationId = resultSet.getInt("maxId");
                        newDonationId = maxDonationId + 1;
                    }
                }
            }
            return newDonationId;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    public void createDonation(int donorId, int facilityId, int medicineId) {
        donationid = generateDonationID();
        donor = donorId;
        facility = facilityId;
        medicine = medicineId;
        donationdate = new Date(System.currentTimeMillis());

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {

            try (PreparedStatement pstmtDonation = conn.prepareStatement(
                    "INSERT INTO donation (donationid, donor, facility, medicine, donationdate) VALUES (?, ?, ?, ?, ?)")) {

                pstmtDonation.setInt(1, donationid);
                pstmtDonation.setInt(2, donor);
                pstmtDonation.setInt(3, facility);
                pstmtDonation.setInt(4, medicine);
                pstmtDonation.setDate(5, donationdate);

                pstmtDonation.executeUpdate();
                System.out.println("Donation created successfully!");
            }

            try (PreparedStatement pstmtDonatedMedicine = conn.prepareStatement(
                    "INSERT INTO donated_medicine (donationid, medicineid, facilityid) VALUES (?, ?, ?)")) {

                pstmtDonatedMedicine.setInt(1, donationid);
                pstmtDonatedMedicine.setInt(2, medicine);
                pstmtDonatedMedicine.setInt(3, facility);

                pstmtDonatedMedicine.executeUpdate();
                System.out.println("Record added to donated_medicine successfully!");
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        Donation testDonation = new Donation();

        int donorId = 1234;
        int facilityId = 5678;
        int medicineId = 789;

        testDonation.createDonation(donorId, facilityId, medicineId);
    }
}