import java.util.Scanner;

public class Methods {

    public static void getRequirements()
    {
        System.out.println("Author: Finn Saunders");
        System.out.println("Program counts, totals, and averages total number of user-entered exam scores.");
        System.out.println("Please enter exam scores between 0 and 100, inclusive.");
        System.out.println("Enter out of range number to end program.");
        System.out.println("Must *only* permit numeric entry.");
    }

    public static void thisMethod() {
        Scanner sc = new Scanner(System.in);
        int score = 0;           // Stores the current score
        int count = 0;           // Tracks the number of valid scores
        int total = 0;           // Tracks the sum of valid scores
    
        System.out.print("Enter exam score: ");
        while (true) {
            if (sc.hasNextInt()) {
                score = sc.nextInt();
    
                // Check for termination condition
                if (score < 0 || score > 100) {
                    break; // Exit the loop if score is out of range
                }
    
                // Add valid score to the total and increment count
                total += score;
                count++;
    
                // Prompt for the next score
                System.out.print("Enter exam score: ");
            } else {
                // Handle invalid (non-integer) input
                System.out.println("Not a valid number! Please try again.");
                sc.next(); // Clear invalid input
                System.out.print("Enter exam score: ");
            }
        }
    
        // Print the results after the loop
        System.out.println("\nCount: " + count);
        System.out.println("Total: " + total);
    
        // Calculate and display the average
        if (count > 0) {
            double average = (double) total / count;
            System.out.println("Average: " + average);
        } else {
            System.out.println("No valid scores entered.");
        }
    
        sc.close(); // Close the scanner
    }
    

}
