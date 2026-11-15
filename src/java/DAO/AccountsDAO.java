package DAO;

import Model.Accounts;
import Model.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountsDAO {

    public List<Accounts> getAccountsByRoles(String... roles) {
        List<Accounts> list = new ArrayList<>();

        if (roles == null || roles.length == 0) {
            return list;
        }

        try (Connection conn = DBConnection.getConnection()) {
            StringBuilder sql = new StringBuilder("SELECT `user_id`, `username`, `nickname` , `email`, `phone`, `password`, `role`,`avatar`,`address` FROM `users` WHERE role IN (");
            for (int i = 0; i < roles.length; i++) {
                sql.append("?");
                if (i < roles.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < roles.length; i++) {
                ps.setString(i + 1, roles[i]);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts();

                a.setUserID(rs.getInt("user_id"));
                a.setUsername(rs.getString("username"));
                a.setNickname(rs.getString("nickname"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getString("role"));
                a.setAvatar(rs.getString("avatar"));
                a.setAddress(rs.getString("address"));

                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Accounts> getAccountsByRole(String role) {
        List<Accounts> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts();
                a.setUserID(rs.getInt("user_id"));
                a.setUsername(rs.getString("username"));
                a.setNickname(rs.getString("nickname"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getString("role"));
                a.setAvatar(rs.getString("avatar"));
                a.setAddress(rs.getString("address"));

                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Accounts getAccountByID(int user_id) {
        Accounts a = new Accounts();
        String sql = "SELECT * FROM users WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                a.setUserID(rs.getInt("user_id"));
                a.setUsername(rs.getString("username"));
                a.setNickname(rs.getString("nickname"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getString("role"));
                a.setAvatar(rs.getString("avatar"));
                a.setAddress(rs.getString("address"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }
    
    public List<Accounts> getAllAccounts() {
        List<Accounts> list = new ArrayList<>();
        String sql = "SELECT * FROM `users`";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts();
                a.setUserID(rs.getInt("user_id"));
                a.setUsername(rs.getString("username"));
                a.setNickname(rs.getString("nickname"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getString("role"));
                a.setAvatar(rs.getString("avatar"));
                a.setAddress(rs.getString("address"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addAccount(String username, String nickname, String email, String phone, String password, String role, String avatar, String address) {
        String sql = "INSERT INTO `users`( `username`, `nickname`, `email`, `phone`, `password`, `role`,`avatar`,`address`) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, nickname);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, password);
            ps.setString(6, role);
            ps.setString(7, avatar);
            ps.setString(8, address);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateAccount(int id, String username, String nickname, String email, String phone, String password, String role, String avatar, String address) {
        String sql = "UPDATE `users` SET `username`=?,`nickname`=?,`email`=?,`phone`=?,`password`=?,`role`=?,avatar=?,address=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, nickname);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, password);
            ps.setString(6, role);
            ps.setString(7, avatar);
            ps.setString(8, address);
            ps.setInt(9, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void deleteAccount(int id) {
        String sql = "DELETE FROM `users` WHERE  user_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public void updateUser(int id, String username, String nickname, String phone, String address) {
        String sql = "UPDATE users SET `username`=?,`nickname`=?,`phone`=?,address=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, nickname);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updatePassword(int id,String password) {
        String sql= "UPDATE users SET password=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, password);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void updateAvatar(int id,String avatar) {
        String sql= "UPDATE users SET avatar=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, avatar);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
