import java.util.Scanner;

public class Methods {
    
    public static void getRequirements() {
        System.out.println("Developer: Finn Saunders");
        System.out.println("Program determines wheter user-entered value is vowel, consonant, special character, or integer.");
        System.out.println("Program displays character's ASCII value");

        System.out.println("\nReferences:/n"
        + "ASCII Background: https://en.wikipedia.org/wiki/ASCII\n" 
        + "ASCII Character table: https://www.ascii-code.com/\n"
        + "Lookup Tables: https://www.lookuptables.com/");
    }

    public static void determineChar() {
        //initialize variables
        char ch = ' ';
        char chTest = ' ';
        Scanner sc = new Scanner(System.in);

        System.out.print("Please enter character: ");
        ch = sc.next().charAt(0);
        chTest = Character.toLowerCase(ch);

        if (chTest == 'a' || chTest == 'e' || chTest == 'i' || chTest == 'o' || chTest == 'u' || chTest == 'y')
        {
            System.out.println(ch + " is vowel. ASCII value: " + (int) ch); // Cast char to int
        }
        // Test for numeric characters
        else if (ch >= '0' && ch <= '9')
        {
            System.out.println(ch + " is integer. ASCII value: " + (int) ch);
        }
        // Test for consonants (note: vowels captured above)
        else if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z'))
        {
            System.out.println(ch + " is consonant. ASCII value: " + (int) ch);
        }
        // Otherwise, must be a special character
        else
        {
            System.out.println(ch + " is special character. ASCII value: " + (int) ch);
        }
 
        sc.close(); // Close scanner
    }
}
