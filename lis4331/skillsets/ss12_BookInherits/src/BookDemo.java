import java.util.Scanner;

public class BookDemo {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        // 1) Instantiate a Product using the no-arg constructor
        System.out.println("////Below are base class \"Product\" default constructor values:////");
        Product p1 = new Product();  // calls Product() constructor
        p1.print();

        // 2) Instantiate a Product using user-entered data
        System.out.println("\n////Below are base class user-entered values:////");
        System.out.print("Enter code: ");
        String code = sc.nextLine();

        System.out.print("Enter description: ");
        String desc = sc.nextLine();

        System.out.print("Enter price: ");
        double price = sc.nextDouble();
        sc.nextLine();  // consume leftover newline

        Product p2 = new Product(code, desc, price);
        p2.print();

        // 3) Instantiate a Book using the no-arg constructor
        System.out.println("\n////Below are derived class \"Book\" default constructor values:////");
        Book b1 = new Book();  // calls Book() constructor
        b1.print();

        // 4) Instantiate a Book using user-entered data
        System.out.println("\n////Below are derived class user-entered values:////");
        System.out.print("Enter code: ");
        String codeB = sc.nextLine();

        System.out.print("Enter description: ");
        String descB = sc.nextLine();

        System.out.print("Enter price: ");
        double priceB = sc.nextDouble();
        sc.nextLine();  // consume leftover newline

        System.out.print("Enter author: ");
        String author = sc.nextLine();

        Book b2 = new Book(codeB, descB, priceB, author);
        b2.print();

        sc.close();
    }
}
