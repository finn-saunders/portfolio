import java.util.Scanner;

public class Methods
{

    // Create Method without returning any value (without object)
    public static void getRequirements()
    {
        // Display operational messages
        System.out.println("Developer: Finn Saunders");
        System.out.println("Program Requirements: ");
        System.out.println("1. Create a string array (str1), based upon users\' number of preferred programming languages, limit 5.");
        System.out.println("2. Crete a second string array (str2) based upon the length of str1 array.");
        System.out.println("3. Copy str1 array elements into str2.");
        System.out.println("4. Print elements of both arrays using Java\'s *enhanced* for loop.\n");

        System.out.println(); // print blank line
    }

    //value-returning method (static requires no object)
    public static String[] createArray()
    {
        Scanner sc = new Scanner(System.in);
        int arraySize = 0;
        boolean valid = false; //begin with invalidation, then correct

        //loop until valid input (i.e., integer and between 1-5, inclusive)
        while(!valid)
            {
                System.out.print("\nHow many favorite programming languages do you have (min 1)? ");

                //loop until valid input (i.e., integer and between 1-5, inclusive)
                if (sc.hasNextInt())
                    {
                        arraySize = sc.nextInt();

                        //validate greater than 0, and less than or equal to 5
                        if (arraySize > 0 && arraySize <= 5)
                            {
                                valid = true; //valid input exit loop
                            }
                        else
                            {
                                System.out.println("Number must be between 1 and 5, inclusive. Please try again.");
                            }
                    }   else
                    {
                        System.out.println("Please enter valid integer.");
                        sc.next();
                    }
            }
            
            // Java style String[] myArray
            // C++ style String myArray[]
            String yourArray[] = new String[arraySize];
            return yourArray;
    }

        
    // nonvalue-returning method accepts int array arg (static requires no object)
    public static void copyArray(String[] str1)
    {
        Scanner sc = new Scanner(System.in);
        // populate array
        System.out.println("Please enter your " + str1.length + " favorite programming languages:");
        for (int i = 0; i < str1.length; i++)
            {
                str1[i] = sc.nextLine();
            }
        
        // set array size of
        String str2[] = new String[str1.length];

        // Copy all elements of one array into another
        // Enhanced for loop (requires counter)
        int myCounter=0;
        for(String myIterator: str1)
            {
                str2[myCounter++] = myIterator;
            }
        
        // Regular for loop
        // for (int i = 0; i < str1.length; i++)
        //      {
        //          str2[i] = str1[i];
        //      }

        // Print vertical space
        System.out.println();

        // Print arrays using enhanced for loop
        System.out.println("Printing str1 array:");
        for (String myIterator: str1)
            {
                System.out.println(myIterator);
            }

        System.out.println("\nPrinting str2 array:");
        for (String myIterator: str2)
            {
                System.out.println(myIterator);
            }

        // print vertical space
        System.out.println();

        sc.close(); //close scanner
    }
}