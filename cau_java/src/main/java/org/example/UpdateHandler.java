package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class UpdateHandler implements DBHandler {
    private final Scanner scanner = new Scanner(System.in);

    private final Connection db_connection;

    public UpdateHandler(Connection db_connection) {
        this.db_connection = db_connection;
    }


    @Override
    public void execute() throws SQLException {
        while(true) {

            System.out.println("+----------------------------+");
            System.out.println("+           UPDATE           +");
            System.out.println("+----------------------------+");
            System.out.println("|  check you want to update  |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. USER                    |");
            System.out.println("| 2. DEPARTMENT              |");
            System.out.println("| 0. BACK                    |");
            System.out.println("+----------------------------+");
            switch(scanner.nextInt()) {
                case 1:
                    updateUser();
                    break;
                case 2:
//                    updateDepartment();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }

    private void updateUser() {
        while (true) {
            System.out.println("+----------------------------+");
            System.out.println("+           USER             +");
            System.out.println("+----------------------------+");
            System.out.println("|  check you want to update  |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. student                 |");
            System.out.println("| 2. assistant               |");
            System.out.println("| 3. professor               |");
            System.out.println("| 0. BACK                    |");
            System.out.println("+----------------------------+");
            switch (scanner.nextInt()) {
                case 1:
                    updateStudent();
                    break;
                case 2:
//                    updateAssistant();
                    break;
                case 3:
//                    updateProfessor();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }

    private void updateStudent() {
        while (true) {
            System.out.println("+----------------------------+");
            System.out.println("+           STUDENT          +");
            System.out.println("+----------------------------+");
            System.out.println("|  check you want to update  |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. undergraduate           |");
            System.out.println("| 2. postgraduate            |");
            System.out.println("| 0. BACK                    |");
            System.out.println("+----------------------------+");

            switch (scanner.nextInt()) {
                case 1:
                    updateUndergraduate();
                    break;
                case 2:
//                    updatePostgraduate();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
    }
}

    private void updateUndergraduate() {
        System.out.print("enter undergraduate id >> ");
        int undergraduate_id = scanner.nextInt();
        System.out.print("enter new phone number >> ");
        String undergraduate_phone_number = scanner.next();
        System.out.print("enter new address >> ");
        scanner.nextLine();
        String undergraduate_address = scanner.nextLine();

        try {
            PreparedStatement pstmt = db_connection.prepareStatement("UPDATE user JOIN student ON user.user_id = student.user_id JOIN undergraduate ON student.student_id = undergraduate.student_id " +
                    "SET phone_num = ?, address = ? " +
                    "WHERE undergraduate_id = ?;");
            pstmt.setString(1, undergraduate_phone_number);
            pstmt.setString(2, undergraduate_address);
            pstmt.setInt(3, undergraduate_id);
            pstmt.executeUpdate();

            System.out.println("update success");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
