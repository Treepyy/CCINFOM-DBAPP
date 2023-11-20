import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Patient {
    private static final Scanner scanner = new Scanner(System.in);

    public static void createNewPatient(Connection connection) throws SQLException {
        // Get user input for patient details
        System.out.println("Enter Patient ID:");
        int patientId = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character
        System.out.println("Enter Admission Date (YYYY-MM-DD):");
        String admissionDate = scanner.nextLine();
        System.out.println("Enter Discharge Date (YYYY-MM-DD, or leave blank if still admitted):");
        String dischargeDate = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO patient (patientid, admission, discharge) VALUES (?, ?, ?)")) {

            // Set parameters for the prepared statement
            preparedStatement.setInt(1, patientId);
            preparedStatement.setString(2, admissionDate);
            preparedStatement.setString(3, dischargeDate);

            // Execute the insert statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Patient created successfully!");
            } else {
                System.out.println("Failed to create patient.");
            }
        }
    }

    public static void deletePatient(Connection connection) throws SQLException {
        // Get user input for patient ID to delete
        System.out.println("Enter Patient ID to delete:");
        int patientId = scanner.nextInt();

        // Check if the patient exists before proceeding with the deletion
        if (!doesPatientExist(connection, patientId)) {
            System.out.println("Patient not found. Unable to delete.");
            return;
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "DELETE FROM patient WHERE patientid = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setInt(1, patientId);

            // Execute the delete statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Patient deleted successfully!");
            } else {
                System.out.println("Failed to delete patient.");
            }
        }
    }

    public static void updatePatientInformation(Connection connection) throws SQLException {
        // Get user input for patient ID to update
        System.out.println("Enter Patient ID to update:");
        int patientId = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character

        // Check if the patient exists before proceeding with the update
        if (!doesPatientExist(connection, patientId)) {
            System.out.println("Patient not found. Unable to update information.");
            return;
        }

        // Get updated information from the user
        System.out.println("Enter new Admission Date (YYYY-MM-DD):");
        String newAdmissionDate = scanner.nextLine();
        System.out.println("Enter new Discharge Date (YYYY-MM-DD, or leave blank if still admitted):");
        String newDischargeDate = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE patient SET admission = ?, discharge = ? WHERE patientid = ?")) {

            // Set parameters for the prepared statement
            preparedStatement.setString(1, newAdmissionDate);
            preparedStatement.setString(2, newDischargeDate);
            preparedStatement.setInt(3, patientId);

            // Execute the update statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Patient information updated successfully!");
            } else {
                System.out.println("Failed to update patient information.");
            }
        }
    }

    private static boolean doesPatientExist(Connection connection, int patientId) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM patient WHERE patientid = ?")) {

            preparedStatement.setInt(1, patientId);

            try (var resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public static void searchPatientById(Connection connection) throws SQLException {
        // Get user input for patient ID to search
        System.out.println("Enter Patient ID to search:");
        int patientId = scanner.nextInt();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM patient WHERE patientid = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setInt(1, patientId);

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the search results
                    System.out.println("Patient found:");
                    do {
                        int foundPatientId = resultSet.getInt("patientid");
                        String admissionDate = resultSet.getString("admission");
                        String dischargeDate = resultSet.getString("discharge");

                        // Display the data
                        System.out.println("Patient ID: " + foundPatientId);
                        System.out.println("Admission Date: " + admissionDate);
                        System.out.println("Discharge Date: " + dischargeDate);
                        // Display other fields as needed
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No patient found with the specified Patient ID.");
                }
            }
        }
    }

    public static void viewPatientsByFilter(Connection connection) throws SQLException {
        // Get user input for the filter criteria
        System.out.println("Enter filter criteria (e.g., admission):");
        String filterCriteria = scanner.nextLine();

        // Check if the provided criteria is valid
        if (!isValidCriteria(filterCriteria)) {
            System.out.println("Invalid criteria.");
            return;
        }

        // Get user input for the filter value
        System.out.println("Enter filter value:");
        String filterValue = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM patient WHERE " + filterCriteria + " LIKE ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setString(1, "%" + filterValue + "%");

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the filtered results
                    System.out.println("Patients matching the specified criteria:");
                    do {
                        int patientId = resultSet.getInt("patientid");
                        String admissionDate = resultSet.getString("admission");
                        String dischargeDate = resultSet.getString("discharge");

                        // Display the data
                        System.out.println("Patient ID: " + patientId);
                        System.out.println("Admission Date: " + admissionDate);
                        System.out.println("Discharge Date: " + dischargeDate);
                        // Display other fields as needed
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No patients found with the specified criteria.");
                }
            }
        }
    }

    private static boolean isValidCriteria(String criteria) {
        // Add more validation logic if needed
        return criteria.matches("[a-zA-Z_]+");
    }
}
