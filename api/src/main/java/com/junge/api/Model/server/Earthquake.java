package com.junge.api.Model.server;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Earthquake {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private double latitude;
    private double longitude;
    private Timestamp update_time;
    private double magnitude;

    public Earthquake(double latitude, double longitude, Timestamp update_time, double magnitude) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.update_time = update_time;
        this.magnitude = magnitude;
    }
}
