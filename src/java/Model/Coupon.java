package Model;

public class Coupon {

    private int coupon_id;
    private String code;
    private String discount_type;
    private double discount_value;

    public Coupon() {
    }

    public Coupon(int coupon_id,
                  String code,
                  String discount_type,
                  double discount_value) {

        this.coupon_id = coupon_id;
        this.code = code;
        this.discount_type = discount_type;
        this.discount_value = discount_value;
    }

    public int getCoupon_id() {
        return coupon_id;
    }

    public void setCoupon_id(int coupon_id) {
        this.coupon_id = coupon_id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDiscount_type() {
        return discount_type;
    }

    public void setDiscount_type(String discount_type) {
        this.discount_type = discount_type;
    }

    public double getDiscount_value() {
        return discount_value;
    }

    public void setDiscount_value(double discount_value) {
        this.discount_value = discount_value;
    }
}