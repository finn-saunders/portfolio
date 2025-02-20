import java.util.Scanner;

public class Methods {
    
    public static void getRequirements(){
    System.out.println("Program determines if first number is multiple of second, prints result.\nExample: 2, 4, 6, 8 are multiples of 2.\n1)Use integers. 2) Use printf() function to print.");
    System.out.println("Must *only* permit integer entry");
    
    }

    public static void findMultipleNumbers()
    {
        //create scanner object and initialize variables
        Scanner sc = new Scanner (System.in);

        int num1 = 0;
        int num2 = 0;
        int valid = 0;
        int product = 0;

        System.out.print("Num1: ");
        while(!sc.hasNextInt())
        {
            System.out.println("Not valid integer!\n");
            sc.next();
            System.out.print("Please try again. Enter Num1 ");
        }
        num1 = sc.nextInt();

        System.out.print("Num2: ");
        while (!sc.hasNextInt())
        {
            System.out.println("Not valid integer!\n");
            sc.next();
            System.out.print("Please try again. Enter Num2: ");
        }
        num2 = sc.nextInt();

        //valid multiple number
        valid = num1 % num2;

        System.out.println();

        if (valid == 0)
        {
            product = num1 / num2;
            System.out.printf("%d is a multiple of %d\n", num1, num2);
            System.out.printf("The product of %d and %d is %d", product, num2, num1);
        }
        else {
            System.out.printf("%d is not a multiple of %d", num1, num2);
        }
            System.out.println();

            sc.close();
    }

    }
    
