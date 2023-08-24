package com.junge.api.model.earthquake;

import jakarta.persistence.MappedSuperclass;
import lombok.*;

import java.sql.Timestamp;
import java.util.List;

// 사용 X

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@MappedSuperclass
public class EarthquakeRaw {
    private double lat;
    private double lng;
    private Timestamp event_occurred_msec;
    private Timestamp alert_created_msec;
    private List<String> associated_sensors;
    private String stage;
    private Long assoc_id;
    // private List<Map<String, Map<String, Objects>>> associated_sensors_details;

    public EarthquakeRaw(EarthquakeRaw earthquakeRaw) {
        this.lat = earthquakeRaw.lat;
        this.lng = earthquakeRaw.lng;
        this.event_occurred_msec = earthquakeRaw.event_occurred_msec;
        this.alert_created_msec = earthquakeRaw.alert_created_msec;
        this.associated_sensors = earthquakeRaw.associated_sensors;
        this.stage = earthquakeRaw.stage;
        this.assoc_id = earthquakeRaw.assoc_id;
    }
}
