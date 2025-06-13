import java.util.Scanner;

class VehicleDemo
{
    public static void main(String[]args)
        {
            //initialize variables and create Scanner object
            String mk = "";
            String md = "";
            int yr = 0;
            float sp = 0.0f;
            Scanner sc = new Scanner(System.in);


            System.out.print("Author: Finn Saunders\n/////Below are default constructor values://///");
            Vehicle v1 = new Vehicle(); //create default object
            System.out.println("\nMake = " + v1.getMake());
            System.out.println("Model = " + v1.getModel());
            System.out.println("Year = " + v1.getYear());

            System.out.print("\n/////Below are user-entered values://///");

            //get user input
            System.out.print("\nMake: ");
            mk = sc.nextLine();

            System.out.print("Model: ");
            md = sc.nextLine();

            System.out.print("Year: ");
            yr = sc.nextInt();

            Vehicle v2 = new Vehicle(mk, md, yr);
            System.out.println("\nMake = " + v2.getMake());
            System.out.println("Model = " + v2.getModel());
            System.out.println("Year = " + v2.getYear());

            //System.out.println("\n/////Below using setter methods to pass literal values, then print() method to display values://///");
            //v2.setMake("Chevrolet");
            //v2.setModel("Corvette Z06");
            //v2.setYear(2023);
            //v2.print();

            System.out.print("\n/////Below are derived class default constructor values://///");
            Car c1 = new Car();
            System.out.println("\nMake = " + c1.getMake());
            System.out.println("Model = " + c1.getModel());
            System.out.println("Year = " + c1.getYear());
            System.out.println("Speed = " + c1.getSpeed());

            System.out.println("\nOr...");
            c1.print();

            System.out.print("\n/////Below are derived class user-entered values://///");

            //get user input
            System.out.print("\nMake: ");
            mk = sc.next();

            System.out.print("Model: ");
            md = sc.next();

            System.out.print("Year: ");
            yr = sc.nextInt();

            System.out.print("Speed: ");
            sp = sc.nextFloat();


            Car c2 = new Car(mk, md, yr, sp);
            System.out.println("\nMake = " + c2.getMake());
            System.out.println("Model = " + c2.getModel());
            System.out.println("Year = " + c2.getYear());
            System.out.println("Speed = " + c2.getSpeed());

            System.out.println("\nOr...");
            c2.print(); //overrides base class print() method
        }
}