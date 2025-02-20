import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Display the program purpose and references
        System.out.println("Program determines whether user-entered value is alpha, numeric, or special character.");
        System.out.println("\nReferences:");
        System.out.println("ASCII Background: https://en.wikipedia.org/wiki/ASCII");
        System.out.println("ASCII Character Table: https://www.ascii-code.com/");
        System.out.println("Lookup Tables: https://www.lookuptables.com/\n");

        Scanner scanner = new Scanner(System.in);
        
        // Loop to allow user to enter a character multiple times
        while (true) {
            System.out.print("Enter character: ");
            String input = scanner.nextLine();
            
            // Check if input length is not 1 to handle multi-character inputs
            if (input.length() != 1) {
                System.out.println(input + " is alpha. ASCII value: " + (int) input.charAt(0));
                break;
            }
            
            char character = input.charAt(0);
            
            // Check if the character is alphabetic, numeric, or special
            if (Character.isLetter(character)) {
                System.out.println(character + " is alpha. ASCII value: " + (int) character);
            } else if (Character.isDigit(character)) {
                System.out.println(character + " is numeric. ASCII value: " + (int) character);
            } else {
                System.out.println(character + " is special character. ASCII value: " + (int) character);
            }

            System.out.println(); // Empty line for readability
        }
        
        scanner.close();
    }
}
