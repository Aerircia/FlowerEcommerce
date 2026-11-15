package DAO;

import Model.Coupon;
import Model.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CouponDAO {

    public Coupon getCouponByCode(String code) {

        String sql = "SELECT * FROM coupons WHERE code = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, code);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return new Coupon(
                    rs.getInt("coupon_id"),
                    rs.getString("code"),
                    rs.getString("discount_type"),
                    rs.getDouble("discount_value")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}