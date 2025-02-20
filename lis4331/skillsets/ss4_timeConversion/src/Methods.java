import java.util.Scanner;

public class Methods {

    public static void getRequirements(){
        System.out.println("Developer: Finn Saunders");
        System.out.println("Program converts seconds to minutes, hours, days, weeks, and (regular) years --365 days");
        System.out.println("***Notes***:\n" + 
        "1. Use integer for seconds (must validate integer input)\n" + 
        "2. Use printf() function to print (format values per below output).\n" +
        "3. Create Java 'constants' for the followingvalues:\n" +
        "SECS_IN_MINS,\n" + "MINS_IN_HR,\n" + "HRS_IN_DAY,\n" + "DAYS_ IN WEEK,\n" +
        "DAYS_IN_YR (365 days)");
    }

    public static void convertTime() {
        //initializing variables
        int seconds = 0;
        double minutes = 0.0;
        double hours = 0.0;
        double days = 0.0;
        double weeks = 0.0;
        double years = 0.0;

        //constants
        final double SECS_IN_MINS = 60;
        final double MINS_IN_HR = 60;
        final double HRS_IN_DAY = 24;
        final double DAYS_IN_WEEK = 7;
        final double DAYS_IN_YEAR = 365;

        //init scanner
        Scanner sc = new Scanner(System.in);

        // take input
        System.out.print("Please enter number of seconds: ");
        while(!sc.hasNextInt()) {
            System.out.println("Not a valid integer\n");
            sc.next();
            System.out.print("Please enter number of seconds: ");
        }

        seconds = sc.nextInt();

        //process
        minutes = seconds / SECS_IN_MINS;
        hours = minutes / MINS_IN_HR;
        days = hours / HRS_IN_DAY;
        weeks = days / DAYS_IN_WEEK;
        years = days / DAYS_IN_YEAR;

        //output
        System.out.printf("%,d second(s) equals\n\n%,.2f minute(s)\n%,.3f hour(s)\n%,.4f day(s)\n%,.5f week(s)\n%,.6f year(s)\n", seconds, minutes, hours, days, weeks, years);
    
    }
}
