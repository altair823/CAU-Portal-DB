package org.example;

import java.sql.Connection;
import java.util.Scanner;

public class DeleteHandler {

    private final Scanner scanner = new Scanner(System.in);

    public DeleteHandler(Connection db_connection) {
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
