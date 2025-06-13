import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean continueProgram = true;

        while (continueProgram) {
            double miles = getValidInput(scanner, "Please enter miles: ", 1, 3000);
            double mph = getValidInput(scanner, "Please enter MPH: ", 1, 100);

            // Calculate travel time
            double travelTime = miles / mph;
            int hours = (int) travelTime;
            int minutes = (int) ((travelTime - hours) * 60);

            System.out.println("\nEstimated travel time: " + hours + " hr(s) " + minutes + " min(s)");

            // Ask user if they want to continue
            System.out.print("\nContinue? (y/n): ");
            String response = scanner.next().trim().toLowerCase();
            if (!response.equals("y")) {
                continueProgram = false;
            }
        }
        System.out.println("Program terminated.");
        scanner.close();
    }

    private static double getValidInput(Scanner scanner, String prompt, double min, double max) {
        double value;
        while (true) {
            System.out.print(prompt);
            if (scanner.hasNextDouble()) {
                value = scanner.nextDouble();
                if (value >= min && value <= max) {
                    return value;
                } else {
                    System.out.println("Value must be between " + min + " and " + max + ".");
                }
            } else {
                System.out.println("Invalid input -- must be a number.");
                scanner.next(); // Clear invalid input
            }
        }
    }
}
