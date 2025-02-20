import java.util.Scanner;

public class CompareNumbersDemo {
    public static void main(String[] args) {
        // Create a Scanner object to take input from the user
        Scanner sc = new Scanner(System.in);

        // Prompt the user to enter the first integer
        System.out.print("Enter the first integer: ");
        int firstNumber = sc.nextInt();

        // Prompt the user to enter the second integer
        System.out.print("Enter the second integer: ");
        int secondNumber = sc.nextInt();

        // Compare the two numbers and print the result
        if (firstNumber > secondNumber) {
            System.out.println(firstNumber + " is larger than " + secondNumber);
        } else if (firstNumber < secondNumber) {
            System.out.println(secondNumber + " is larger than " + firstNumber);
        } else {
            System.out.println("Both numbers are equal.");
        }

        // Close the scanner to avoid resource leaks
        sc.close();
    }
}
