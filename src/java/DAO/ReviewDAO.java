package DAO;

import Model.DBConnection;
import Model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // ADD REVIEW
    public boolean addReview(int productId,int userId,int rating,String comment) {
        String sql = "INSERT INTO review "
           + "(product_id, user_id, rating, comment, review_date) "
           + "VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            int rows = ps.executeUpdate();
            System.out.println("INSERT REVIEW SUCCESS: " + rows);
            return rows > 0;
        } catch (Exception e) {
            System.out.println("ADD REVIEW ERROR");
            e.printStackTrace();
            return false;
        }
    }

    // GET REVIEW BY PRODUCT
    public List<Review> getReviewsByProduct(int productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.review_id, r.product_id, r.user_id, r.rating, r.comment, r.review_date, u.username "
           + "FROM review r "
           + "INNER JOIN users u ON r.user_id = u.user_id "
           + "WHERE r.product_id = ? "
           + "ORDER BY r.review_date DESC";
        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReview_id(rs.getInt("review_id"));
                review.setProduct_id(rs.getInt("product_id"));
                review.setUser_id(rs.getInt("user_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReview_date(rs.getTimestamp("review_date"));
                review.setUsername(rs.getString("username"));
                list.add(review);
            }
            System.out.println("TOTAL REVIEWS = " + list.size());
        } catch (Exception e) {
            System.out.println("GET REVIEW ERROR");
            e.printStackTrace();
        }
        return list;
    }
}