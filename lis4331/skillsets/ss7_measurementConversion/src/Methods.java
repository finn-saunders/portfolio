import java.util.Scanner;

public class Methods {

    public static void getRequirements() {
        System.out.println("Program converts inches to centimeters, meters, feet, yards, and miles.");

        System.out.println("\n***** Notes *****");
        System.out.println("\n1) Use Integer for inches (must validate integer input).");
        System.out.println("\n2) Use printf() function to print (format values per below output).");
        System.out.println("\n3) Create Java \"constants\" for the following values:");
        System.out.println("\n   INCHES_TO_CENTIMETER,");
        System.out.println("   INCHES_TO_METER,");
        System.out.println("   INCHES_TO_FOOT,");
        System.out.println("   INCHES_TO_YARD,");
        System.out.println("   FEET_TO_MILE\n");
    }

    public static void measurementConversion() {
        // Measurement conversion:
        // Inch to meters = inch * 0.0254
    
        int inches = 0;
        double centimeters = 0.0;
        double meters = 0.0;
        double feet = 0.0;
        double yards = 0.0;
        double miles = 0.0;
    
        // Constants
        final double INCHES_TO_CENTIMETER = 2.54;
        final double INCHES_TO_METER = 0.0254;
        final double INCHES_TO_FOOT = 1.0 / 12.0;
        final double INCHES_TO_YARD = 1.0 / 36.0;
        final double FEET_TO_MILE = 1.0 / 5280.0;
    
        Scanner input = new Scanner(System.in);
    
        System.out.print("Please enter number of inches: ");
        
        while (!input.hasNextInt()) {
            System.out.println("Not a valid integer!");
            System.out.print("Please enter a valid integer: ");
            input.next(); // Clear the invalid input
        }
    
        inches = input.nextInt();
    
        centimeters = inches * INCHES_TO_CENTIMETER;
        meters = inches * INCHES_TO_METER;
        feet = inches * INCHES_TO_FOOT;
        yards = inches * INCHES_TO_YARD;
        miles = feet * FEET_TO_MILE;
    
        System.out.printf("%d inches equals:\n%.6f feet\n%.6f yards\n%.6f centimeters\n%.6f meters\n%.6f miles\n", 
                          inches, feet, yards, centimeters, meters, miles);
    }
    
}