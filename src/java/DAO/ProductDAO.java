package DAO;

import Model.Category;
import Model.DBConnection;
import Model.Product;
import java.sql.*;
import java.util.*;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            CategoryDAO cdao = new CategoryDAO();

            while (rs.next()) {
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setImg_path(rs.getString("img_path"));
                p.setSold(rs.getInt("sold"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                p.setCategories(
                        cdao.getCategoriesByProductId(p.getProduct_id())
                );
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTopSale() {
        List<Product> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT product_id, product_name, price, discount_percent, "
                    + "(price * (1 - discount_percent / 100)) AS gia_sau, img_path "
                    + "FROM products WHERE discount_percent > 0 "
                    + "ORDER BY sold DESC LIMIT 10";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setGia_sau(rs.getDouble("gia_sau"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                p.setImg_path(rs.getString("img_path"));

                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Map<Integer, List<Product>> getTrendy() {
        Map<Integer, List<Product>> map = new HashMap<>();
        int[] categories = {1, 7, 16, 17};
        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT sp.product_id,product_name, price , discount_percent, (price * (1 - discount_percent / 100)) AS gia_sau, img_path "
                    + "FROM products sp "
                    + "JOIN link_pd_cat lk ON sp.product_id = lk.product_id "
                    + "WHERE lk.category_id = ? "
                    + "ORDER BY sp.sold DESC LIMIT 6";

            for (int cateId : categories) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, cateId);

                ResultSet rs = ps.executeQuery();
                List<Product> list = new ArrayList<>();

                while (rs.next()) {
                    Product p = new Product();
                    p.setProduct_id(rs.getInt("product_id"));
                    p.setProduct_name(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setGia_sau(rs.getDouble("gia_sau"));
                    p.setDiscount_percent(rs.getInt("discount_percent"));
                    p.setImg_path(rs.getString("img_path"));

                    list.add(p);
                }

                map.put(cateId, list);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return map;
    }

    public Product getProductById(int id) {
        Product p = null;
        String sql = "SELECT *, (price * (1 - discount_percent / 100)) AS gia_sau "
                + "FROM products WHERE product_id=? ";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setGia_sau(rs.getDouble("gia_sau"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                p.setSold(rs.getInt("sold"));
                p.setImg_path(rs.getString("img_path"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    public List<Category> getCategoriesByProductId(int productId) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM category dm "
                + "JOIN link_pd_cat spdm ON dm.category_id = spdm.category_id "
                + "WHERE spdm.product_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("category_id"));
                c.setCategoryName(rs.getString("category_name"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products sp "
                + "JOIN link_pd_cat l ON sp.product_id = l.product_id "
                + "WHERE l.category_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            CategoryDAO cdao = new CategoryDAO();
            while (rs.next()) {
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                p.setSold(rs.getInt("sold"));
                p.setImg_path(rs.getString("img_path"));
                p.setCategories(cdao.getCategoriesByProductId(p.getProduct_id()));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategory(int categoryId, double min, double max, String sort, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT DISTINCT p.*, (price * (100 - discount_percent) / 100) AS gia_sau ") // Note the space at the end
                .append("FROM products p ")
                .append("INNER JOIN link_pd_cat pc ")
                .append("ON p.product_id = pc.product_id ")
                .append("WHERE 1=1 ");
        if (categoryId != 0) {
            sql.append(" AND pc.category_id = ? ");
        }
        sql.append(" AND (price * (100 - discount_percent) / 100) >= ? ")
                .append(" AND (price * (100 - discount_percent) / 100) <= ? ");
        // SORT
        switch (sort) {
            case "az":
                sql.append(" ORDER BY p.product_name ASC ");
                break;
            case "za":
                sql.append(" ORDER BY p.product_name DESC ");
                break;
            case "low":
                sql.append(" ORDER BY (price * (100 - discount_percent) / 100) ASC ");
                break;
            case "high":
                sql.append(" ORDER BY (price * (100 - discount_percent) / 100) DESC ");
                break;
            default:
                sql.append(" ORDER BY p.product_id DESC ");
        }
        sql.append(" LIMIT ?, ? ");
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            if (categoryId != 0) {
                ps.setInt(index++, categoryId);
            }
            ps.setDouble(index++, min);
            ps.setDouble(index++, max);
            ps.setInt(index++, offset);
            ps.setInt(index++, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setGia_sau(rs.getDouble("gia_sau"));
                p.setPrice(rs.getDouble("price"));
                p.setImg_path(rs.getString("img_path"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countProductsByCategory(int categoryId,double min,double max ) {
        int total = 0;
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT COUNT(DISTINCT p.product_id) ")
                .append(" FROM products p ")
                .append(" INNER JOIN link_pd_cat pc ")
                .append(" ON p.product_id = pc.product_id ")
                .append(" WHERE 1=1 ");
        if (categoryId != 0) {
            sql.append(" AND pc.category_id = ? ");
        }
        sql.append(" AND (price * (100 - discount_percent) / 100) >= ? ")
                .append(" AND (price * (100 - discount_percent) / 100) <= ? ");
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            if (categoryId != 0) {
                ps.setInt(index++, categoryId);
            }
            ps.setDouble(index++, min);
            ps.setDouble(index++, max);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public void addProduct(String name, double price, String descrip, int sold, String image, int dis, String[] categoryIds) {
        String sql = "INSERT INTO `products`( `product_name`, `price`, `description`, `sold`, `img_path`, `discount_percent`) VALUES (?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, descrip);
            ps.setInt(4, sold);
            ps.setString(5, image);
            ps.setInt(6, dis);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int productId = 0;
            if (rs.next()) {
                productId = rs.getInt(1);
            }
            if (categoryIds != null) {
                for (String cid : categoryIds) {
                    PreparedStatement ps2 = conn.prepareStatement("INSERT INTO `link_pd_cat`(`category_id`, `product_id`) VALUES (?,?)");
                    ps2.setInt(1, Integer.parseInt(cid));
                    ps2.setInt(2, productId);
                    ps2.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(int id, String name, double price, String descrip, int sold, String image, int dis, String[] categoryIds) {
        String sql = "UPDATE `products` SET `product_name`=?,`price`=?,`description`=?,`sold`=?,`img_path`=?,`discount_percent`=? WHERE `product_id`=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, descrip);
            ps.setInt(4, sold);
            ps.setString(5, image);
            ps.setInt(6, dis);
            ps.setInt(7, id);
            ps.executeUpdate();
            ps.executeUpdate();
            PreparedStatement psDel = conn.prepareStatement("DELETE FROM `link_pd_cat`  WHERE product_id=?");
            psDel.setInt(1, id);
            psDel.executeUpdate();
            if (categoryIds != null) {
                for (String cid : categoryIds) {
                    PreparedStatement ps2 = conn.prepareStatement("INSERT INTO `link_pd_cat`(`category_id`, `product_id`) VALUES (?, ?)");
                    ps2.setInt(1, Integer.parseInt(cid));
                    ps2.setInt(2, id);
                    ps2.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM `products`  WHERE product_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String sql2 = "DELETE FROM `link_pd_cat` WHERE product_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps2 = conn.prepareStatement(sql2)) {
            ps2.setInt(1, id);
            ps2.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countProducts() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM products";
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

    public List<Product> searchProducts(String keyword, int categoryId, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT DISTINCT p.*, ")
                .append(" (p.price * (1 - p.discount_percent / 100.0)) AS gia_sau ")
                .append(" FROM products p ")
                .append(" LEFT JOIN link_pd_cat l ")
                .append(" ON p.product_id = l.product_id ")
                .append(" WHERE ( ")
                .append("     p.product_name LIKE ? ")
                .append("     OR p.description LIKE ? ")
                .append(" ) ");

        if (categoryId != 0) {
            sql.append(" AND l.category_id = ? ");
        }
        sql.append(" ORDER BY p.product_id DESC ").append(" LIMIT ?, ? ");
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
            if (categoryId != 0) {
                ps.setInt(index++, categoryId);
            }
            ps.setInt(index++, offset);
            ps.setInt(index, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setGia_sau(rs.getDouble("gia_sau"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                p.setSold(rs.getInt("sold"));
                p.setImg_path(rs.getString("img_path"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearchProducts(String keyword, int categoryId) {
        int total = 0;
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT COUNT(DISTINCT p.product_id) ")
                .append(" FROM products p ")
                .append(" LEFT JOIN link_pd_cat l ")
                .append(" ON p.product_id = l.product_id ")
                .append(" WHERE ( ")
                .append("     p.product_name LIKE ? ")
                .append("     OR p.description LIKE ? ")
                .append(" ) ");
        if (categoryId != 0) {
            sql.append(" AND l.category_id = ? ");
        }
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
            if (categoryId != 0) {
                ps.setInt(index++, categoryId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Product> searchSale(String keyword, int categoryId, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT DISTINCT p.*, ")
                .append(" (p.price * (1 - p.discount_percent / 100.0)) AS gia_sau ")
                .append(" FROM products p ")
                .append(" LEFT JOIN link_pd_cat l ")
                .append(" ON p.product_id = l.product_id ")
                .append(" WHERE p.discount_percent > 0 ")
                .append(" AND ( ")
                .append("     p.product_name LIKE ? ")
                .append("     OR p.description LIKE ? ")
                .append(" ) ");
        if (categoryId != 0) {
            sql.append(" AND l.category_id = ? ");
        }
        sql.append(" ORDER BY p.product_id DESC ").append(" LIMIT ?, ? ");
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
            if (categoryId != 0) {
                ps.setInt(index++, categoryId);
            }
            ps.setInt(index++, offset);
            ps.setInt(index, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setGia_sau(rs.getDouble("gia_sau"));
                p.setDiscount_percent(rs.getInt("discount_percent"));
                p.setSold(rs.getInt("sold"));
                p.setImg_path(rs.getString("img_path"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSaleProducts(String keyword, int categoryId) {
        int total = 0;
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT COUNT(DISTINCT p.product_id) ")
                .append(" FROM products p ")
                .append(" LEFT JOIN link_pd_cat l ")
                .append(" ON p.product_id = l.product_id ")
                .append(" WHERE p.discount_percent > 0 ")
                .append(" AND ( ")
                .append("     p.product_name LIKE ? ")
                .append("     OR p.description LIKE ? ")
                .append(" ) ");
        if (categoryId != 0) {
            sql.append(" AND l.category_id = ? ");
        }
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
            if (categoryId != 0) {
                ps.setInt(index++, categoryId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
