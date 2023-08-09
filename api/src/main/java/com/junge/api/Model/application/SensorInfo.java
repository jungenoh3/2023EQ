package com.junge.api.Model.application;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SensorInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    private String deviceid;
    private double latitude;
    private double longitude;
    private String address;
    private String manu_comp;
    private String facility;
    private String level;
    private String etc;
    private String region;

}