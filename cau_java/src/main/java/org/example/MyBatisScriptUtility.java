package org.example;

import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.FileNotFoundException;
import java.sql.Connection;

public class MyBatisScriptUtility {
    public static void runScript(
            String path,
            Connection connection
    ) throws FileNotFoundException {
        ScriptRunner scriptRunner = new ScriptRunner(connection);
        scriptRunner.setSendFullScript(false);
        scriptRunner.setStopOnError(true);
        scriptRunner.runScript(new java.io.FileReader(path));
    }
}