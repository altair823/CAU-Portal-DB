package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class DeleteHandler implements DBHandler {

    private final Scanner scanner = new Scanner(System.in);

    private final Connection db_connection;

    public DeleteHandler(Connection db_connection) {
        this.db_connection = db_connection;
    }

    public void execute() {
        while(true) {

            System.out.println("+----------------------------+");
            System.out.println("+           DELETE           +");
            System.out.println("+----------------------------+");
            System.out.println("|  check you want to delete  |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. USER                    |");
            System.out.println("| 2. DEPARTMENT              |");
            System.out.println("| 0. BACK                    |");
            System.out.println("+----------------------------+");
            switch(scanner.nextInt()) {
                case 1:
                    deleteUser();
                    break;
                case 2:
                    deleteDepartment();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }

    private void deleteDepartment() {
        System.out.print("enter department name >> ");
        String department_name = scanner.next();

        try {
            PreparedStatement pstmt = db_connection.prepareStatement("UPDATE department SET active = FALSE WHERE name = ?;");
            pstmt.setString(1, department_name);
            pstmt.executeUpdate();
            System.out.println("delete department success");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteUser() {
        while(true) {
            System.out.println("+----------------------------+");
            System.out.println("+        DELETE(user)        +");
            System.out.println("+----------------------------+");
            System.out.println("|  check you want to search  |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. student                 |");
            System.out.println("| 2. assistant               |");
            System.out.println("| 3. professor               |");
            System.out.println("| 4. staff                   |");
            System.out.println("| 0. BACK                    |");
            System.out.println("+----------------------------+");
            switch (scanner.nextInt()) {
                case 1:
                    deleteStudent();
                    break;
                case 2:
                    //                searchAssistant();
                    break;
                case 3:
                    //                searchProfessor();
                    break;
                case 4:
                    //                searchStaff();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
        }
    }

    private void deleteStudent() {
        System.out.println("+----------------------------+");
        System.out.println("+           STUDENT          +");
        System.out.println("+----------------------------+");
        System.out.println("|  check you want to delete  |");
        System.out.println("+----------------------------+");
        System.out.println("| 1. undergraduate           |");
        System.out.println("| 2. postgraduate            |");
        System.out.println("| 0. BACK                    |");
        System.out.println("+----------------------------+");

        switch (scanner.nextInt()) {
            case 1:
                deleteUndergraduate();
                break;
            case 2:
//                deletePostgraduate();
                break;
            case 0:
                return;
            default:
                System.out.println("This is a wrong command.");
        }
    }

    private void deleteUndergraduate() {
        System.out.print("enter undergraduate id >> ");
        String undergraduate_id = scanner.next();

        try {
            PreparedStatement pstmt = db_connection.prepareStatement("UPDATE user " +
                    "JOIN student ON user.user_id = student.user_id " +
                    "JOIN undergraduate ON student.student_id = undergraduate.student_id " +
                    "SET active = FALSE " +
                    "WHERE undergraduate_id = ?;");
            pstmt.setString(1, undergraduate_id);
            pstmt.executeUpdate();
            System.out.println("delete undergraduate success");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
