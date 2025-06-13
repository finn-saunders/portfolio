public class Product {

    private String code;
    private String description;
    private double price;


    public Product() {
        System.out.println("\nInside person default constructor.");
        code = "abc123";
        description = "Product code";
        price = 19.99;
    }

    public Product(String code, String description, double price) {
        System.out.println("\nInside person constructor with parameters.");
        this.code = code;
        this.description = description;
        this.price = price;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String cd) {
        code = cd;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String dsc) {
        code = dsc
;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double p) {
        price = p;
    }


    public void print() {
        System.out.println("\ncode: " + code + ", description: " + description + ", price: " + price);
    }
}
