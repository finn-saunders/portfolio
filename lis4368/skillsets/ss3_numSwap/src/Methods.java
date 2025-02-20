import java.util.Scanner;

public class Methods {

    public static void getRequirements()
    {
        System.out.println("Author: Finn Saunders");
        System.out.println("Program Requirements:");
        System.out.println("1. Program swaps two user-entered floating-point values.");
        System.out.println("2. Create at least two user-defined methods: getRequirements() and numberSwap().");
        System.out.println("3. Must perfom data validation: numbers must be floats.");
        System.out.println("4. Print numbers before/after swapping.");
    }

    public static void numberSwap()
    {
        Scanner sc = new Scanner(System.in);
        float num1 = 0.0f;
        float num2 = 0.0f;
        float temp = 0.0f;

        //prompt user
        System.out.print("Enter num1: ");
        while (!sc.hasNextFloat())  //validates data
        {
            System.out.println("Invalid input\n");  //error message
            sc.next();
            System.out.print("Please try again, Enter num1: ");   //prompts user for re-entry
        }
        num1 = sc.nextFloat();  //accepts valid input

        System.out.print("Enter num2: ");
        while (!sc.hasNextFloat())
        {
            System.out.println("Invalid input\n");  //error message
            sc.next();
            System.out.print("Please try again, Enter num2: ");   //prompts user for re-entry
        }
        num2 = sc.nextFloat();  //accepts valid input

        System.out.println("\nBefore swap:");
        System.out.println("num1 = " + num1);
        System.out.println("num2 = " + num2);

        temp = num1;    //temporary variable holding num1
        num1 = num2;    //num1 takes num2 value
        num2 = temp;    //num2 takes the num1 value stored in temp

        System.out.println("After swap:");
        System.out.println("num1 = " + num1);
        System.out.println("num2 = " + num2);
    }

}
