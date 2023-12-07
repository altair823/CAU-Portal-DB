package org.example;

import java.sql.Connection;
import java.util.Scanner;

public class CreateHandler implements DBHandler {

    private Connection db_connection;
    private final Scanner scanner = new Scanner(System.in);

    public CreateHandler(Connection db_connection) {
        this.db_connection = db_connection;
    }

    public void execute() {
        while(true) {
            System.out.println("check you want to create table(1: user, 2: department, 0: back) >> ");
            switch(scanner.nextInt()) {
                case 1:
                    createUser();
                    break;
                case 2:
                    //  search();
                    break;
                case 3:
                    //delete();
                    break;
                case 4:
                    //update();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }

    }

    private void createUser() {
        boolean undergraduate = false;
        boolean postgraduate = false;
        boolean assistant = false;
        boolean professor = false;
        boolean staff = false;
        System.out.print("student: 1, assistant: 2, professor: 3, staff: 4, back: 0 >> ");
        if (scanner.nextInt() == 1) {
            System.out.print("undergraduate: 1, postgraduate: 2, back: 0 >> ");
            if (scanner.nextInt() == 1) {
                undergraduate = true;
            } else if (scanner.nextInt() == 2) {
                postgraduate = true;
            } else {
                return;
            }
        } else if (scanner.nextInt() == 2) {
            assistant = true;
        } else if (scanner.nextInt() == 3) {
            professor = true;
        } else if (scanner.nextInt() == 4) {
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
        String address = scanner.next();
        System.out.print("phone number: ");
        String phone_number = scanner.next();
        System.out.print("account number: ");
        String account_number = scanner.next();
        System.out.print("email: ");
        String email = scanner.next();
    }

    private void createUndergraduate()
}
