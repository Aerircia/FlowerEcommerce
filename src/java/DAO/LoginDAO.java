package DAO;

import Model.Accounts;
import Model.DBConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO {

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/shop";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public static Accounts getUserByEmail(String email)
            throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Accounts acc = new Accounts();
                acc.setUserID(rs.getInt("user_id"));
                acc.setUsername(rs.getString("username"));
                acc.setEmail(rs.getString("email"));
                acc.setPassword(rs.getString("password"));
                acc.setRole(rs.getString("role"));
                return acc;
            }
        }
        return null;
    }
    public static Accounts getUserByPhone(String phone)
            throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE phone = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Accounts acc = new Accounts();
                acc.setUserID(rs.getInt("user_id"));
                acc.setUsername(rs.getString("username"));
                acc.setEmail(rs.getString("email"));
                acc.setPassword(rs.getString("password"));
                acc.setRole(rs.getString("role"));
                return acc;
            }
        }
        return null;
    }

    public static String findUserRole(String email) throws ClassNotFoundException, SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT role FROM users WHERE email = ?")) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("role");
                }
            }
        }
        return null;
    }

    public static String findUserName(String email) throws ClassNotFoundException, SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT username FROM users WHERE email = ?")) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username");
                }
            }
        }
        return null;
    }

    public static int findUserID(String email) throws ClassNotFoundException, SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT user_id FROM users WHERE email = ?")) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id");
                }
            }
        }
        return 0;
    }

    public static boolean isEmailTaken(String email) throws ClassNotFoundException, SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT 1 FROM users WHERE email = ?")) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static boolean isUserNameTaken(String username) throws ClassNotFoundException, SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT 1 FROM users WHERE username = ?")) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static boolean createUser(String username, String nickname, String email, String phone, String password) throws ClassNotFoundException, SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO users (username, nickname, email, phone, password) VALUES (?, ?, ?, ?, ?)")) {
            stmt.setString(1, username);
            stmt.setString(2, nickname);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, password);
            return stmt.executeUpdate() == 1;
        }
    }

    private static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName(JDBC_DRIVER);
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
