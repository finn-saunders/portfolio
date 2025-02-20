package com.example.project1;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    // Flag to track if spinner was initialized
    private boolean isSpinnerInitialized = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        // Reference the spinner from xml
        Spinner nameSpinner = findViewById(R.id.txtGroup);


        // Set an OnItemSelectedListener for the Spinner
        nameSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener(){
            @Override
            // <?> means it can hold any type of data
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                // Check if spinner is initialized
                if (!isSpinnerInitialized) {
                    isSpinnerInitialized = true; // Marks spinner as initialized
                    return;
                }

                // Get the selected name from the spinner
                String selectedName = parent.getItemAtPosition(position).toString();

                // Ignores placeholder value
                if (selectedName.equals("Please select a contact")) {
                    return; // Does nothing if placeholder is selected
                }

                // Create an Intent to navigate to the Details Activity
                Intent intent = new Intent(MainActivity.this, Details.class);

                // Pass the selected name to the Details activity
                intent.putExtra("SELECTED_NAME", selectedName);

                // Start the Details activity
                startActivity(intent);

                // Reset spinner to placeholder to allow consecutive selections
                nameSpinner.post(new Runnable() { // Post ensures this happens after the current UI thread finishes
                    @Override
                    public void run() {
                        nameSpinner.setSelection(0); // Resets selection to placeholder
                    }
                });
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent){
            }
        });


        // Handle window insets
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}
