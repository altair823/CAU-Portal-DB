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
        System.out.println();
        int state;
        while(true) {
            System.out.println("+----------------------------+");
            System.out.println("|        cau portal          |");
            System.out.println("+----------------------------+");
            System.out.println("|           MENU             |");
            System.out.println("+----------------------------+");
            System.out.println("| 1. CREATE                  |");
            System.out.println("| 2. SEARCH                  |");
            System.out.println("| 3. UPDATE                  |");
            System.out.println("| 4. DELETE                  |");
            System.out.println("| 0. QUIT                    |");
            System.out.println("+----------------------------+");
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
                    UpdateHandler prog3 = new UpdateHandler(db_connection);
                    prog3.execute();
                    break;
                case 4:
                    DeleteHandler prog4 = new DeleteHandler(db_connection);
                    prog4.execute();
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

