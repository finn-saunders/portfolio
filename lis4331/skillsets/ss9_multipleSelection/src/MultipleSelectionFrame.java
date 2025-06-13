import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.ListSelectionModel;

public class MultipleSelectionFrame extends JFrame {
    private JList<String> burgerList; // Left-hand list
    private JList<String> copyList; // Right-hand list
    private JButton copyButton; // Button to copy items

    private static final String[] burgerNames = {
        "Mushroom", "Onion and Cheese", "Red Pepper and Bacon", 
        "Italian", "Lip Smacker", "Texan", "Californian", 
        "Chili", "Bleu Cheese", "Fried Egg"
    };

    public MultipleSelectionFrame() {
        super("Multiple Selection Lists");
        setLayout(new FlowLayout());

        // Left-hand list (Multiple selection enabled)
        burgerList = new JList<>(burgerNames);
        burgerList.setVisibleRowCount(5);
        burgerList.setFixedCellWidth(140);
        burgerList.setFixedCellHeight(15);
        burgerList.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        add(new JScrollPane(burgerList)); // Add scrollpane

        // Button to copy selected items
        copyButton = new JButton("Copy >>>");
        copyButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent event) {
                // Copy selected items
                copyList.setListData(burgerList.getSelectedValuesList().toArray(new String[0]));
            }
        });
        add(copyButton);

        // Right-hand list (Single selection enabled)
        copyList = new JList<>();
        copyList.setVisibleRowCount(5);
        copyList.setFixedCellWidth(140);
        copyList.setFixedCellHeight(15);
        copyList.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);
        add(new JScrollPane(copyList)); // Add scrollpane
    }
}
