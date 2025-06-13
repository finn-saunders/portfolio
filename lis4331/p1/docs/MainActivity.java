package com.example.musicapp;

import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import android.media.MediaPlayer;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {
    //declare variables
    private MediaPlayer mediaPlayer;
    private boolean isPlaying = false;
    private int lastPlayedSong = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        // action bar
        setTitle("Music App");
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayShowHomeEnabled(true);
            getSupportActionBar().setLogo(R.mipmap.ic_launcher);
            getSupportActionBar().setDisplayUseLogoEnabled(true);
        }


        // reference buttons
        Button btnLondon = findViewById(R.id.btnLondon);
        Button btnMessy = findViewById(R.id.btnMessy);
        Button btnSerenade = findViewById(R.id.btnSerenade);

        // Set click listeners
        btnLondon.setOnClickListener(v -> togglePlayPause(R.raw.last_trn_london, btnLondon));
        btnMessy.setOnClickListener(v -> togglePlayPause(R.raw.messy, btnMessy));
        btnSerenade.setOnClickListener(v -> togglePlayPause(R.raw.broken_wndw, btnSerenade));
    }

        private void togglePlayPause(int songResId, Button button) {

        // declare variables for play/pause functionality
            TextView txtLondon = findViewById(R.id.pLondon);
            TextView txtMessy = findViewById(R.id.pMessy);
            TextView txtSerenade = findViewById(R.id.pSerenade);

            Button btnLondon = findViewById(R.id.btnLondon);
            Button btnMessy = findViewById(R.id.btnMessy);
            Button btnSerenade = findViewById(R.id.btnSerenade);
            
            if (mediaPlayer != null && mediaPlayer.isPlaying() && lastPlayedSong == songResId) {
                // Pause if the same song is playing
                mediaPlayer.pause();
                isPlaying = false;

                // show all buttons when song is paused
                btnLondon.setVisibility(View.VISIBLE);
                btnMessy.setVisibility(View.VISIBLE);
                btnSerenade.setVisibility(View.VISIBLE);
                // set text when song is paused
                txtLondon.setText("PLAY");
                txtMessy.setText("PLAY");
                txtSerenade.setText("PLAY");

            } else {
                // If a different song is playing, stop it first
                if (mediaPlayer != null) {
                    mediaPlayer.release();
                }
                mediaPlayer = MediaPlayer.create(this, songResId);
                mediaPlayer.start();
                isPlaying = true;
                lastPlayedSong = songResId;

                if (button == btnLondon) {
                    btnMessy.setVisibility(View.GONE);
                    btnSerenade.setVisibility(View.GONE);
                    txtLondon.setText("PAUSE");
                    txtMessy.setText("");
                    txtSerenade.setText("");
                } else if (button == btnMessy) {
                    btnLondon.setVisibility(View.GONE);
                    btnSerenade.setVisibility(View.GONE);
                    txtMessy.setText("PAUSE");
                    txtLondon.setText("");
                    txtSerenade.setText("");
                } else if (button == btnSerenade) {
                    btnLondon.setVisibility(View.GONE);
                    btnMessy.setVisibility(View.GONE);
                    txtSerenade.setText("PAUSE");
                    txtMessy.setText("");
                    txtLondon.setText("");
                }
            }
        }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        if (mediaPlayer != null) {
            mediaPlayer.release();
            mediaPlayer = null;
        }
    }
}