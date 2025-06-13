import java.util.Scanner;

public class Methods
{

    // Create Method without returning any value (without object)
    public static void getRequirements()
    {
        // Display operational messages
        System.out.println("Developer: Finn Saunders");
        System.out.println("Program Requirements:");
        System.out.println("1. Returns letter grade, based upon user-entered numeric score.");
        System.out.println("2. Program checks for non-numeric and out of range values.");
        System.out.println("Note: Program is accurate to 6th fraction digit (i.e., 6 digits right of decimal point).");

        System.out.println(); // print blank line
    }

    // nonvalue-returning method (static requires no object)
    public static void getScore()
    {
        // Initalize variables
        Scanner sc = new Scanner(System.in);
        double score = 0.0; //user-entered value

        // Prompt user
        // hasNextDouble(): returns true if next token in scanner's input can be interpreted as double value
        System.out.print("Please enter grade between 0 and 100, inclusive: ");
        while (!sc.hasNextDouble())
            {
                System.out.println("Not valid number!\n");
                sc.next(); // Important! If omitted, will go into infinite loop on invalid input!
                System.out.print("Please try again. Enter grade between 0 and 100, inclusive: ");
            }
        score = sc.nextDouble();
        getGrade(score);

        sc.close(); //close scanner
    }


    public static void getGrade(double score)
    {
        // Initialize variable
        String grade = "";

        if(score < 0 || score > 100)
            {
                System.out.println("\nOut of range!");
                //sc.next(); //Important! If omitted, will go into infinite loop on invalid input!
                getScore();
            }
        else
            {
                // FSU Grading scale:
                if (score < 60 && score >= 0)
                    grade = "F";
                
                    else if (score < 63 && score >=60)
                        grade = "D-";
                    else if (score < 67 && score >=63)
                        grade = "D";
                    else if (score < 70 && score >=67)
                        grade = "D+";
                    
                    else if (score < 73 && score >=70)
                        grade = "C-";
                    else if (score < 77 && score >=73)
                        grade = "C";
                    else if (score < 80 && score >=77)
                        grade = "C+";
                    
                    else if (score < 83 && score >=80)
                        grade = "B-";
                    else if (score < 87 && score >=83)
                        grade = "B";
                    else if (score < 90 && score >=87)
                        grade = "B+";
                    
                    else if (score < 93 && score >=90)
                        grade = "A-";
                    
                    else
                        grade = "A"; // Can't be anything else! :)
                    
                    //printf(): https://www.jquery-az.com/10-examples-learn-java-string-formatting-printf-method/
                    System.out.printf("\nScore entered: %f%n", score);
                    System.out.printf("Final grade: %s%n", grade);
            }
    }
}