import java.util.ArrayList;
import java.util.Scanner;

public class ArrayListDemo {
    public static void main(String[] args) {
        // Initialize an ArrayList to store animal types
        ArrayList<String> animals = new ArrayList<>();
        Scanner scanner = new Scanner(System.in);

        // Display initial program instructions
        System.out.println("Program populates ArrayList of strings with user-entered animal type values.");
        System.out.println("Examples: Polar bear, Guinea pig, dog, cat, bird.");
        System.out.println("Program continues to collect user-entered values until user types \"n\".");
        System.out.println("Program displays ArrayList values after each iteration, as well as size.");

        // Loop to collect user inputs
        while (true) {
            System.out.print("\nEnter animal type: ");
            String animalType = scanner.nextLine();
            animals.add(animalType);  // Add user input to ArrayList

            // Display the current contents of the ArrayList and its size
            System.out.println("ArrayList elements: " + animals);
            System.out.println("ArrayList Size = " + animals.size());

            // Ask if the user wants to continue
            System.out.print("Continue? Enter y or n: ");
            String continueInput = scanner.nextLine().toLowerCase();

            // Exit the loop if the user types "n"
            if (continueInput.equals("n")) {
                break;
            }
        }

        scanner.close();
        System.out.println("\nProgram ended.");
    }
}
