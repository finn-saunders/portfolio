import java.util.Scanner;
 
public class EvenOrOdd{

    public static void Main(String[] args) {
        System.out.println("Program evaluates integers as even or odd.");
        System.out.println("Note: Program does *not* check for non-numeric characters.\n");

        Scanner sc = new Scanner(System.in);

        // Infinite loop to continuously ask for input
        while (true) {
            evaluateNumber(sc);  // Call method to evaluate the number
        }
    }

    public static void evaluateNumber(Scanner sc) {
        int x = 0;
        System.out.print("Enter Integer: ");
        x = sc.nextInt();

        if (x % 2 == 0) {
            System.out.println(x + " is an even number.");
        } else {
            System.out.println(x + " is an odd number.");
        }
    }
}