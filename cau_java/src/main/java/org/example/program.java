package org.example;
import java.util.Scanner;

public class program {
    private Scanner scanner = new Scanner(System.in);

    private void quit() {
        System.out.println("Thank you!");
    }
    public void run() {
        System.out.println("This is a database system for cau portal.");
        System.out.println();
        int state;
        while(true) {
            System.out.print("create: 1, search: 2, delete: 3, update: 4 , quit:5 >>");
            state = scanner.nextInt();
            switch(state) {
                case 1:
                    db_create prog = new db_create();
                    prog.create();
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
                case 5:
                    quit();
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }



}

