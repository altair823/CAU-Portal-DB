package org.example;

import java.sql.*;
import java.util.Scanner;

public class db_create {


    private Scanner scanner = new Scanner(System.in);
    public void create() {
        System.out.println("check you want to create table( 1: user, 2: department)");
        System.out.println();
        int state;
        while(true) {
            state = scanner.nextInt();
            switch(state) {
                case 1:
                    System.out.print("user data format: 이름, 영어, 생일, 주소, 핸드폰 번호, 계좌, 이메일, 학부생, 대학원생, 조교, 교수,임직원");

//"call insert_user( , , , , , , ) "
                    //create();
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
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }

    }
}
