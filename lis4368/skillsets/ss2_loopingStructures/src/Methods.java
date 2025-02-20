public class Methods {

    public static void getRequirements()
    {
        System.out.println("Author: Finn Saunders");
        System.out.println("Program loops through array of floats.");
        System.out.println("Use following values: 1.0, 2.1, 3.2, 4.3, 5.4");
        System.out.println("Use following loop structures: for, enhanced for, while, do...while.");
    }

    public static void arrayLoops()
    {
        //populate array upon creation
        float myFloats[] = {1.0f, 2.1f, 3.2f, 4.3f, 5.4f};

        System.out.println("for loop:");
        for(int i = 0; i < myFloats.length; i++)
        {
            System.out.println(myFloats[i]);
        }

        System.out.println("\nEnhanced loop:");
        for(float test : myFloats)
        {
            System.out.println(test);
        }

        System.out.println("\nwhile loop:");
        int i = 0;
        while (i < myFloats.length)
        {
            System.out.println(myFloats[i]);
            i++;
        }

        i=0;
        System.out.println("\ndo...while loop:");
        do
        {
            System.out.println(myFloats[i]);
            i++;
        }
        while (i < myFloats.length);
    }
    
}
