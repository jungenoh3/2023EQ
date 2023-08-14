package com.junge.api.Model.server;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EarthquakeProjection implements Serializable, EarthquakeSpecific {
    private Long id;
    private double lat;
    private double lng;
    private Timestamp update_time;
    private Long assoc_id;
}
