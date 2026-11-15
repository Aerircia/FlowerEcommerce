package DAO;

import Model.CartItem;
import Model.DBConnection;
import Model.Orders;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {

    public boolean createOrder(Orders order,
            java.util.Collection<CartItem> items) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();

            conn.setAutoCommit(false);
            String sqlOrder = "INSERT INTO orders ("
                    + "buyer_name, "
                    + "receiver_name, "
                    + "buyer_phone, "
                    + "receiver_phone, "
                    + "buyer_email, "
                    + "shipping_address, "
                    + "order_date, "
                    + "delivery_date, "
                    + "note, "
                    + "payment_method, "
                    + "total,"
                    + "buyer_id"
                    + ") "
                    + "VALUES (?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?)";

            PreparedStatement psOrder = conn.prepareStatement(
                    sqlOrder,
                    PreparedStatement.RETURN_GENERATED_KEYS
            );

            psOrder.setString(1, order.getBuyer_name());
            psOrder.setString(2, order.getReceiver_name());
            psOrder.setString(3, order.getBuyer_phone());
            psOrder.setString(4, order.getReceiver_phone());
            psOrder.setString(5, order.getBuyer_email());
            psOrder.setString(6, order.getShipping_address());
            psOrder.setDate(7, Date.valueOf(order.getDelivery_date()));
            psOrder.setString(8, order.getNote());
            psOrder.setInt(9, order.getPayment_method());
            psOrder.setDouble(10, order.getTotal());
            psOrder.setDouble(11, order.getBuyer_id());

            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return false;
            }

            int orderId = 0;
            ResultSet rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            String sqlDetail = "INSERT INTO order_details ("
                    + "order_id, "
                    + "product_id, "
                    + "quantity, "
                    + "price"
                    + ") "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
            for (CartItem item : items) {
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, item.getProduct_id());
                psDetail.setInt(3, item.getQuantity());
                psDetail.setDouble(4, item.getPrice());
                psDetail.executeUpdate();
            }
            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Orders> getOrdersByID(int id) {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE buyer_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders a = new Orders();
                a.setOrder_id(rs.getInt("order_id"));
                a.setBuyer_id(rs.getInt("buyer_id"));
                a.setBuyer_name(rs.getString("buyer_name"));
                a.setReceiver_name(rs.getString("receiver_name"));
                a.setBuyer_phone(rs.getString("buyer_phone"));
                a.setReceiver_phone(rs.getString("receiver_phone"));
                a.setBuyer_email(rs.getString("buyer_email"));
                a.setShipping_address(rs.getString("shipping_address"));
                a.setNote(rs.getString("note"));
                java.sql.Date deliveryDate = rs.getDate("delivery_date");
                if (deliveryDate != null) {
                    a.setDelivery_date(deliveryDate.toLocalDate());
                }
                a.setTotal(rs.getDouble("total"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateOrder(int orderId, String buyerName, String receiverName, String buyerPhone, String receiverPhone, String buyerEmail, String shippingAddress, String note, LocalDate deliveryDate) {
        String sql = "UPDATE orders SET buyer_name=?, receiver_name=?, buyer_phone=?, receiver_phone=?, buyer_email=?, shipping_address=?, note=?, delivery_date=? WHERE order_id=?";
        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, buyerName);
            ps.setString(2, receiverName);
            ps.setString(3, buyerPhone);
            ps.setString(4, receiverPhone);
            ps.setString(5, buyerEmail);
            ps.setString(6, shippingAddress);
            ps.setString(7, note);
            ps.setDate(8, java.sql.Date.valueOf(deliveryDate));
            ps.setInt(9, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Orders> getAllOrders() {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders a = new Orders();
                a.setOrder_id(rs.getInt("order_id"));
                a.setBuyer_id(rs.getInt("buyer_id"));
                a.setBuyer_name(rs.getString("buyer_name"));
                a.setReceiver_name(rs.getString("receiver_name"));
                a.setBuyer_phone(rs.getString("buyer_phone"));
                a.setReceiver_phone(rs.getString("receiver_phone"));
                a.setBuyer_email(rs.getString("buyer_email"));
                a.setShipping_address(rs.getString("shipping_address"));
                a.setNote(rs.getString("note"));
                java.sql.Date deliveryDate = rs.getDate("delivery_date");
                if (deliveryDate != null) {
                    a.setDelivery_date(deliveryDate.toLocalDate());
                }
                a.setTotal(rs.getDouble("total"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void completeOrder(int orderId) {
        String sql = "UPDATE orders SET status='completed' WHERE order_id=?";
        try (
            Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteOrder(int id) {
        String sql = "DELETE FROM `orders` WHERE order_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countOrders() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders";
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

    public double getTotalRevenue() {
        double total = 0;
        String sql
                = "SELECT SUM(total) "
                + "FROM orders "
                + "WHERE status='completed'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public double[] getMonthlyRevenue() {
        double[] revenue = new double[12];
        String sql
                = "SELECT MONTH(delivery_date) as month, SUM(total) as revenue "
                + "FROM orders "
                + "WHERE status='completed' "
                + "GROUP BY MONTH(delivery_date)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                revenue[month - 1] = rs.getDouble("revenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenue;
    }

    public List<Double> getRevenueByMonth() {
        List<Double> list = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            list.add(0.0);
        }
        String sql = "SELECT MONTH(order_date) AS month, SUM(total) AS revenue FROM orders WHERE status = 'completed'GROUP BY MONTH(order_date)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                double revenue = rs.getDouble("revenue");
                list.set(month - 1, revenue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
