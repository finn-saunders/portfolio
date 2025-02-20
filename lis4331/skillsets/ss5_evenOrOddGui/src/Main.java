import javax.swing.*;

public class Main {

    public static void main(String[] args) {

        JOptionPane.showMessageDialog(null,
            "Author: Finn Saunders\n" +
            "Program uses Java GUI message and input dialogs.\n" +
            "Program evaluates integers as even or odd.\n" +
            "Note: Program *does* perform data validation, prompting user until correct data entered.",
            "Program Info", JOptionPane.INFORMATION_MESSAGE);

        while (true) {
            String input = JOptionPane.showInputDialog(null,
                "Please enter Integer:");

            if (isInteger(input)) {
                int number = Integer.parseInt(input);

                String result = (number % 2 == 0) ? "even" : "odd";
                JOptionPane.showMessageDialog(null, number + " is an " + result + " number.");
                break;
            } else {
                JOptionPane.showMessageDialog(null, "Invalid input. Please enter a valid integer.",
                        "Error", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    private static boolean isInteger(String input) {
        try {
            Integer.parseInt(input);  // Try parsing the input as an integer
            return true;  // If successful, return true
        } catch (NumberFormatException e) {
            return false;  // If an exception is thrown, return false
        }
    }
}