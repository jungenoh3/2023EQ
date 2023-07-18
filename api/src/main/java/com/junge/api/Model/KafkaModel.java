package com.junge.api.Model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class KafkaModel {
    private Long sensor_id;
    private String address;
    private double value;
}
