package com.junge.api.Model.server;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RealTimeData {
    private String sensor_id;
    private double acc_x;
    private double acc_y;
    private double acc_z;
    private double temperature;
    private double pressure;
}
