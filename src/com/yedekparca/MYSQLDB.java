package com.yedekparca;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

public class MYSQLDB {

    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/";

    String dbName = "yedekparca";
    String dbUser = "admin";
    String dbPass = "123456";

    Connection con = null;
    Statement st = null;

    public MYSQLDB() {
    }

    public MYSQLDB(String dbName) {
        this.dbName = dbName;
    }

    public Statement baglan() {
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url + dbName + "?useUnicode=true&characterEncoding=utf-8", dbUser, dbPass);
            st = con.createStatement();
            System.out.println("Bağlantı başarılı");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Bağlantı Hatası : " + e);
            JOptionPane.showMessageDialog(null, "Veritabanı bağlantınızı kontrol ediniz");
        }
        return st;
    }

}
