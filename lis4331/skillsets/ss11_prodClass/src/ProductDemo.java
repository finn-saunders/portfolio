import java.util.Scanner;

class PersonDemo {
    public static void main(String[] args) {
        String cd = "";
        String dsc = "";
        double p = 0;
        Scanner sc = new Scanner(System.in);

        System.out.println("\n/////Below are default constructor values://///");
        Product v1 = new Product();
        System.out.println("\nCode = " + v1.getCode());
        System.out.println("\nDescription = " + v1.getDescription());
        System.out.println("\nPrice = " + v1.getPrice());


        System.out.println("\n///// Below are user-entered values://///");
        //get user input
        System.out.print("\nCode: ");
        cd = sc.nextLine();

        System.out.print("\nDescription: ");
        dsc = sc.nextLine();

        System.out.print("\nPrice: ");
        p = sc.nextDouble();


        Product v2 = new Product(cd, dsc, p);
        System.out.println("\nCode = " + v2.getCode());
        System.out.println("\nDescription = " + v2.getDescription());
        System.out.println("\nPrice = " + v2.getPrice());
        
    }
}