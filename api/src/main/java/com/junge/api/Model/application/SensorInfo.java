package com.junge.api.Model.application;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serial;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SensorInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String deviceid;
    private double latitude;
    private double longitude;
    private String address;
    private String manu_comp;
    private String facility;
    private String level;


}