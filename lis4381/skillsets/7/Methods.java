import java.util.Scanner;

public class Methods {

   public static void getRequirements() {
    System.out.println("Developer: Finn Saunders");
    System.out.println("Program prompts user for first name and age, then prints results.");
    System.out.println("Create four methods from the following requirements:");
    System.out.println("1) getRequirements(): Void method displays program requirements.");
    System.out.println("2) getUserInput(): Void method prompts for user input, then calls two methods.");
    System.out.println("3) myVoidMethod(): Accepts two arguments (String and int) and prints them.");
    System.out.println("4) myValueReturningMethod(): Accepts two arguments and returns them as a string.");
   }

   public static void getUserInput() {
      Scanner sc = new Scanner(System.in);
      
      // Getting input from user
      System.out.print("Enter first name: ");
      String firstName = sc.nextLine();
      
      System.out.print("Enter age: ");
      int age = sc.nextInt();
      
      // Call the methods
      myVoidMethod(firstName, age);
      String result = myValueReturningMethod(firstName, age);
      System.out.println("value-returning method call: " + result);
  }

  // Method to print the user's first name and age (void method)
  public static void myVoidMethod(String name, int age) {
      System.out.println("void method call: " + name + " is " + age);
  }

  // Method to return the user's first name and age as a string (value-returning method)
  public static String myValueReturningMethod(String name, int age) {
      return name + " is " + age;
  }
}