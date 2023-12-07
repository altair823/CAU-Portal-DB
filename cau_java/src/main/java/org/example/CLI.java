package org.example;
import java.sql.Connection;
import java.util.Scanner;

public class CLI {

    private Connection db_connection;

    public CLI(Connection db_connection) {
        this.db_connection = db_connection;
    }

    private void quit() {
        System.out.println("Thank you!");
    }
    public void run() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("This is a database system for cau portal.");
        System.out.println();
        int state;
        while(true) {
            System.out.print("create: 1, search: 2, delete: 3, update: 4 , quit:0 >> ");
            state = scanner.nextInt();
            switch(state) {
                case 1:
                    CreateHandler prog = new CreateHandler(db_connection);
                    prog.execute();
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
                    quit();
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }



}

