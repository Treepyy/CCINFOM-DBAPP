import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Health_Facility {
    private static final Scanner scanner = new Scanner(System.in);

    public static void createNewHealthFacility(Connection connection) throws SQLException {
        // Get user input for health facility details
        System.out.println("Enter Facility ID:");
        int facilityId = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character
        System.out.println("Enter Facility Name:");
        String facilityName = scanner.nextLine();
        System.out.println("Enter Max Capacity:");
        int maxCapacity = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character
        System.out.println("Enter Facility Type (C, H, HC):");
        String facilityType = scanner.nextLine().toUpperCase();
        System.out.println("Enter Street No:");
        String streetNo = scanner.nextLine();
        System.out.println("Enter Street Name:");
        String streetName = scanner.nextLine();
        System.out.println("Enter Barangay:");
        String barangay = scanner.nextLine();
        System.out.println("Enter City:");
        String city = scanner.nextLine();
        System.out.println("Enter Province:");
        String province = scanner.nextLine();
        System.out.println("Enter Region:");
        String region = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO health_facility (facilityid, facilityname, maxcapacity, facilitytype, " +
                        "streetno, streetname, baranggay, city, province, region) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {

            // Set parameters for the prepared statement
            preparedStatement.setInt(1, facilityId);
            preparedStatement.setString(2, facilityName);
            preparedStatement.setInt(3, maxCapacity);
            preparedStatement.setString(4, facilityType);
            preparedStatement.setString(5, streetNo);
            preparedStatement.setString(6, streetName);
            preparedStatement.setString(7, barangay);
            preparedStatement.setString(8, city);
            preparedStatement.setString(9, province);
            preparedStatement.setString(10, region);

            // Execute the insert statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Health facility created successfully!");
            } else {
                System.out.println("Failed to create health facility.");
            }
        }
    }

    public static void updateHealthFacility(Connection connection) throws SQLException {
        // Get user input for facility ID to update
        System.out.println("Enter Facility ID to update:");
        int facilityId = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character

        // Check if the health facility exists before proceeding with the update
        if (!doesHealthFacilityExist(connection, facilityId)) {
            System.out.println("Health facility not found. Unable to update information.");
            return;
        }

        // Get updated information from the user
        System.out.println("Enter new Facility Name:");
        String newFacilityName = scanner.nextLine();
        System.out.println("Enter new Max Capacity:");
        int newMaxCapacity = scanner.nextInt();
        scanner.nextLine(); // Consume the newline character
        System.out.println("Enter new Facility Type (C, H, HC):");
        String newFacilityType = scanner.nextLine().toUpperCase();
        System.out.println("Enter new Street No:");
        String newStreetNo = scanner.nextLine();
        System.out.println("Enter new Street Name:");
        String newStreetName = scanner.nextLine();
        System.out.println("Enter new Barangay:");
        String newBarangay = scanner.nextLine();
        System.out.println("Enter new City:");
        String newCity = scanner.nextLine();
        System.out.println("Enter new Province:");
        String newProvince = scanner.nextLine();
        System.out.println("Enter new Region:");
        String newRegion = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE health_facility SET facilityname = ?, maxcapacity = ?, facilitytype = ?, " +
                        "streetno = ?, streetname = ?, baranggay = ?, city = ?, province = ?, region = ? " +
                        "WHERE facilityid = ?")) {

            // Set parameters for the prepared statement
            preparedStatement.setString(1, newFacilityName);
            preparedStatement.setInt(2, newMaxCapacity);
            preparedStatement.setString(3, newFacilityType);
            preparedStatement.setString(4, newStreetNo);
            preparedStatement.setString(5, newStreetName);
            preparedStatement.setString(6, newBarangay);
            preparedStatement.setString(7, newCity);
            preparedStatement.setString(8, newProvince);
            preparedStatement.setString(9, newRegion);
            preparedStatement.setInt(10, facilityId);

            // Execute the update statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Health facility information updated successfully!");
            } else {
                System.out.println("Failed to update health facility information.");
            }
        }
    }

    public static void deleteHealthFacilityById(Connection connection) throws SQLException {
        // Get user input for facility ID to delete
        System.out.println("Enter Facility ID to delete:");
        int facilityId = scanner.nextInt();

        // Check if the health facility exists before proceeding with the deletion
        if (!doesHealthFacilityExist(connection, facilityId)) {
            System.out.println("Health facility not found. Unable to delete.");
            return;
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "DELETE FROM health_facility WHERE facilityid = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setInt(1, facilityId);

            // Execute the delete statement
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Health facility deleted successfully!");
            } else {
                System.out.println("Failed to delete health facility.");
            }
        }
    }

    public static void searchHealthFacilityById(Connection connection) throws SQLException {
        // Get user input for facility ID to search
        System.out.println("Enter Facility ID to search:");
        int facilityId = scanner.nextInt();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM health_facility WHERE facilityid = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setInt(1, facilityId);

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the search results
                    System.out.println("Health facility found:");
                    do {
                        int foundFacilityId = resultSet.getInt("facilityid");
                        String facilityName = resultSet.getString("facilityname");
                        int maxCapacity = resultSet.getInt("maxcapacity");
                        String facilityType = resultSet.getString("facilitytype");
                        String streetNo = resultSet.getString("streetno");
                        String streetName = resultSet.getString("streetname");
                        String barangay = resultSet.getString("baranggay");
                        String city = resultSet.getString("city");
                        String province = resultSet.getString("province");
                        String region = resultSet.getString("region");

                        // Display the data
                        System.out.println("Facility ID: " + foundFacilityId);
                        System.out.println("Facility Name: " + facilityName);
                        System.out.println("Max Capacity: " + maxCapacity);
                        System.out.println("Facility Type: " + facilityType);
                        System.out.println("Street No: " + streetNo);
                        System.out.println("Street Name: " + streetName);
                        System.out.println("Barangay: " + barangay);
                        System.out.println("City: " + city);
                        System.out.println("Province: " + province);
                        System.out.println("Region: " + region);
                        // Display other fields as needed
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No health facility found with the specified Facility ID.");
                }
            }
        }
    }

    public static void viewHealthFacilitiesByFilter(Connection connection) throws SQLException {
        // Get user input for the filter criteria
        System.out.println("Enter filter criteria (e.g., facilityname):");
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
                "SELECT * FROM health_facility WHERE " + filterCriteria + " LIKE ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setString(1, "%" + filterValue + "%");

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the filtered results
                    System.out.println("Health facilities matching the specified criteria:");
                    do {
                        int facilityId = resultSet.getInt("facilityid");
                        String facilityName = resultSet.getString("facilityname");
                        int maxCapacity = resultSet.getInt("maxcapacity");
                        String facilityType = resultSet.getString("facilitytype");
                        String streetNo = resultSet.getString("streetno");
                        String streetName = resultSet.getString("streetname");
                        String barangay = resultSet.getString("baranggay");
                        String city = resultSet.getString("city");
                        String province = resultSet.getString("province");
                        String region = resultSet.getString("region");

                        // Display the data
                        System.out.println("Facility ID: " + facilityId);
                        System.out.println("Facility Name: " + facilityName);
                        System.out.println("Max Capacity: " + maxCapacity);
                        System.out.println("Facility Type: " + facilityType);
                        System.out.println("Street No: " + streetNo);
                        System.out.println("Street Name: " + streetName);
                        System.out.println("Barangay: " + barangay);
                        System.out.println("City: " + city);
                        System.out.println("Province: " + province);
                        System.out.println("Region: " + region);
                        // Display other fields as needed
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No health facilities found with the specified criteria.");
                }
            }
        }
    }

    // Helper method to check if the provided criteria is valid
    private static boolean isValidCriteria(String criteria) {
        // Add more validation logic if needed
        return criteria.matches("[a-zA-Z_]+");
    }

    private static boolean doesHealthFacilityExist(Connection connection, int facilityId) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM health_facility WHERE facilityid = ?")) {

            preparedStatement.setInt(1, facilityId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        }
    }
}
