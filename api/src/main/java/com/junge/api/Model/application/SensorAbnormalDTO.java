package com.junge.api.Model.application;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

// 방출용: 필요한 sensorDat만 뽑아서 보냄

@Getter
@Setter
public class SensorAbnormalDTO implements Serializable {
    private long id;
    private String deviceid;
    private String accelerator;
    private String pressure;
    private String temperature;
    private String noise_class;
    private String fault_message;
    private String address;
    private String region;


    public SensorAbnormalDTO(long id, String deviceid, String accelerator, String pressure, String temperature, String noise_class, String fault_message, String address, String region) {
        this.id = id;
        this.deviceid = deviceid;
        this.accelerator = accelerator;
        this.pressure = pressure;
        this.temperature = temperature;
        this.noise_class = noise_class;
        this.fault_message = fault_message;
        this.address = address;
        this.region = region;
    }
}


