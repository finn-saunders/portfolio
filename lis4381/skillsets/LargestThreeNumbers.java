import java.util.InputMismatchException;
import java.util.Scanner;

public class LargestThreeNumbers {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int num1 = 0, num2 = 0, num3 = 0;
        boolean validInput = false;

        System.out.println("Program evaluates largest of three integers.");
        System.out.println("Note: Program checks for integers and non-numeric values.\n");

        // First number input with validation
        while (!validInput) {
            System.out.print("Please enter first number: ");
            try {
                num1 = scanner.nextInt();
                validInput = true; // valid input
            } catch (InputMismatchException e) {
                System.out.println("Not valid integer!");
                System.out.print("Please try again. ");
                scanner.next(); // clear invalid input
            }
        }

        // Reset validation flag for the second number
        validInput = false;

        // Second number input with validation
        while (!validInput) {
            System.out.print("Please enter second number: ");
            try {
                num2 = scanner.nextInt();
                validInput = true; // valid input
            } catch (InputMismatchException e) {
                System.out.println("Not valid integer!");
                System.out.print("Please try again. ");
                scanner.next(); // clear invalid input
            }
        }

        // Reset validation flag for the third number
        validInput = false;

        // Third number input with validation
        while (!validInput) {
            System.out.print("Please enter third number: ");
            try {
                num3 = scanner.nextInt();
                validInput = true; // valid input
            } catch (InputMismatchException e) {
                System.out.println("Not valid integer!");
                System.out.print("Please try again. ");
                scanner.next(); // clear invalid input
            }
        }

        // Determine the largest number
        if (num1 >= num2 && num1 >= num3) {
            System.out.println("\nFirst number is largest.");
        } else if (num2 >= num1 && num2 >= num3) {
            System.out.println("\nSecond number is largest.");
        } else {
            System.out.println("\nThird number is largest.");
        }
    }
}
