package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class CreateHandler implements DBHandler {

    private final Connection db_connection;
    private final Scanner scanner = new Scanner(System.in);

    public CreateHandler(Connection db_connection) {
        this.db_connection = db_connection;
    }

    public void execute() throws SQLException {
        while(true) {
            System.out.println("+----------------------------+");
            System.out.println("|  check you want to create  |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. USER                    |");
            System.out.println("| 2. DEPARTMENT              |");
            System.out.println("| 0. BACK                    |");
            System.out.println("+----------------------------+");

            switch(scanner.nextInt()) {
                case 1:
                    createUser();
                    break;
                case 2:
                    createDepartment();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }

    }

    private void createUser() throws SQLException {
        boolean undergraduate = false;
        boolean postgraduate = false;
        boolean assistant = false;
        boolean professor = false;
        boolean staff = false;
        int state;
        System.out.print("1: student, 2: assistant, 3: professor, 4: staff, 0: back >> ");
        state = scanner.nextInt();
        if (state == 1) {
            System.out.print("1: undergraduate, 2: postgraduate, 0: back >> ");
            state = scanner.nextInt();
            if (state == 1) {
                undergraduate = true;
            } else if (state == 2) {
                postgraduate = true;
            } else {
                return;
            }
        } else if (state == 2) {
            assistant = true;
        } else if (state == 3) {
            professor = true;
        } else if (state == 4) {
            staff = true;
        } else {
            return;
        }

        System.out.print("korean name: ");
        String kor_name = scanner.next();
        System.out.print("english name: ");
        String eng_name = scanner.next();
        System.out.print("birthdate: ");
        String birthdate = scanner.next();
        System.out.print("address: ");
        scanner.nextLine();
        String address = scanner.nextLine();
        System.out.print("phone number: ");
        String phone_number = scanner.next();
        System.out.print("account number: ");
        String account_number = scanner.next();
        System.out.print("email: ");
        String email = scanner.next();

        // insert to user table
        String sql = "CALL insert_user (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = db_connection.prepareStatement(sql);
        pstmt.setString(1, kor_name);
        pstmt.setString(2, eng_name);
        pstmt.setString(3, birthdate);
        pstmt.setString(4, address);
        pstmt.setString(5, phone_number);
        pstmt.setString(6, account_number);
        pstmt.setString(7, email);
        pstmt.setBoolean(8, undergraduate);
        pstmt.setBoolean(9, postgraduate);
        pstmt.setBoolean(10, assistant);
        pstmt.setBoolean(11, professor);
        pstmt.setBoolean(12, staff);
        pstmt.executeUpdate();
        pstmt.close();
    }

    private void createDepartment() throws SQLException {
        System.out.print("department name: ");
        scanner.nextLine();
        String department_name = scanner.nextLine();
        System.out.print("is it in undergraduate? (y/n) ");
        String undergraduate = scanner.next();
        boolean is_undergraduate = undergraduate.equals("Y") || undergraduate.equals("y");
        System.out.print("is it in postgraduate? (y/n) ");
        String postgraduate = scanner.next();
        boolean is_postgraduate = postgraduate.equals("Y") || postgraduate.equals("y");

        // insert to department table
        String sql = "CALL insert_department (?, ?, ?)";
        PreparedStatement pstmt = db_connection.prepareStatement(sql);
        pstmt.setString(1, department_name);
        pstmt.setBoolean(2, is_undergraduate);
        pstmt.setBoolean(3, is_postgraduate);
        pstmt.executeUpdate();
        pstmt.close();
    }

}
