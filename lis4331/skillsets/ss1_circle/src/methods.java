import java.util.Scanner;

public class methods {

public static void getRequirements(){
System.out.println("Author: Finn Saunders\nNon-oop program calculates diameter, circumference and circle area\nMust use Java's built-in PI constant, printf(), and formatted to 2 decimals.\nMust *only* permit numeric input");


}


public static void calculateCircle(){
    //initialize variables, create Scanner object
    Scanner sc = new Scanner (System.in);
    double radius = 0.0;

    System.out.println("Enter circle radius: ");
    while (!sc.hasNextDouble())
        {
            System.out.println("Not a valid number\n");
            sc.next();
            System.out.println("Please try again. Enter circle radius: ");
        }
    
    radius = sc.nextDouble();

    System.out.printf("\nCircle Diamter: %.2f\nCircumference: " + "%.2f\nArea: %.2f\n" ,
                    (2*radius),(2*Math.PI*radius), (Math.PI*radius*radius));
                    sc.close();


}

}
