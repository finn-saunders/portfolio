import javax.swing.*;

public class Main {
    public static void main(String[] args) {
        JOptionPane.showMessageDialog(
            null,
            "Developer: Finn Saunders\n" +
            "Program uses Java GUI messsage and input dialogs.\n" +
            "Program determines paint cost per room (i.e. \"area\").\n" +
            "For paint \"area\" simplicity: use length X height X 2 + width X height X 2.\n" +
            "Format numbers as per below: thousand separator, decimal point and $ sign for currency.\n" +
            "Research how many square feet a gallon of paint covers.\nNote: Program performs data validation."
        );

        String priceText = JOptionPane.showInputDialog(null, "Paint price per gallon:");

        while(!isNumber(priceText)){
            priceText = JOptionPane.showInputDialog(
                null,
                "Invalid integer. Please enter integer:",
                "Input",
                JOptionPane.QUESTION_MESSAGE
            );
        }
       
        double price = Double.parseDouble(priceText);

        String lengthText = JOptionPane.showInputDialog(null, "Length:");

        while(!isNumber(lengthText)){
            lengthText = JOptionPane.showInputDialog(
                null,
                "Invalid integer. Please enter integer:",
                "Input",
                JOptionPane.QUESTION_MESSAGE
            );
        }
       
        int length = Integer.parseInt(lengthText);

        String widthText = JOptionPane.showInputDialog(null, "Width:");

        while(!isNumber(widthText)){
            widthText = JOptionPane.showInputDialog(
                null,
                "Invalid integer. Please enter integer:",
                "Input",
                JOptionPane.QUESTION_MESSAGE
            );
        }
       
        int width = Integer.parseInt(widthText);

        String heightText = JOptionPane.showInputDialog(null, "Height:");

        while(!isNumber(heightText)){
            heightText = JOptionPane.showInputDialog(
                null,
                "Invalid integer. Please enter integer:",
                "Input",
                JOptionPane.QUESTION_MESSAGE
            );
        }
       
        int height = Integer.parseInt(heightText);

        double area = (length * height * 2) + (width * height * 2);
        double total = (area/350) * price;

        JOptionPane.showMessageDialog(
            null,
            String.format("Paint = $%,.2f per gallon.\nArea of room = %,.2fsq ft.\nTotal = $%,.2f", price, area, total)
        );
    }

    private static boolean isNumber(String n) {
        try {
            Integer.parseInt(n);
            return true;
        } catch (NumberFormatException nfe) {
            return false;
        }
    }
}