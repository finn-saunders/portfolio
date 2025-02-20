import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class RandomIntegersLoopDemo {

    public static void main(String[] args) {
        // Print the minimum and maximum integer values
        System.out.println("Print minimum and maximum integer values.");
        System.out.println("Program prompts user to enter desired number of pseudorandom-generated integers (min 1).");
        System.out.println("Program validates user input for integers greater than 0.");
        System.out.println("Use following loop structures: for, enhanced for, while, do...while.\n");

        System.out.println("Integer.MIN_VALUE = " + Integer.MIN_VALUE);
        System.out.println("Integer.MAX_VALUE = " + Integer.MAX_VALUE);

        // Create a Scanner object for input
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();
        int numberOfIntegers = 0;

        // Validate user input
        while (true) {
            System.out.print("\nEnter desired number of pseudo-random integers (min 1): ");
            try {
                numberOfIntegers = scanner.nextInt();

                if (numberOfIntegers < 1) {
                    System.out.println("Number must be greater than 0. Please enter integer greater than 0.");
                } else {
                    break; // valid input, exit loop
                }
            } catch (InputMismatchException e) {
                System.out.println("Not valid integer! Please try again.");
                scanner.next(); // clear invalid input
            }
        }

        // Using 'for' loop
        System.out.println("\nfor loop:");
        for (int i = 0; i < numberOfIntegers; i++) {
            System.out.println(random.nextInt());
        }

        // Using 'enhanced for' loop (using an array of random numbers)
        int[] randomNumbers = new int[numberOfIntegers];
        for (int i = 0; i < numberOfIntegers; i++) {
            randomNumbers[i] = random.nextInt();
        }

        System.out.println("\nEnhanced for loop:");
        for (int num : randomNumbers) {
            System.out.println(num);
        }

        // Using 'while' loop
        System.out.println("\nwhile loop:");
        int count = 0;
        while (count < numberOfIntegers) {
            System.out.println(random.nextInt());
            count++;
        }

        // Using 'do...while' loop
        System.out.println("\ndo...while loop:");
        count = 0;
        do {
            System.out.println(random.nextInt());
            count++;
        } while (count < numberOfIntegers);
    }
}
