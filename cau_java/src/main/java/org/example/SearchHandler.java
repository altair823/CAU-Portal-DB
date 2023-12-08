package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class SearchHandler implements DBHandler {

    private final Connection db_connection;

    private final Scanner scanner = new Scanner(System.in);

    public SearchHandler(Connection db_connection) {
        this.db_connection = db_connection;
    }

    public void execute() {
        while(true) {
            System.out.print("check you want to search table(1: user information, 2: timetable, 3: GPA, 0: back) >> ");
            switch(scanner.nextInt()) {
                case 1:
                    searchUser();
                    break;
                case 2:
                    searchTimetable();
                    break;
                case 3:
                    searchGPA();
                    break;
                case 0:
                    return;
                default:
                    System.out.println("This is a wrong command.");
            }
            System.out.println();
        }
    }

    private void searchGPA() {
        System.out.print("enter undergraduate ID >> ");
        String undergraduate_id = scanner.next();
        try {
            PreparedStatement pstmt = db_connection.prepareStatement("SELECT round(sum(grade * credit) / sum(credit), 2) FROM take_class " +
                    "JOIN class ON take_class.class_id = class.class_id " +
                    "JOIN course ON class.course_id = course.course_id " +
                    "JOIN student ON take_class.student_id = student.student_id " +
                    "JOIN undergraduate ON student.student_id = undergraduate.student_id " +
                    "WHERE undergraduate.undergraduate_id = ?;");
            pstmt.setString(1, undergraduate_id);
            ResultSet resultSet = pstmt.executeQuery();
            resultSet.next();

            System.out.println("GPA: " + resultSet.getString(1));

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void searchTimetable() {
        System.out.print("enter undergraduate ID >> ");
        String undergraduate_id = scanner.next();
        try {
            PreparedStatement pstmt = db_connection.prepareStatement("SELECT day, course.name, division, start_time, end_time, building_num, room.room_num " +
                    "FROM class_time " +
                    "JOIN class ON class_time.class_id = class.class_id " +
            "JOIN course ON class.course_id = course.course_id " +
            "JOIN take_class ON class_time.class_id = take_class.class_id " +
            "JOIN room ON class_time.room_id = room.room_id " +
            "JOIN building ON room.building_id = building.building_id " +
            "JOIN undergraduate ON take_class.student_id = undergraduate.undergraduate_id " +
            "WHERE undergraduate.undergraduate_id = ?  ORDER BY day, start_time;");
            pstmt.setString(1, undergraduate_id);
            ResultSet resultSet = pstmt.executeQuery();

            String day = "0";
            while (resultSet.next()) {
                if (!day.equals(resultSet.getString(1))) {
                    String day_string = switch (resultSet.getString(1)) {
                        case "1" -> "월";
                        case "2" -> "화";
                        case "3" -> "수";
                        case "4" -> "목";
                        case "5" -> "금";
                        default -> "";
                    };
                    System.out.println();
                    System.out.print(day_string + "요일   -   ");
                    day = resultSet.getString(1);
                }
                System.out.print(resultSet.getString(2) + " ");
                System.out.print(" " + resultSet.getString(3) + "분반 ");
                System.out.print(" " + resultSet.getString(4) + " ~");
                System.out.print(" " + resultSet.getString(5) + " ");
                System.out.print(" " + resultSet.getString(6) + "관 ");
                System.out.print(" " + resultSet.getString(7) + "호 | ");
            }



        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void searchUser() {
        while(true) {
            System.out.print("1: student, 2: assistant, 3: professor, 4: staff, 0: back >> ");
            switch (scanner.nextInt()) {
                case 1:
                    searchStudent();
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

    private void searchStudent() {
        System.out.print("1: undergraduate, 2: postgraduate, 0: back >> ");
        switch (scanner.nextInt()) {
            case 1:
                searchUndergraduate();
                break;
            case 2:
                searchPostgraduate();
                break;
            case 0:
                return;
            default:
                System.out.println("This is a wrong command.");
        }
    }

    private void searchPostgraduate() {
        System.out.print("enter postgraduate ID >> ");
        String postgraduate_id = scanner.next();

        try {
            PreparedStatement pstmt = db_connection.prepareStatement("SELECT get_user_id_from_postgraduate_id(?)");
            pstmt.setString(1, postgraduate_id);
            ResultSet resultSet = pstmt.executeQuery();
            resultSet.next();

            String user_id;
            if (resultSet.getString(1) != null) {
                user_id = resultSet.getString(1);
            } else {
                System.out.println("There is no such postgraduate.");
                return;
            }

            pstmt = db_connection.prepareStatement("SELECT active FROM user WHERE user_id = ?");
            pstmt.setString(1, user_id);
            resultSet = pstmt.executeQuery();
            resultSet.next();
            if (!resultSet.getBoolean(1)) {
                System.out.println("There is no such postgraduate.(inactivated)");
                return;
            }

            pstmt = db_connection.prepareStatement("SELECT * FROM user WHERE user_id = ?");
            pstmt.setString(1, user_id);
            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                System.out.println("id: " + resultSet.getString(1));
                System.out.println("korean name: " + resultSet.getString(2));
                System.out.println("english name: " + resultSet.getString(3));
                System.out.println("birthdate: " + resultSet.getString(4));
                System.out.println("address: " + resultSet.getString(5));
                System.out.println("phone number: " + resultSet.getString(6));
                System.out.println("account number: " + resultSet.getString(7));
                System.out.println("email: " + resultSet.getString(8));
            } else {
                System.out.println("There is no such user.");
            }

            pstmt = db_connection.prepareStatement("SELECT * FROM postgraduate_state WHERE postgraduate_id = ? AND modified_date = " +
                    "(SELECT MAX(modified_date) FROM postgraduate_state WHERE postgraduate_id = ?)");
            pstmt.setString(1, postgraduate_id);
            pstmt.setString(2, postgraduate_id);
            resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                System.out.println("state: " + resultSet.getString(2));
                System.out.println("modified date: " + resultSet.getString(3));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void searchUndergraduate() {
        System.out.print("enter undergraduate ID >> ");
        String undergraduate_id = scanner.next();

        try {
            PreparedStatement pstmt = db_connection.prepareStatement("SELECT get_user_id_from_undergraduate_id(?)");
            pstmt.setString(1, undergraduate_id);
            ResultSet resultSet = pstmt.executeQuery();
            resultSet.next();

            String user_id;
            if (resultSet.getString(1) != null) {
                user_id = resultSet.getString(1);
            } else {
                System.out.println("There is no such undergraduate.");
                return;
            }

            pstmt = db_connection.prepareStatement("SELECT active FROM user WHERE user_id = ?");
            pstmt.setString(1, user_id);
            resultSet = pstmt.executeQuery();
            resultSet.next();
            if (!resultSet.getBoolean(1)) {
                System.out.println("There is no such undergraduate.(inactivated)");
                return;
            }

            pstmt = db_connection.prepareStatement("SELECT * FROM user WHERE user_id = ?");
            pstmt.setString(1, user_id);
            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                System.out.println("id: " + resultSet.getString(1));
                System.out.println("korean name: " + resultSet.getString(2));
                System.out.println("english name: " + resultSet.getString(3));
                System.out.println("birthdate: " + resultSet.getString(4));
                System.out.println("address: " + resultSet.getString(5));
                System.out.println("phone number: " + resultSet.getString(6));
                System.out.println("account number: " + resultSet.getString(7));
                System.out.println("email: " + resultSet.getString(8));
            } else {
                System.out.println("There is no such user.");
            }

            pstmt = db_connection.prepareStatement("SELECT * FROM undergraduate_state WHERE undergraduate_id = ? AND modified_date = " +
                    "(SELECT MAX(modified_date) FROM undergraduate_state WHERE undergraduate_id = ?)");
            pstmt.setString(1, undergraduate_id);
            pstmt.setString(2, undergraduate_id);
            resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                System.out.println("state: " + resultSet.getString(2));
                System.out.println("modified date: " + resultSet.getString(3));
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
