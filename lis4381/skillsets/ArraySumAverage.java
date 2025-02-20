import java.util.InputMismatchException;
import java.util.Scanner;
import java.text.DecimalFormat;

public class ArraySumAverage {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int arraySize = 0;
        boolean validInput = false;

        System.out.println("1) Program creates array size at run-time.");
        System.out.println("2) Program displays array size.");
        System.out.println("3) Program rounds sum and average of numbers to two decimal places.");
        System.out.println("4) Numbers *must* be float data type, not double.\n");

        // Validate array size input
        while (!validInput) {
            System.out.print("Please enter array size: ");
            try {
                arraySize = scanner.nextInt();

                if (arraySize < 1) {
                    System.out.println("Array size must be greater than 0. Please try again.");
                } else {
                    validInput = true;
                }
            } catch (InputMismatchException e) {
                System.out.println("Not valid integer!");
                System.out.print("Please try again. ");
                scanner.next(); // clear invalid input
            }
        }

        System.out.println("Array size: " + arraySize);

        // Create the float array
        float[] numbers = new float[arraySize];

        // Get float numbers from user with validation
        for (int i = 0; i < arraySize; i++) {
            validInput = false;
            while (!validInput) {
                System.out.print("Enter num " + (i + 1) + ": ");
                try {
                    numbers[i] = scanner.nextFloat();
                    validInput = true; // valid input
                } catch (InputMismatchException e) {
                    System.out.println("Not valid number!");
                    System.out.print("Please try again. ");
                    scanner.next(); // clear invalid input
                }
            }
        }

        // Calculate the sum and average
        float sum = 0;
        for (float number : numbers) {
            sum += number;
        }
        float average = sum / arraySize;

        // Format the output to two decimal places
        DecimalFormat df = new DecimalFormat("0.00");

        // Display the numbers entered, sum, and average
        System.out.print("\nNumbers entered: ");
        for (float number : numbers) {
            System.out.print(number + " ");
        }

        System.out.println("\nSum: " + df.format(sum));
        System.out.println("Average: " + df.format(average));
    }
}
