package com.junge.api.configure;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.*;
import com.google.firebase.messaging.FirebaseMessaging;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;

@Configuration
public class FirebaseConfigure {

    private FirebaseApp firebaseApp;

    @PostConstruct
    public void initializeFirebaseApp() {
        try {
            GoogleCredentials googleCredentials = GoogleCredentials
                    .fromStream(new ClassPathResource("serviceAccountKey.json").getInputStream());
            FirebaseOptions firebaseOptions = FirebaseOptions
                    .builder()
                    .setCredentials(googleCredentials)
                    .setDatabaseUrl("https://eq-64f1a-default-rtdb.firebaseio.com/")
                    .build();
            firebaseApp = FirebaseApp.initializeApp(firebaseOptions, "[DEFAULT]");
        } catch (IOException e) {
            // Handle the exception properly, log it, or throw a custom exception.
            e.printStackTrace();
        }
    }

    @Bean
    FirebaseMessaging firebaseMessaging() {
        return FirebaseMessaging.getInstance(firebaseApp);
    }

    @Bean
    FirebaseDatabase firebaseDatabase() {
        return FirebaseDatabase.getInstance(firebaseApp);
    }
}




