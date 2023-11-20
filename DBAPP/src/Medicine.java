import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.ResultSet;

public class Medicine {
    private static final Scanner scanner = new Scanner(System.in);

    public static void createNewMedicine(Connection connection) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO medicine (medicineid, brandname, genericname, category, medtype, amount, expiration, isdonated) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

            System.out.println("Enter Medicine ID:");
            int medicineId = scanner.nextInt();
            scanner.nextLine();
            System.out.println("Enter Brand Name:");
            String brandName = scanner.nextLine();
            System.out.println("Enter Generic Name:");
            String genericName = scanner.nextLine();
            System.out.println("Enter Category:");
            String category = scanner.nextLine();
            System.out.println("Enter Medicine Type:");
            String medType = scanner.nextLine();
            System.out.println("Enter Amount:");
            double amount = scanner.nextDouble();
            System.out.println("Enter Expiration Date (YYYY-MM-DD):");
            String expiration = scanner.next();
            System.out.println("Is Donated? (true/false):");
            boolean isDonated = scanner.nextBoolean();

            preparedStatement.setInt(1, medicineId);
            preparedStatement.setString(2, brandName);
            preparedStatement.setString(3, genericName);
            preparedStatement.setString(4, category);
            preparedStatement.setString(5, medType);
            preparedStatement.setDouble(6, amount);
            preparedStatement.setString(7, expiration);
            preparedStatement.setBoolean(8, isDonated);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("New medicine added successfully!");
            } else {
                System.out.println("Failed to add a new medicine.");
            }
        }
    }

    public static void updateMedicine(Connection connection) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE medicine SET brandname = ?, genericname = ?, category = ?, medtype = ?, amount = ?, expiration = ?, isdonated = ? WHERE medicineid = ?")) {

            System.out.println("Enter Medicine ID to update:");
            int medicineId = scanner.nextInt();
            scanner.nextLine();

            System.out.println("Enter Brand Name:");
            String brandName = scanner.nextLine();
            System.out.println("Enter Generic Name:");
            String genericName = scanner.nextLine();
            System.out.println("Enter Category:");
            String category = scanner.nextLine();
            System.out.println("Enter Medicine Type:");
            String medType = scanner.nextLine();
            System.out.println("Enter Amount:");
            double amount = scanner.nextDouble();
            System.out.println("Enter Expiration Date (YYYY-MM-DD):");
            String expiration = scanner.next();
            System.out.println("Is Donated? (true/false):");
            boolean isDonated = scanner.nextBoolean();

            preparedStatement.setString(1, brandName);
            preparedStatement.setString(2, genericName);
            preparedStatement.setString(3, category);
            preparedStatement.setString(4, medType);
            preparedStatement.setDouble(5, amount);
            preparedStatement.setString(6, expiration);
            preparedStatement.setBoolean(7, isDonated);
            preparedStatement.setInt(8, medicineId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Medicine updated successfully!");
            } else {
                System.out.println("Failed to update medicine. Medicine ID not found.");
            }
        }
    }

    public static void deleteMedicine(Connection connection) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "DELETE FROM medicine WHERE medicineid = ?")) {

            System.out.println("Enter Medicine ID to delete:");
            int medicineId = scanner.nextInt();

            preparedStatement.setInt(1, medicineId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Medicine deleted successfully!");
            } else {
                System.out.println("Failed to delete medicine. Medicine ID not found.");
            }
        }
    }

    public static void searchMedicineById(Connection connection) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM medicine WHERE medicineid = ?")) {

            System.out.println("Enter Medicine ID to search:");
            int medicineId = scanner.nextInt();

            preparedStatement.setInt(1, medicineId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    System.out.println("Search results:");
                    do {
                        int foundMedicineId = resultSet.getInt("medicineid");

                        System.out.println("Medicine ID: " + foundMedicineId);
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No medicine found with the specified Medicine ID.");
                }
            }
        }
    }

    public static void viewMedicineByFilter(Connection connection) throws SQLException {
        System.out.println("Enter the field you want to view (e.g., brandname, genericname, category):");
        String field = scanner.nextLine();

        // Check if the provided field is valid to prevent SQL injection
        if (!isValidField(field)) {
            System.out.println("Invalid field name.");
            return;
        }

        // Get user input for the value of the specified field
        System.out.println("Enter the value of the field:");
        String value = scanner.nextLine();

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT medicineid, " + field + " FROM medicine WHERE " + field + " = ?")) {

            // Set parameter for the prepared statement
            preparedStatement.setString(1, value);

            // Execute the select statement
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Display the filtered results
                    System.out.println("Medicine ID and " + field + " for the specified value:");
                    do {
                        int medicineId = resultSet.getInt("medicineid");
                        String fieldValue = resultSet.getString(field);

                        // Display the data
                        System.out.println("Medicine ID: " + medicineId);
                        System.out.println(field + ": " + fieldValue);
                        System.out.println();
                    } while (resultSet.next());
                } else {
                    System.out.println("No medicines found with the specified value in the specified field.");
                }
            }
        }
    }

    private static boolean isValidField(String field) {
        return field.matches("[a-zA-Z_]+");
    }
}
