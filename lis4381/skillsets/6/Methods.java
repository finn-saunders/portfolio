import java.util.Random;
import java.util.Scanner;

public class Methods {

   public static void getRequirements() {
      System.out.println("Developer: Finn Saunders");
      System.out.println("Print mininum and maximum interger values.");
      System.out.println("Program prompts to enter desired number of pseudorandom-generated integers(min1).");
      System.out.println("Use following loop structurres: for, enhanced for, while, do while."); 
      //System.out.println("Note: Pretest loops: for, enhanced for, while: Postest loop: do...while.");
   }

   public static int[] createArray() {
      Scanner sc = new Scanner(System.in);
      int arraySize = 0;

      System.out.println("\nInteger.MIN_VALUE=" + Integer.MIN_VALUE);
      System.out.println("Integer.MAX_VALUE=" + Integer.MAX_VALUE);

      // Prompt user for number of randomly generated numbers
      System.out.print("\nEnter desired number of pseudorandom integers (min 1): ");
      arraySize = sc.nextInt();

      // Create array with user-specified size
      int[] yourArray = new int[arraySize];
      return yourArray;
  }

  // Non-value-returning method that accepts an int array argument (static requires no object)
  public static void generatePseudoRandomNumbers(int[] myArray) {
      Random r = new Random(); // Instantiate random object variable

      // Generate random numbers using different types of loops

      // For loop
      System.out.println("For loop:");
      for (int i = 0; i < myArray.length; i++) {
          myArray[i] = r.nextInt(); 
          System.out.println(myArray[i]);
      }

      // Enhanced for loop
      System.out.println("\nEnhanced for loop:");
      for (int n : myArray) {
          System.out.println(n);
      }

      // While loop
      System.out.println("\nWhile loop:");
      int i = 0;
      while (i < myArray.length) {
          myArray[i] = r.nextInt();
          System.out.println(myArray[i]);
          i++;
      }

      // Do-while loop
      System.out.println("\nDo-while loop:");
      i = 0;
      do {
          myArray[i] = r.nextInt();
          System.out.println(myArray[i]);
          i++;
      } while (i < myArray.length);
  }


}