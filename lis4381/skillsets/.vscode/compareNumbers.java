import java.util.Scanner;

public class compareNumbers {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);

    
System.out.print("Enter the first number: ");
int firstNumber = sc.nextInt();

System.out.print("Enter the second number: ");
int secondNumber = sc.nextInt();

if (firstNumber > secondNumber) {
     System.out.println(firstNumber + " is larger than " + secondNumber);
} else if (firstNumber < secondNumber) {
    System.out.println(secondNumber + " is larger than " + firstNumber);
} else {
    System.out.println(firstNumber + " is equal to " + secondNumber);
}
sc.close();
}
}