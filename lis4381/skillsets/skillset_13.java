import java.util.Scanner;

public class skillset_13 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        final double GALLONS_CONVERSION = 0.004329; // Conversion factor to liquid US gallons
        String continueCalculation;

        System.out.println("Programmer: Finn Saunders");
        System.out.println("Sphere Volume Program");
        System.out.println("Program calculates sphere volume in liquid U.S. gallons from user-entered diameter value in inches, and rounds to two decimal places.");
        System.out.println("Must use Java's *built-in* PI and pow() capabilities.");
        System.out.println("Program checks for non-integers and non-numeric values.");
        System.out.println("Program continues to prompt for user entry until no longer requested, prompt accepts upper or lower case letters.\n");

        do {
            int diameter = 0;
            boolean validInput = false;

            while (!validInput) {
                System.out.print("Please enter diameter in inches: ");
                String input = scanner.nextLine();

                // Validate input as an integer
                try {
                    diameter = Integer.parseInt(input); // Parse input as an integer
                    if (diameter <= 0) {
                        System.out.println("Diameter must be greater than 0. Please try again.");
                    } else {
                        validInput = true; // Input is valid
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Not valid integer!");
                }
            }

            // Calculate the sphere volume
            double radius = diameter / 2.0;
            double volumeInCubicInches = (4.0 / 3.0) * Math.PI * Math.pow(radius, 3);
            double volumeInGallons = volumeInCubicInches * GALLONS_CONVERSION;

            // Display the result
            System.out.printf("Sphere volume: %.2f liquid U.S. gallons%n", volumeInGallons);

            // Ask if the user wants to calculate another sphere volume
            System.out.print("Do you want to calculate another sphere volume (y or n)? ");
            continueCalculation = scanner.nextLine().trim().toLowerCase();

        } while (continueCalculation.equals("y"));

        System.out.println("\nThank you for using our Sphere Volume Calculator!");
        scanner.close();
    }
}
