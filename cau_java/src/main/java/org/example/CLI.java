package org.example;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

public class CLI {

    private final Connection db_connection;

    public CLI(Connection db_connection) {
        this.db_connection = db_connection;
    }

    private void quit() {
        System.out.println("Thank you!");
    }
    public void run() throws SQLException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("This is a database system for cau portal.");
        System.out.println();
        int state;
        while(true) {
            System.out.print("1: create, 2: search, 3: delete, 4: update, 0: quit >> ");
            state = scanner.nextInt();
            switch(state) {
                case 1:
                    CreateHandler prog = new CreateHandler(db_connection);
                    prog.execute();
                    break;
                case 2:
                    SearchHandler prog2 = new SearchHandler(db_connection);
                    prog2.execute();
                    break;
                case 3:
                    //delete();
                    break;
                case 4:
                    //update();
                    break;
                case 0:
                    quit();
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }



}

