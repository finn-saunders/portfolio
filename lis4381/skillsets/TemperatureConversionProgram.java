import java.util.Scanner;

public class TemperatureConversionProgram {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Temperature Conversion Program");
        System.out.println("\nProgram converts user-entered temperatures into Fahrenheit or Celsius scales.");
        System.out.println("Program continues to prompt for user entry until no longer requested.");
        System.out.println("Note: upper or lower case letters permitted. Though, incorrect entries are not permitted.");
        System.out.println("Note: Program does not validate numeric data (optional requirement).\n");

        while (true) {
            System.out.print("Do you want to convert a temperature (y or n)? ");
            String continueChoice = scanner.nextLine().trim().toLowerCase();

            if (continueChoice.equals("n")) {
                break;  // Exit the loop if the user chooses "n"
            } else if (!continueChoice.equals("y")) {
                System.out.println("Invalid input. Please enter 'y' or 'n'.");
                continue;  // Re-prompt if invalid input is entered
            }

            // Prompt user for conversion type
            String conversionType;
            while (true) {
                System.out.print("\nFahrenheit to Celsius? Type \"f\", or Celsius to Fahrenheit? Type \"c\": ");
                conversionType = scanner.nextLine().trim().toLowerCase();

                if (conversionType.equals("f") || conversionType.equals("c")) {
                    break;  // Valid input, exit inner loop
                } else {
                    System.out.println("Incorrect entry. Please try again.");
                }
            }

            // Prompt for temperature input and perform the conversion
            System.out.print("Enter temperature in " + (conversionType.equals("f") ? "Fahrenheit" : "Celsius") + ": ");
            double temperature = scanner.nextDouble();
            scanner.nextLine();  // Consume the newline character

            // Perform and display the conversion
            if (conversionType.equals("f")) {
                double celsius = (temperature - 32) * 5 / 9;
                System.out.println("Temperature in Celsius = " + celsius);
            } else {
                double fahrenheit = (temperature * 9 / 5) + 32;
                System.out.println("Temperature in Fahrenheit = " + fahrenheit);
            }

            System.out.println();  // Blank line for readability
        }

        System.out.println("\nThank you for using our Temperature Conversion Program!");
        scanner.close();
    }
}
