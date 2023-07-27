package com.junge.api.Model.server;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SensorData {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String deviceid;
    private double acc_x;
    private double acc_y;
    private double acc_z;
    private double temperature;
    private double pressure;
    private Timestamp update_time;
    private double latitude;
    private double longitude;
}
