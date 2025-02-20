package com.example.project1;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class Details extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_details);

        // Retrieve the name from the Intent
        String selectedName = getIntent().getStringExtra("SELECTED_NAME");

        // Update the name in the title
        TextView titleTextView = findViewById(R.id.txtTitle2);
        titleTextView.setText(selectedName);

        // Update contact image
        ImageView profileImageView = findViewById(R.id.contactImage);

        // Map names to images
        int imgProfile = 0;
        if (selectedName.equals("Finn Saunders")) {
            imgProfile = R.drawable.brick_suit_headshot;
        } else if (selectedName.equals("Lebron James")) {
            imgProfile = R.drawable.lebron_james;
        } else if (selectedName.equals("Michael Jordan")) {
            imgProfile = R.drawable.michael_jordan;
        } else if (selectedName.equals("Dylan Skinner")) {
            imgProfile = R.drawable.dylan_skinner;
        }

        // set the image to imageview
        profileImageView.setImageResource(imgProfile);


        // Determine contact info based on the selected name
        String contactInfo;
        if (selectedName.equals("Finn Saunders")){
            contactInfo = "Finn's Phone: 305-395-0040\nEmail: fcs23a@fsu.edu";
        } else if (selectedName.equals("Lebron James")) {
            contactInfo = "Lebron's Phone: 305-236-2003\nEmail: Finalsmvp@nba.com";
        } else if (selectedName.equals("Michael Jordan")) {
            contactInfo = "Michael's Phone: 872-623-1996\nEmail: 6rings@goat.com";
        } else if (selectedName.equals("Dylan Skinner")) {
            contactInfo = "Dylan's phone: 850-382-8392\nEmail: dylanskin@fsu.edu";
        }
         else {
            contactInfo = ("Please choose a person.");
        }

        // Display the contact information in a TextView
        TextView contactTextView = findViewById(R.id.txtContactInfo);
        contactTextView.setText(contactInfo);



        // Handle window insets
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}
