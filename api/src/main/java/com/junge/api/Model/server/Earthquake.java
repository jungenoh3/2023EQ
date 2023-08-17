package com.junge.api.Model.server;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Earthquake implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private Timestamp update_time;
    private double lat;
    private double lng;
    private Timestamp event_occurred_msec;
    private Timestamp alert_created_msec;
    private List<String> associated_sensors;
    private String stage;
    private Long assoc_id;

    public Earthquake(Timestamp update_time, double lat, double lng, Timestamp event_occurred_msec, Timestamp alert_created_msec, List<String> associated_sensors, String stage, Long assoc_id) {
        this.update_time = update_time;
        this.lat = lat;
        this.lng = lng;
        this.event_occurred_msec = event_occurred_msec;
        this.alert_created_msec = alert_created_msec;
        this.associated_sensors = associated_sensors;
        this.stage = stage;
        this.assoc_id = assoc_id;
    }

//    public Earthquake(EarthquakeRaw earthquakeRaw) {
//        super(earthquakeRaw);
//    }
}
