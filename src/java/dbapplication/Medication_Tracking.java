package dbapplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Date;

public class Medication_Tracking {
    
    public Date administer;
    public int amtgiven;

    public String assignMedicineToAdmittedPatient(int medicineId, int patientId) {
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {

            String checkAdmissionQuery = "SELECT * FROM patient WHERE patientid = ? AND patientstatus = 'A'";
            try (PreparedStatement checkAdmissionStmt = conn.prepareStatement(checkAdmissionQuery)) {
                checkAdmissionStmt.setInt(1, patientId);

                try (ResultSet admissionResultSet = checkAdmissionStmt.executeQuery()) {
                    if (admissionResultSet.next()) {

                        String checkFacilityQuery = "SELECT * FROM medicine WHERE medicineid = ? AND facilityid = ?";
                        try (PreparedStatement checkFacilityStmt = conn.prepareStatement(checkFacilityQuery)) {
                            checkFacilityStmt.setInt(1, medicineId);
                            checkFacilityStmt.setInt(2, admissionResultSet.getInt("facilityid"));

                            try (ResultSet facilityResultSet = checkFacilityStmt.executeQuery()) {
                                if (facilityResultSet.next()) {
                                    assignMedicine(conn, medicineId, patientId, admissionResultSet.getInt("facilityid"));
                                } else {
                                    System.out.println("Error: Patient and medicine have different facilities.");
                                }
                            }
                        }

                    } else {
                        System.out.println("Error: Patient is not admitted.");
                    }
                }
            }
            
            return "1";
            
        } catch (SQLException e) {
            return "Error: " + e.getMessage();
        }
    }

    private void assignMedicine(Connection conn, int medicineId, int patientId, int facilityId) {
        try {
            String assignMedicineQuery = "INSERT INTO medication_tracking (patientid, facilityid, medicineid, administer, amountgiven) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement assignMedicineStmt = conn.prepareStatement(assignMedicineQuery)) {
                assignMedicineStmt.setInt(1, patientId);
                assignMedicineStmt.setInt(2, facilityId);
                assignMedicineStmt.setInt(3, medicineId);
                
                administer = new Date(System.currentTimeMillis());
                assignMedicineStmt.setDate(4, administer);
                assignMedicineStmt.setInt(5, amtgiven);

                assignMedicineStmt.executeUpdate();
                System.out.println("Medicine assigned to the patient successfully!");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void modMedicationTracking(int patientId, int medicineId, Date newAdministerDate, int newAmountGiven, int newFacilityId) {
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {

            // Check if patient and medicine have the same facility before the update
            String checkFacilityQuery = "SELECT * FROM medication_tracking mt " +
                    "JOIN patient p ON mt.patientid = p.patientid " +
                    "JOIN medicine m ON mt.medicineid = m.medicineid " +
                    "WHERE mt.patientid = ? AND mt.medicineid = ? AND p.facilityid = ? AND m.facilityid = ?";
            try (PreparedStatement checkFacilityStmt = conn.prepareStatement(checkFacilityQuery)) {
                checkFacilityStmt.setInt(1, patientId);
                checkFacilityStmt.setInt(2, medicineId);
                checkFacilityStmt.setInt(3, newFacilityId);
                checkFacilityStmt.setInt(4, newFacilityId);

                try (ResultSet facilityResultSet = checkFacilityStmt.executeQuery()) {
                    if (facilityResultSet.next()) {
                        
                        String modMedicationQuery = "UPDATE medication_tracking SET administer = ?, amountgiven = ?, facilityid = ? " +
                                "WHERE patientid = ? AND medicineid = ?";
                        try (PreparedStatement modMedicationStmt = conn.prepareStatement(modMedicationQuery)) {
                            modMedicationStmt.setDate(1, newAdministerDate);
                            modMedicationStmt.setInt(2, newAmountGiven);
                            modMedicationStmt.setInt(3, newFacilityId);
                            modMedicationStmt.setInt(4, patientId);
                            modMedicationStmt.setInt(5, medicineId);

                            int rowsUpdated = modMedicationStmt.executeUpdate();
                            if (rowsUpdated > 0) {
                                System.out.println("Medication tracking updated successfully!");
                            } else {
                                System.out.println("Error: Update failed.");
                            }
                        }

                    } else {
                        System.out.println("Error: Patient and medicine have different facilities. Update canceled.");
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void updatePatientStatus(int patientId, String newStatus) {
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbapplication?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {

            // Update patient status
            String updateStatusQuery = "UPDATE patient SET patientstatus = ? WHERE patientid = ?";
            try (PreparedStatement updateStatusStmt = conn.prepareStatement(updateStatusQuery)) {
                updateStatusStmt.setString(1, newStatus);
                updateStatusStmt.setInt(2, patientId);

                int rowsUpdated = updateStatusStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    System.out.println("Patient status updated successfully!");
                } else {
                    System.out.println("Error: Update failed or patient not found.");
                }
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        Medication_Tracking medicationTracking = new Medication_Tracking();
        
        medicationTracking.amtgiven = 3;
        medicationTracking.administer = new Date(System.currentTimeMillis());
        medicationTracking.assignMedicineToAdmittedPatient(301, 1008);
        
        /*
        int medicineId = 101;
        int patientId = 1001;
        Date newAdministerDate = new Date(System.currentTimeMillis());
        int newAmountGiven = 3;
        int newFacilityId = 2001;
        String newStatus = "D";

        medicationTracking.assignMedicineToAdmittedPatient(medicineId, patientId);
        medicationTracking.modMedicationTracking(patientId, medicineId, newAdministerDate, newAmountGiven, newFacilityId);
        medicationTracking.updatePatientStatus(patientId, newStatus);*/
    }
}