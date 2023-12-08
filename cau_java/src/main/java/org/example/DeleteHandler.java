package org.example;

import java.sql.Connection;
import java.util.Scanner;

public class DeleteHandler {

    private final Scanner scanner = new Scanner(System.in);

    public DeleteHandler(Connection db_connection) {
    }

    public void execute() {
        while(true) {
            System.out.print("check you want to delete table(1: user, 2: department, 0: back) >> ");
            switch(scanner.nextInt()) {
                case 1:
//                    deleteUser();
                    break;
                case 2:
//                    deleteDepartment();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }
}
