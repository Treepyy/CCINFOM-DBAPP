import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Donor {
    private static final Scanner scanner = new Scanner(System.in);

    public static void createNewDonor(Connection connection) throws SQLException {
        // Get user input for donor details
        System.out.println("Enter Donor ID:");
        int donorId = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character
        System.out.println("Enter Mobile Number:");
        String mobileNumber = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO donor (donorid, mobileno) VALUES (?, ?)")) {

            // Set parameters for the prepared statement
            preparedStatement.setInt(1, donorId);
            preparedStatement.setString(2, mobileNumber);

            // Execute the insert statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Donor created successfully!");
            } else {
                System.out.println("Failed to create donor.");
            }
        }
    }

    public static void deleteDonor(Connection connection) throws SQLException {
        // Get user input for donor ID to delete
        System.out.println("Enter Donor ID to delete:");
        int donorId = scanner.nextInt();

        // Check if the donor exists before proceeding with the deletion
        if (!doesDonorExist(connection, donorId)) {
            System.out.println("Donor not found. Unable to delete.");
            return;
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "DELETE FROM donor WHERE donorid = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setInt(1, donorId);

            // Execute the delete statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Donor deleted successfully!");
            } else {
                System.out.println("Failed to delete donor.");
            }
        }
    }

    public static void updateDonorInformation(Connection connection) throws SQLException {
        // Get user input for donor details
        System.out.println("Enter Donor ID to update:");
        int donorId = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character

        // Check if the donor exists before proceeding with the update
        if (!doesDonorExist(connection, donorId)) {
            System.out.println("Donor not found. Unable to update information.");
            return;
        }

        // Get updated information from the user
        System.out.println("Enter new Mobile Number:");
        String newMobileNumber = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE donor SET mobileno = ? WHERE donorid = ?")) {

            // Set parameters for the prepared statement
            preparedStatement.setString(1, newMobileNumber);
            preparedStatement.setInt(2, donorId);

            // Execute the update statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Donor information updated successfully!");
            } else {
                System.out.println("Failed to update donor information.");
            }
        }
    }

    private static boolean doesDonorExist(Connection connection, int donorId) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM donor WHERE donorid = ?")) {

            preparedStatement.setInt(1, donorId);

            try (var resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public static void searchDonorById(Connection connection) throws SQLException {
        // Get user input for donor ID to search
        System.out.println("Enter Donor ID to search:");
        int donorId = scanner.nextInt();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM donor WHERE donorid = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setInt(1, donorId);

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the search results
                    System.out.println("Donor found:");
                    do {
                        int foundDonorId = resultSet.getInt("donorid");
                        String mobileNumber = resultSet.getString("mobileno");

                        // Display the data
                        System.out.println("Donor ID: " + foundDonorId);
                        System.out.println("Mobile Number: " + mobileNumber);
                        // Display other fields as needed
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No donor found with the specified Donor ID.");
                }
            }
        }
    }

    public static void viewDonorByFilter(Connection connection) throws SQLException {
        System.out.println("Enter the criteria to filter donors (e.g., mobileno):");
        String criteria = scanner.nextLine();

        // Check if the provided criteria is valid
        if (!isValidCriteria(criteria)) {
            System.out.println("Invalid criteria.");
            return;
        }

        // Get user input for the value of the specified criteria
        System.out.println("Enter the value of the criteria:");
        String value = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM donor WHERE " + criteria + " LIKE ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setString(1, "%" + value + "%");

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the filtered results
                    System.out.println("Donors matching the specified criteria:");
                    do {
                        int donorId = resultSet.getInt("donorid");
                        String mobileNumber = resultSet.getString("mobileno");

                        // Display the data
                        System.out.println("Donor ID: " + donorId);
                        System.out.println("Mobile Number: " + mobileNumber);
                        // Display other fields as needed
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No donors found with the specified criteria.");
                }
            }
        }
    }

    // Helper method to check if the provided criteria is valid
    private static boolean isValidCriteria(String criteria) {
        // Add more validation logic if needed
        return criteria.matches("[a-zA-Z_]+");
    }
}
