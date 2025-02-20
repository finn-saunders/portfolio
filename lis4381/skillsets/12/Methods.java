import java.util.Scanner;

public class Methods {
    public static void getRequirements(){
        System.out.println("Program determines whether user-entered value is alpha, numeric, or special character.");
        System.out.println("\nReferences:");
        System.out.println(" * ASCII Background: https://en.wikipedia.org/wiki/ASCII");
        System.out.println(" * ASCII Character Table: https://www.ascii-code.com/");
        System.out.println(" * Lookup Tables: https://www.lookuptables.com/\n");

        System.out.println(); // print blank line
    }

    // Non-value-returning method (static requires no object)
    public static void determineChar() {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter character: ");
        char ch = sc.next().charAt(0); // capture first character from input

        // Test for alpha characters
        if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
            System.out.println(ch + " is alpha. ASCII value: " + (int) ch); // cast char to int
        }
        // Test for numeric characters
        else if (ch >= '0' && ch <= '9') {
            System.out.println(ch + " is numeric. ASCII value: " + (int) ch);
        }
        // Otherwise, must be a special character
        else {
            System.out.println(ch + " is special character. ASCII value: " + (int) ch);
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        getRequirements();

        // Loop to repeatedly prompt for input until user decides to stop
        while (true) {
            determineChar();

            System.out.print("Do you want to enter another character? (y/n): ");
            String response = sc.next().trim().toLowerCase();

            if (response.equals("n")) {
                System.out.println("Thank you for using the program!");
                break; // Exit the loop if user enters "n"
            } else if (!response.equals("y")) {
                System.out.println("Invalid input. Please enter 'y' or 'n'.");
            }
        }

        sc.close(); // Close the scanner to prevent resource leaks
    }
}
