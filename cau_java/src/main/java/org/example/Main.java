package org.example;
import java.sql.*;

public class Main {

    public static void main(String[] args) throws SQLException {

        DatabaseAuthInformation db_info = new DatabaseAuthInformation();
        String auth_filename = "auth/mysql.auth";
        if(!db_info.parse_auth_info(auth_filename)) {
            System.out.println("File open has been failed.");
            return;
        }
        String db_connection_url = String.format("jdbc:mysql://%s:%s/%s",
                db_info.getHost(),
                db_info.getPort(),
                db_info.getDatabase_name());

        Connection db_connection = DriverManager.getConnection(db_connection_url,
                db_info.getUsername(),
                db_info.getPassword());

        // use database cauportal
        Statement stmt = db_connection.createStatement();
        stmt.execute("USE cauportal");
        stmt.close();

        CLI CLI = new CLI(db_connection);
        CLI.run();


    }
}




