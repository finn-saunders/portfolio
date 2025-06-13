public class Product {

    private String code;
    private String description;
    private double price;

    // No-arg constructor
    public Product() {
        System.out.println("\nInside product default constructor.");
        code = "abc123";
        description = "My widget";
        price = 19.99;
    }

    // Parameterized constructor
    public Product(String code, String description, double price) {
        System.out.println("\nInside product constructor with parameters.");
        this.code = code;
        this.description = description;
        this.price = price;
    }

    // Getter and setter methods
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
        description = dsc;  // fixed the bug here
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double p) {
        price = p;
    }

    // Print method
    public void print() {
        System.out.println("\nCode: " + code + ", Description: " + description + ", Price: $" + price);
    }
}
