package org.example;
import java.sql.*;

public class Main {
    public static void main(String[] args) {

        DatabaseAuthInformation db_info= new DatabaseAuthInformation();
        String auth_filename= "auth/mysql.auth";
        if(!db_info.parse_auth_info(auth_filename)) {
            System.out.println("File open has been failed.");
            return;
        }
        String db_connection_url= String.format("jdbc:mysql://%s:%s/%s",
                db_info.getHost(),
                db_info.getPort(),
                db_info.getDatabase_name());

        String query_string= "select eng_name,birthdate from user ";

        try(Connection db_connection= DriverManager.getConnection(db_connection_url,
                db_info.getUsername(),
                db_info.getPassword());
            Statement stmt=db_connection.createStatement();
            ResultSet rs=stmt.executeQuery(query_string))
        {
            while(rs.next()){
                String birthdate=rs.getString("birthdate");
                String eng_name=rs.getString("eng_name");
                System.out.println(eng_name+","+birthdate);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

    }
}




